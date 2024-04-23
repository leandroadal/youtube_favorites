import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube_with_bloc/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';

import '../models/video.dart';
import 'video_player.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoritos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF263238),
      ),
      body: Container(
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
        child: StreamBuilder<Map<String, Video>>(
            stream: bloc.outFavorites,
            initialData: const {},
            builder: (context, snapshot) {
              return ListView(
                children: snapshot.data!.values.map((v) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoPlayer(video: v),
                        ),
                      );
                    },
                    onLongPress: () {
                      bloc.toggleFavorite(v);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: Image.network(v.thumbnailUrl),
                        ),
                        Expanded(
                          child: Text(
                            v.title,
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
