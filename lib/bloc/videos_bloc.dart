import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube_with_bloc/api.dart';
import 'package:fav_youtube_with_bloc/models/video.dart';

class VideosBloc implements BlocBase {
  Api? api;

  List<Video> videos = [];

  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>();

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
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}