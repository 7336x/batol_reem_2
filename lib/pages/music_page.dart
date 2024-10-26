import 'package:batol_reem_2/models/music_model.dart';
import 'package:batol_reem_2/services/music_service.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatelessWidget {
  final MusicService musicService = MusicService();

  @override
  Widget build(BuildContext context) {
    List<Music> musicList = musicService.getMusicList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Music Page'),
      ),
      body: ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          final music = musicList[index];
          return Card(
            child: ListTile(
              leading: Image.asset(
                  'assets/image/music_image2.jpeg'), // Use asset image here
              title: Text(music.title),
              subtitle: Text(music.artist),
            ),
          );
        },
      ),
    );
  }
}
