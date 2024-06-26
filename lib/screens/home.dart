import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube_with_bloc/bloc/favorite_bloc.dart';
import 'package:fav_youtube_with_bloc/bloc/videos_bloc.dart';
import 'package:fav_youtube_with_bloc/delegates/data_search.dart';
import 'package:fav_youtube_with_bloc/screens/favorites.dart';
import 'package:fav_youtube_with_bloc/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('images/yt_logo_rgb_dark.png'),
        ),
        backgroundColor: const Color(0xFF263238),
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFavorites,
              initialData: const {},
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data!.length}',
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavoritesPage()));
            },
            icon: const Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                bloc.inSearch.add(result);
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
        ],
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
        child: StreamBuilder(
          stream: bloc.videosStream,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length + 1, // +1 para o loading
                  itemBuilder: (context, index) {
                    if (index < snapshot.data!.length) {
                      return VideoTile(video: snapshot.data![index]);
                    } else {
                      bloc.inSearch.add('');
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
