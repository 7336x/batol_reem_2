// pages/create_yoga_music_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/yoga_music_provider.dart';

class CreateYogaMusicPage extends StatefulWidget {
  @override
  _CreateYogaMusicPageState createState() => _CreateYogaMusicPageState();
}

class _CreateYogaMusicPageState extends State<CreateYogaMusicPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final yogaMusicProvider = Provider.of<YogaMusicProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Yoga Music'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                errorText: _errorMessage,
              ),
            ),
            TextField(
              controller: _artistController,
              decoration: InputDecoration(
                labelText: 'Artist',
                errorText: _errorMessage,
              ),
            ),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Music URL',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await yogaMusicProvider.createYogaMusic(
                    _titleController.text,
                    _artistController.text,
                    _urlController.text,
                  );
                  Navigator.pop(context);
                } catch (error) {
                  setState(() {
                    _errorMessage = error.toString(); // Show error message if there's an issue
                  });
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

