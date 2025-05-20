import 'package:geolocator/geolocator.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

Future<Position> getCurrentPosition({required BuildContext context, int retries = 3}) async {
  int attempt = 0;

  while (attempt < retries) {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("위치 서비스 꺼짐");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      print("⚠️ 현재 위치 권한 상태: $permission");

      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          // ✅ 여기서 다이얼로그 안내
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("⛔ 위치 권한 필요"),
              content: Text("위치 기능을 사용하려면 시스템 설정에서 권한을 허용해주세요."),
              actions: [
                TextButton(
                  onPressed: () {
                    Geolocator.openAppSettings();
                    Navigator.of(context).pop();
                  },
                  child: Text("설정 열기"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("닫기"),
                ),
              ],
            ),
          );

          throw Exception("위치 권한 거부됨");
        }
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("❗ 위치 실패 (${attempt + 1}/$retries): $e");
      attempt++;
      await Future.delayed(Duration(seconds: 1));
    }
  }

  throw Exception("위치 정보를 가져오지 못했습니다.");
}


