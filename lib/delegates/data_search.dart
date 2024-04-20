import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Para dar tempo de o resultado e depois a tela home
    Future.delayed(Duration.zero).then(
      (_) => close(context, query),
    );

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: suggestions(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]),
                  leading: const Icon(Icons.play_arrow),
                  onTap: () {
                    close(context, snapshot.data![index]);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }

  Future<List> suggestions(String search) async {
    http.Response response = await http.get(Uri.parse(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"));

    if (response.statusCode == 200) {
      return json.decode(response.body)[1].map((e) => e[0]).toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
