from PIL import Image
import pillow_heif
import os
import torch
import io
from torchvision import transforms
from transformers import AutoImageProcessor, AutoModelForImageClassification
from torch.nn.functional import softmax
from datetime import datetime

# 모델 및 이미지 프로세서 로드
processor = AutoImageProcessor.from_pretrained("skylord/swin-finetuned-food101")
model = AutoModelForImageClassification.from_pretrained("skylord/swin-finetuned-food101")
model.eval()


def load_image(image_path):
    if image_path.lower().endswith(".heic"):
        heif_file = pillow_heif.read_heif(image_path)
        image = Image.frombytes(
            heif_file.mode, heif_file.size, heif_file.data
        ).convert("RGB")
    else:
        image = Image.open(image_path).convert("RGB")
    return image

def predict_image(image_path, top_k=5):
    # 이미지 로드 및 전처리
    image = load_image(image_path).convert("RGB")
    inputs = processor(images=image, return_tensors="pt")

    # 모델 추론
    with torch.no_grad():
        outputs = model(**inputs)
        logits = outputs.logits
        probs = softmax(logits, dim=1)
        top_probs, top_indices = torch.topk(probs, k=top_k)

    # 결과 리스트로 정리
    top_predictions = []
    for i in range(top_k):
        label = model.config.id2label[top_indices[0][i].item()]
        prob = round(top_probs[0][i].item(), 4)
        top_predictions.append({
            "label": label,
            "probability": prob
        })

    return top_predictions

def save_user_prediction(user_id, prediction, metadata):
    filepath = os.path.join("past_data", f"{user_id}_predictions.txt")

    with open(filepath, "a", encoding="utf-8") as f:
        f.write("🍽 Prediction Results:\n")
        for item in prediction:
            f.write(f"- {item['label']}: {item['probability']*100:.2f}%\n")

        f.write("\n📅 Timestamp: {}\n".format(metadata.get("timestamp")))
        f.write("📍 Location: {}\n".format(metadata.get("location")))
        f.write("📷 Device: {}\n".format(metadata.get("device")))
        f.write("\n" + "=" * 40 + "\n\n")
