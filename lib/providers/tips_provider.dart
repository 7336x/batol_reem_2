import 'package:dio/dio.dart';
import '../models/tips_ui.dart';

class TipsService {
  final Dio dio;

  TipsService(this.dio); // Constructor to initialize Dio

  Future<List<TipUi>> fetchTips() async {
    final response = await dio.get('https://coded-meditation.eapi.joincoded.com/tips');
    if (response.statusCode == 200) {
      List<dynamic> tipsJson = response.data;
      return tipsJson.map((json) => TipUi.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tips');
    }
  }

  Future<void> createTip(TipUi tip) async {
    try {
      final response = await dio.post(
        'https://coded-meditation.eapi.joincoded.com/tips',
        data: tip.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Ensure the user is authenticated
          },
        ),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create tip: ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to create tip: $e');
    }
  }
}
