import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultsScreen extends StatefulWidget {
  final String query;
  const ResultsScreen({required this.query});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool _isLoading = true;
  List<dynamic> _recipes = [];

  
  final String apiKey = "0424d93222674de48dbfeaf3b44dc16a";

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final query = widget.query;

    final url = Uri.parse(
      "https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey&number=10",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _recipes = data["results"];
          _isLoading = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print("Error: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results for '${widget.query}'")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _recipes.isEmpty
              ? Center(child: Text("No recipes found"))
              : ListView.builder(
                  itemCount: _recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = _recipes[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: ListTile(
                        leading: recipe["image"] != null
                            ? Image.network(recipe["image"], width: 60)
                            : null,
                        title: Text(recipe["title"] ?? "No title"),
                        onTap: () {
                          // You can navigate to a detail screen her
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
