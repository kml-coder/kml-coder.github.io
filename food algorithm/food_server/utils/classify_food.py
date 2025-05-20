from huggingface_hub import InferenceClient
import json

# 모델 선택 (HuggingFace에서 지원하는 모델 중 하나)
client = InferenceClient(model="HuggingFaceH4/zephyr-7b-beta")  # 또는 "mistralai/Mistral-7B-Instruct-v0.1"

def classify_food(name):
    prompt = f"""
You are a food classification expert.

Classify the food name: "{name}" into the following categories as a JSON object.

Do NOT provide explanations, examples, markdown, or any extra text. Just the JSON.

Your JSON should include:

- category (e.g., rice, noodles, salad, stew, soup, dumplings, dessert, etc. — be creative)
- weight (light, medium, or heavy)
- temp (cold or hot)
- culture (e.g., Korean, Japanese, Chinese, American, Mexican, Indian, etc.)
- weather (sun, rain, snow, none — based on when this food is typically enjoyed)

Example format:
{{
  "category": "noodles",
  "weight": "light",
  "temp": "cold",
  "culture": "Korean",
  "weather": "sun"
}}
"""


    response = client.text_generation(prompt, max_new_tokens=256)
    print("\U0001f9e0 전체 응답:", repr(response))

    try:
        start = response.find('{')
        end = response.find('}', start)
        json_str = response[start:end+1]
        print("\U0001f9e0 정제된 JSON:", json_str)
        return json.loads(json_str)

    except Exception as e:
        print("\u274c JSON 파싱 실패:", e)
        return None