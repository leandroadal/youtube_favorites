import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube_with_bloc/api.dart';
import 'package:fav_youtube_with_bloc/models/search.dart';
import 'package:flutter/material.dart';

class VideosBloc implements BlocBase {
  Api? api;

  List<SearchVideo> videos = [];

  final StreamController<List<SearchVideo>> _videosController =
      StreamController<List<SearchVideo>>();

  Stream get videosStream => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();

  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();
    // precisa ter declarado o tipo do Stream controller para o _search funcionar
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search.isNotEmpty) {
      videos = await api!.search(search);
    } else {
      videos +=
          await api!.nextPage(); // += para concatenar as listas dos videos
    }

    _videosController.sink.add(videos);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
