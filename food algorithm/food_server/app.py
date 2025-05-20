import os
from flask import Flask, request, jsonify
from flask_cors import CORS
from utils.predict import predict_image
from utils.metadata import extract_metadata
from utils.predict import save_user_prediction
from utils.places import get_nearby_places
from utils.recommender.recommender import recommend_foods
from utils.recommender.food_data import food_list
from utils.recommender.user_info import sample_user_info
import requests
from flask import request
from utils.classify_food import classify_food

# 업로드된 이미지 저장 폴더
UPLOAD_FOLDER = 'uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    return '🔥 Food Classifier + Metadata Extractor API is running!'

@app.route('/predict', methods=['POST'])
def predict():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'}), 400

    image = request.files['image']
    image_path = os.path.join(UPLOAD_FOLDER, image.filename)
    image.save(image_path)

    # 예측 결과
    prediction = predict_image(image_path)


    # 메타데이터 추출
    metadata = extract_metadata(image_path)
    # nearby places on that location
    nearby_places = get_nearby_places(metadata["location"])
    metadata["nearby_places"] = nearby_places
    # ChatGPT 분류 (90% 이상 확률일 경우만)
    top_food = prediction[0]
    if top_food["probability"] >= 0.9:
        attributes = classify_food(top_food["label"])
        metadata["attributes"] = attributes
    else:
        metadata["attributes"] = None
    # 사용자 ID (나중에 동적으로 받을 수 있도록 개선 가능)
    user_id = "user_A"
    # 사용자별 저장
    save_user_prediction(user_id, prediction, metadata)

    print("✅ Metadata 저장 완료")
    print("🍽 근처 장소들:")
    print(metadata.get("nearby_places"))


    return jsonify({
        "prediction": prediction,
        "metadata": metadata
    })

@app.route('/recommend', methods=['GET'])
def recommend():
    top_n = int(request.args.get("top_n", 3))
    recommendations = recommend_foods(food_list, sample_user_info, top_n=top_n)
    return jsonify({
        "recommendations": recommendations
    })
@app.route('/weather', methods=['POST'])
def get_weather():
    data = request.get_json()
    lat = data.get('latitude')
    lon = data.get('longitude')

    if not lat or not lon:
        return jsonify({'error': 'Invalid coordinates'}), 400

    # OpenWeather API 사용 예시
    OPENWEATHER_API_KEY = "6f9087f5e8a25f649c334326d5562b1b"
    weather_url = (
        f"https://api.openweathermap.org/data/2.5/weather?"
        f"lat={lat}&lon={lon}&appid={OPENWEATHER_API_KEY}&units=metric&lang=kr"
    )

    try:
        response = requests.get(weather_url)
        weather_data = response.json()

        result = {
            "weather": weather_data["weather"][0]["main"],  # 예: Clear, Rain
            "temperature": weather_data["main"]["temp"],     # 섭씨 온도
            "location_name": weather_data["name"]            # 도시 이름
        }
        return jsonify(result)

    except Exception as e:
        print("🌧 날씨 API 오류:", e)
        return jsonify({"error": "Weather fetch failed"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5050, debug=True)
