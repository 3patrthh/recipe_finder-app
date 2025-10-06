import 'package:flutter/material.dart';
import 'result_screen.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Search")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search for a recipe (e.g. pasta)",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                final query = value.trim();
                if (query.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultsScreen(query: query),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Search"),
              onPressed: () {
                final query_ = _controller.text.trim();
                if (query.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultsScreen(query: query_),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
