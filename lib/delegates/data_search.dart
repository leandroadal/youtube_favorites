import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  DataSearch()
      : super(
          searchFieldStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        );

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
    // Para dar tempo de gerar o resultado e depois a tela home
    Future.delayed(Duration.zero).then(
      (_) => close(context, query),
    );

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF1c1c1c),
    );
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF263238),
            Color(0xFF1c1c1c),
          ],
        ),
      ),
      child: query.isEmpty
          ? Container() // Se não há texto na pesquisa, retorna um Container vazio
          : FutureBuilder(
              future: suggestions(query),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data![index],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        leading:
                            const Icon(Icons.play_arrow, color: Colors.white),
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
            ),
    );
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

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarContrastEnforced: true),
        backgroundColor: const Color(0xFF263238),
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
        titleTextStyle:
            theme.textTheme.titleLarge!.copyWith(color: Colors.white),
        toolbarTextStyle: theme.textTheme.bodyMedium,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
    );
  }
}
