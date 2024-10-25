import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tips_provider.dart'; // Correct import

class CreateTipPage extends StatefulWidget {
  @override
  _CreateTipPageState createState() => _CreateTipPageState();
}

class _CreateTipPageState extends State<CreateTipPage> {
  final TextEditingController _textController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    // Access the TipsProvider correctly
    // final tipsProvider = Provider.of<TipsProvider>(context); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Tip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Tip Text',
                errorText: _errorMessage,
              ),
              maxLength: 200,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Call the createTip method correctly
                  // await tipsProvider.createTip(_textController.text); 
                  Navigator.pop(context); // Go back after creating the tip
                } catch (error) {
                  setState(() {
                    _errorMessage = error.toString(); // Show error message
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
