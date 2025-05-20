import requests

GOOGLE_PLACES_API_KEY = "AIzaSyCkA1by2iiCv0r4_8_nybpN2er9wgt_LJI"  # 너의 키로 교체해줘

def get_nearby_places(location, radius=100):
    if location is None:
        return None

    lat = location["latitude"]
    lng = location["longitude"]

    url = "https://places.googleapis.com/v1/places:searchNearby"
    print("📡 Google Places API 요청 URL:", url)

    payload = {
        "includedTypes": ["restaurant"],
        "maxResultCount": 10,
        "locationRestriction": {
            "circle": {
                "center": {
                    "latitude": lat,
                    "longitude": lng
                },
                "radius": radius
            }
        }
    }

    headers = {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": GOOGLE_PLACES_API_KEY,
        "X-Goog-FieldMask": "places.displayName,places.formattedAddress"
    }

    try:
        response = requests.post(url, json=payload, headers=headers)
        data = response.json()
        places = []

        if "places" in data:
            for place in data["places"]:
                name = place.get("displayName", {}).get("text")
                address = place.get("formattedAddress")
                if name:
                    places.append(f"{name} ({address})")
        return places
    except Exception as e:
        print("📛 Google Places API (New) 호출 실패:", e)
        return None

