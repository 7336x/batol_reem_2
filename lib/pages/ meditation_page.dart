import 'package:batol_reem_2/models/meditation_model.dart';
import 'package:batol_reem_2/services/meditation_service.dart';
import 'package:flutter/material.dart';


class MeditationPage extends StatelessWidget {
  final MeditationService meditationService = MeditationService();

  @override
  Widget build(BuildContext context) {
    List<Meditation> meditationList = meditationService.getMeditationList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Page'),
      ),
      body: ListView.builder(
        itemCount: meditationList.length,
        itemBuilder: (context, index) {
          final meditation = meditationList[index];
          return Card(
            child: ListTile(
              leading: Image.network(meditation.imageUrl),
              title: Text(meditation.title),
              subtitle: Text(meditation.description),
            ),
          );
        },
      ),
    );
  }
}
