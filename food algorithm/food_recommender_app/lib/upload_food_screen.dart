import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:food_recommender_app/location_service.dart';
import 'package:geolocator/geolocator.dart';

class UploadFoodScreen extends StatefulWidget {
  @override
  _UploadFoodScreenState createState() => _UploadFoodScreenState();
}

class _UploadFoodScreenState extends State<UploadFoodScreen> {
  File? _imageFile;
  String? _predictionText;
  String? _timestamp;
  String? _device;
  String? _locationString;
  List<String>? _nearbyPlaces;
  bool _isLoading = false;
  final picker = ImagePicker();
  String? _currentWeather;
  double? _currentTemperature;
  double? _latitude;
  double? _longitude;
  Map<String, dynamic>? _attributes;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
    await Permission.photos.request();
    await Permission.camera.request();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _predictionText = null;
          _timestamp = null;
          _device = null;
          _locationString = null;
          _nearbyPlaces = null;
        });
        await _sendImageToServer(_imageFile!);
      }
    } catch (e) {
      print("이미지 선택 오류: $e");
    }
  }

  Future<void> _sendImageToServer(File imageFile) async {
    final uri = Uri.parse('http://127.0.0.1:5050/predict');
    final mimeType = lookupMimeType(imageFile.path)?.split('/');

    setState(() {
      _isLoading = true;
    });

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType:
              mimeType != null
                  ? MediaType(mimeType[0], mimeType[1])
                  : MediaType('image', 'jpeg'),
        ),
      );

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(responseBody);

        final predictionList = result['prediction'] as List<dynamic>;
        final predictionText = predictionList
            .map<String>(
              (item) =>
                  "${item['label']} (${(item['probability'] * 100).toStringAsFixed(2)}%)",
            )
            .join("\n");

        final metadata = result['metadata'];
        final location = metadata['location'];
        final locationStr =
            location != null
                ? "latitude: ${location['latitude']}, longitude: ${location['longitude']}"
                : null;

        setState(() {
          _predictionText = predictionText;
          _timestamp = metadata['timestamp'];
          _device = metadata['device'];
          _locationString = locationStr;
          _nearbyPlaces = metadata['nearby_places']?.cast<String>();
          _attributes = metadata['attributes']?.cast<String, dynamic>();
        });
      } else {
        setState(() {
          _predictionText = "서버 오류: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _predictionText = "전송 실패: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getRecommendations() async {
    final uri = Uri.parse('http://127.0.0.1:5050/recommend');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['recommendations'];

        // 추천 결과를 다이얼로그로 보여주기
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text("🍽 음식 추천"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      results.map((item) {
                        final name = item[0];
                        final score = item[1];
                        return Text(
                          "• $name (점수: ${score.toStringAsFixed(1)})",
                        );
                      }).toList(),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("닫기"),
                  ),
                ],
              ),
        );
      } else {
        print("추천 API 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("추천 요청 실패: $e");
    }
  }

  Future<void> _getWeatherFromServer(Position position) async {
    final uri = Uri.parse('http://127.0.0.1:5050/weather');

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "latitude": position.latitude,
          "longitude": position.longitude,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final locationName = data["location_name"];
        final weather = data["weather"];
        final temperature = data["temperature"];

        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text("🌤 현재 날씨 정보"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📍 위치: $locationName"),
                    SizedBox(height: 8),
                    Text("☁️ 날씨: $weather"),
                    Text("🌡 기온: ${temperature.toString()}°C"),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("닫기"),
                  ),
                ],
              ),
        );
      } else {
        print("❌ 서버 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("🌐 전송 실패: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('음식 인식')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, height: 200)
                : Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: Center(child: Text('사진을 선택해주세요')),
                ),
            SizedBox(height: 20),
            if (_isLoading) CircularProgressIndicator(),
            if (_predictionText != null) ...[
              SizedBox(height: 20),
              Text('예측 결과:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_predictionText!),
              if (_timestamp != null) ...[
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 6),
                    Text("촬영 시각: $_timestamp"),
                  ],
                ),
              ],
              if (_locationString != null) ...[
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 16),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "위치: $_locationString",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              if (_device != null) ...[
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.camera_alt, size: 16),
                    SizedBox(width: 6),
                    Text("기기: $_device"),
                  ],
                ),
              ],
              if (_attributes != null) ...[
                SizedBox(height: 16),
                Text(
                  '🍱 AI 분류 속성:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("• 카테고리: ${_attributes!['category']}"),
                Text("• 무게: ${_attributes!['weight']}"),
                Text("• 온도: ${_attributes!['temp']}"),
                Text("• 문화권: ${_attributes!['culture']}"),
                Text("• 날씨 적합도: ${_attributes!['weather']}"),
              ],

              if (_nearbyPlaces != null && _nearbyPlaces!.isNotEmpty) ...[
                SizedBox(height: 16),
                Text('근처 음식점:', style: TextStyle(fontWeight: FontWeight.bold)),
                ..._nearbyPlaces!.map((place) => Text("- $place")),
              ],
            ],
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo),
                  label: Text('갤러리'),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text('카메라'),
                ),
                ElevatedButton.icon(
                  onPressed: _getRecommendations,
                  icon: Icon(Icons.star),
                  label: Text('음식 추천 받기'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      Position pos = await getCurrentPosition(context: context);
                      print("📍 현재 위치: ${pos.latitude}, ${pos.longitude}");
                      await _getWeatherFromServer(pos); // 🔥 여기서 호출!
                    } catch (e) {
                      print("위치 에러: $e");
                    }
                  },
                  icon: Icon(Icons.cloud),
                  label: Text("현재 위치 날씨 받아오기"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
