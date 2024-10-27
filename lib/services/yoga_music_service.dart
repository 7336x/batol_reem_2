// services/yoga_music_service.dart
import 'package:batol_reem_2/main.dart';
import 'package:batol_reem_2/services/tips_services.dart';
import 'package:dio/dio.dart';
import '../models/yoga.dart';

class YogaMusicService {
  YogaMusicService(); // Initialize Dio for API requests

  Future<List<YogaMusic>> fetchYogaMusic() async {
    // Replace with your actual API endpoint
    final response =
        await DioClient.dio.get('https://example.com/api/yoga_music');

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
    await DioClient.dio.post('https://example.com/api/yoga_music', data: {
      'title': yogaMusic.title,
      'artist': yogaMusic.artist,
      'url': yogaMusic.url,
    });
  }
}
