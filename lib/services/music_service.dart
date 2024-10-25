import 'package:batol_reem_2/models/music_model.dart';



class MusicService {
  List<Music> getMusicList() {
    return [
      Music(
        title: "Song 1",
        artist: "Artist 1",
        albumCoverUrl: "https://example.com/cover1.jpg",
      ),
      Music(
        title: "Song 2",
        artist: "Artist 2",
        albumCoverUrl: "https://example.com/cover2.jpg",
      ),
      // Add more music items as needed
    ];
  }
}
