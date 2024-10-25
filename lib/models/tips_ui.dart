import 'package:json_annotation/json_annotation.dart';

part 'tips_ui.g.dart'; // This generates the JSON serialization logic

@JsonSerializable()
class TipUi {
  final int? id; // Optional for new tips
  final String text; // Content of the tip
  final String author; // Author of the tip
  final List<int> upvotes; // List of upvote IDs
  final List<int> downvotes; // List of downvote IDs

  TipUi({
    this.id,
    required this.text,
    required this.author,
    required this.upvotes,
    required this.downvotes,
  });

  // Factory constructor for creating a new TipUi instance from a map
  factory TipUi.fromJson(Map<String, dynamic> json) => _$TipUiFromJson(json);

  // Convert TipUi instance to JSON
  Map<String, dynamic> toJson() => _$TipUiToJson(this);
}
