import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tips_provider.dart';
import '../services/tips_services.dart';
import '../models/tips_ui.dart';

class TipsMainPage extends StatefulWidget {
  @override
  _TipsMainPageState createState() => _TipsMainPageState();
}

class _TipsMainPageState extends State<TipsMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textController = TextEditingController();
  String? _errorMessage;
  late Future<List<TipUi>> _tipsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tipsFuture = Provider.of<TipService>(context, listen: false).fetchTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Create Tip'),
            Tab(text: 'Tip List'),
            Tab(text: 'Tips Image'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Create Tip Page Content
          Padding(
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
                      // await Provider.of<TipsProvider>(context, listen: false).createTip(_textController.text);
                      Navigator.pop(context);
                    } catch (error) {
                      setState(() {
                        _errorMessage = error.toString();
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),

          // Tips List Page Content
          FutureBuilder<List<TipUi>>(
            future: _tipsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No tips available.'));
              } else {
                final tips = snapshot.data!;
                return ListView.builder(
                  itemCount: tips.length,
                  itemBuilder: (context, index) {
                    final tip = tips[index];
                    return Card(
                      child: ListTile(
                        title: Text(tip.text),
                        subtitle: Text('By: ${tip.author}'),
                        onTap: () {
                          // Handle the tap event, e.g., navigate to detail page
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),

          // Tips Image Page Content
          Column(
            children: [
              Container(height: 30),
              Image.asset(
                'assets/image/tips_image1.avif',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
