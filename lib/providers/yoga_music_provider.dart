// providers/yoga_music_provider.dart
import 'package:flutter/material.dart';
import '../models/yoga.dart';
import '../services/yoga_music_service.dart';

class YogaMusicProvider with ChangeNotifier {
  final YogaMusicService _yogaMusicService;
  List<YogaMusic> _music = [];
  bool _isLoading = true;
  String? _error;

  YogaMusicProvider(this._yogaMusicService);

  List<YogaMusic> get music => _music;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadYogaMusic() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _music = await _yogaMusicService.fetchYogaMusic();
    } catch (e) {
      _error = 'Failed to load yoga music: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createYogaMusic(String title, String artist, String url) async {
    if (title.isEmpty || artist.isEmpty || url.isEmpty) {
      throw Exception('All fields are required');
    }

    YogaMusic yogaMusic = YogaMusic(title: title, artist: artist, url: url);
    await _yogaMusicService.createYogaMusic(yogaMusic);
    notifyListeners();
  }
}
