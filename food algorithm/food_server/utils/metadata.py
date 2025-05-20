import subprocess
import json
import re

def parse_dms(dms_str):
    """
    '40 deg 45' 30.23" N' → (40, 45, 30.23, 'N')
    """
    match = re.match(r'(\d+) deg (\d+)[\'′] ([\d.]+)"? ([NSEW])', dms_str)
    if not match:
        return None
    degrees, minutes, seconds, ref = match.groups()
    return dms_to_decimal((int(degrees), int(minutes), float(seconds)), ref)

def dms_to_decimal(dms, ref):
    degrees, minutes, seconds = dms
    decimal = degrees + minutes / 60 + seconds / 3600
    if ref in ['S', 'W']:
        decimal = -decimal
    return decimal



def extract_metadata(image_path):
    try:
        # exiftool 명령어 실행
        result = subprocess.run(
            ['exiftool', '-json', image_path],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )

        # 오류 발생 시 처리
        if result.returncode != 0:
            print("❌ exiftool 오류:", result.stderr)
            return {
                "timestamp": None,
                "location": None,
                "device": None
            }

        # 결과 파싱
        metadata = json.loads(result.stdout)[0]

        # 촬영 시간
        timestamp = metadata.get("DateTimeOriginal") or metadata.get("CreateDate")

        # 위치 정보
        lat_str = metadata.get("GPSLatitude")
        lon_str = metadata.get("GPSLongitude")
        lat = parse_dms(lat_str) if lat_str else None
        lon = parse_dms(lon_str) if lon_str else None
        location = {"latitude": lat, "longitude": lon} if lat and lon else None


        # 기기 정보
        device = metadata.get("Model")

        return {
            "timestamp": timestamp,
            "location": location,
            "device": device
        }

    except Exception as e:
        print("📛 메타데이터 추출 실패:", e)
        return {
            "timestamp": None,
            "location": None,
            "device": None
        }
