import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fav_youtube_with_bloc/api.dart';
import 'package:fav_youtube_with_bloc/bloc/favorite_bloc.dart';
import 'package:fav_youtube_with_bloc/models/search.dart';
import 'package:fav_youtube_with_bloc/screens/video_player.dart';
import 'package:flutter/material.dart';

import '../models/video.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({super.key, required this.video});

  final SearchVideo video;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return GestureDetector(
      onTap: () {
        Api().videoInfo(video.id).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VideoPlayer(video: value),
            ),
          );
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(
                video.thumbnailUrl, // thumb do video
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.channelTitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: bloc.outFavorites,
                  initialData: const {},
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        onPressed: () async {
                          await Api().videoInfo(video.id).then((value) {
                            bloc.toggleFavorite(value);
                          });
                          //bloc.toggleFavorite(video);
                        },
                        icon: Icon(snapshot.data!.containsKey(video.id)
                            ? Icons.star
                            : Icons.star_border),
                        iconSize: 30,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
