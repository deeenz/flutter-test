import 'package:flutter/material.dart';
import 'package:flutter_test_app/providers/historyProvider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<String>>(
        stream: Provider.of<HistoryProvider>(context).getHistory(),
        builder: (context, histories) {
          return (histories.data == null)
              ? Center(
                  child: Text("No movie purchase history"),
                )
              : ListView.builder(
                  itemCount: histories.data.length,
                  itemBuilder: (context, index) {
                    return historyItem(histories.data[index]);
                  });
        },
      ),
    );
  }

  Widget historyItem(String history) {
    return ListTile(
      title: Text(
        history,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
