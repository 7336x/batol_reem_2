// services/yoga_music_service.dart
import 'package:dio/dio.dart';
import '../models/yoga.dart';

class YogaMusicService {
  final Dio _dio = Dio();

  YogaMusicService(Dio dio); // Initialize Dio for API requests

  Future<List<YogaMusic>> fetchYogaMusic() async {
    // Replace with your actual API endpoint
    final response = await _dio.get('https://example.com/api/yoga_music'); 

    // Parse the response
    if (response.statusCode == 200) {
      List<YogaMusic> musicList = (response.data as List)
          .map((music) => YogaMusic(
                title: music['title'],
                artist: music['artist'],
                url: music['url'],
              ))
          .toList();
      return musicList;
    } else {
      throw Exception('Failed to load yoga music');
    }
  }

  Future<void> createYogaMusic(YogaMusic yogaMusic) async {
    await _dio.post('https://example.com/api/yoga_music', data: {
      'title': yogaMusic.title,
      'artist': yogaMusic.artist,
      'url': yogaMusic.url,
    });
  }
}
