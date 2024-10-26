import 'package:dio/dio.dart';
import 'package:batol_reem_2/models/tips_ui.dart';

class TipService {
  final Dio dio;

  TipService(this.dio);

  // Fetching tips from the API
  Future<List<TipUi>> fetchTips() async {
    final response = await dio.get('https://coded-meditation.eapi.joincoded.com/tips');
    if (response.statusCode == 200) {
      List<dynamic> tipsJson = response.data;
      return tipsJson.map((json) => TipUi.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tips');
    }
  }

  // Creating a new tip
  Future<void> createTip(String tipText, String author) async {
    // Validation
    if (tipText.isEmpty) {
      throw Exception('Tip cannot be empty.');
    } else if (tipText.length > 200) {
      throw Exception('Tip cannot be longer than 200 characters.');
    }

    final newTip = TipUi(
      text: tipText,
      author: author,
      upvotes: [],
      downvotes: [],
    );

    try {
      final response = await dio.post(
        'https://coded-meditation.eapi.joincoded.com/tips',
        data: newTip.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Ensure the user is logged in
          },
        ),
      );
      if (response.statusCode == 201) {
        print('Tip created successfully!');
      } else {
        throw Exception('Failed to create tip: ${response.data}');
      }
    } on DioError catch (e) {
      throw Exception('Failed to create tip: ${e.message}');
    }
  }
}