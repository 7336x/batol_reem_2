import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:batol_reem_2/models/tips_ui.dart';
import 'package:batol_reem_2/services/tips_services.dart';

class TipsListPage extends StatefulWidget {
  @override
  _TipsListPageState createState() => _TipsListPageState();
}

class _TipsListPageState extends State<TipsListPage> {
  late Future<List<TipUi>> _tipsFuture;

  @override
  void initState() {
    super.initState();
    _tipsFuture = Provider.of<TipService>(context, listen: false).fetchTips(); // Fetch tips when the page initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
      ),
      body: FutureBuilder<List<TipUi>>(
        future: _tipsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tips available.'));
          } else {
            // Display the list of tips
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
    );
  }
}
