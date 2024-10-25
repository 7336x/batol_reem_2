import 'package:batol_reem_2/models/meditation_model.dart';



class MeditationService {
  List<Meditation> getMeditationList() {
    return [
      Meditation(
        title: "Meditation 1",
        description: "A calming meditation.",
        imageUrl: "https://example.com/meditation1.jpg",
      ),
      Meditation(
        title: "Meditation 2",
        description: "A guided meditation.",
        imageUrl: "https://example.com/meditation2.jpg",
      ),
      // Add more meditation items as needed
    ];
  }
}
