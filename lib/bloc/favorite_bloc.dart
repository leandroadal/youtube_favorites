import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/video.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get outFavorites => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains('favorites')) {
        //pega a string json e decodifica para Objeto
        Map favs = json.decode(prefs.getString('favorites')!);
        _favorites = favs.map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>(); //para retornar o map no formato certo

        _favController.add(_favorites);
      }
    });
  }

  void _saveFavorites() {
    SharedPreferences.getInstance().then((prefs) => {
          //transforma em uma string json
          prefs.setString('favorites', json.encode(_favorites)),
        });
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);

    _saveFavorites();
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _favController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
