import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../bloc/favorite_bloc.dart';
import '../bloc/video_description.dart';
import '../models/video.dart';
import '../widgets/volume_slider.dart';

class VideoPlayer extends StatelessWidget {
  final Video video;

  const VideoPlayer({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    /*
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent, // Cor desejada
        // Brilho dos ícones na barra de status
        systemNavigationBarDividerColor: Colors.amber,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      ),
    );*/
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF1c1c1c),
    );

    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    final descriptionBloc = BlocProvider.getBloc<DescriptionBloc>();

    final youtubeController = YoutubePlayerController(
      initialVideoId: video.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        loop: false,
      ),
    );

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // Para evitar o app ficar em fullscreen
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
      player: YoutubePlayer(
        controller: youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.white70,
        ),
        aspectRatio: 16.0 / 9.0,
        bottomActions: [
          VolumeSlider(youtubeController: youtubeController),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.white70,
            ),
          ),
          FullScreenButton(
            controller: youtubeController,
            color: Colors.white,
          ),
        ],
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              youtubeController.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 25,
            child: Image.asset("images/yt_logo_rgb_dark.png"),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF263238),
          actions: [
            StreamBuilder<Map<String, Video>>(
              stream: bloc.outFavorites,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                    icon: Icon(
                      snapshot.data!.containsKey(video.id)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      bloc.toggleFavorite(video);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
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
          child: Column(
            children: [
              player,
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            video.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.remove_red_eye,
                                color: Colors.white54,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${formatViews(video.viewCount)} views',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.access_time,
                                color: Colors.white60,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Há ${_calculateTimeDifference(video.publishedAt)}',
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.thumb_up),
                                  label: Text(formatLikes(video.likeCount)),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 24, 24, 24)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.thumb_down),
                                  label: const Text(''),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 24, 24, 24)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.share),
                                  label: const Text('Compartilhar'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 24, 24, 24)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.white60, height: 20),
                          _buildDescriptionText(descriptionBloc),
                          const Divider(color: Colors.white, height: 20),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 26,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                video.channelTitle,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatViews(String views) {
    if (views.isEmpty) {
      return '';
    }
    int number = int.parse(views);
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B'; // Bilhão
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M'; // Milhão
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K'; // Milhar
    } else {
      return number.toString();
    }
  }

  String _calculateTimeDifference(DateTime publishedAt) {
    final now = DateTime.now();
    //final videoTime = DateTime.parse(publishedAt);
    final difference = now.difference(publishedAt);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365} anos';
    } else if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30} meses';
    } else if (difference.inDays > 7) {
      return '${difference.inDays ~/ 7} semanas';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} dias';
    } else if (difference.inDays == 1) {
      return '${difference.inDays} dia';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutos';
    } else {
      return 'alguns segundos';
    }
  }

  String formatLikes(String likes) {
    if (likes.isEmpty) {
      return '';
    }

    int number = int.parse(likes);
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)} mil';
    } else if (number == 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)} milhão';
    } else if (number < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)} milhões';
    } else if (number == 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)} bilhão';
    } else {
      return '${(number / 1000000000).toStringAsFixed(1)} bilhões';
    }
  }

  Widget _buildDescriptionText(DescriptionBloc descriptionBloc) {
    return StreamBuilder<DescriptionState>(
      stream: descriptionBloc.stream,
      initialData: DescriptionState.collapsed,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Descrição',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              video.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white38,
              ),
              maxLines: snapshot.data == DescriptionState.collapsed ? 6 : null,
            ),
            GestureDetector(
              onTap: () {
                if (snapshot.data == DescriptionState.collapsed) {
                  descriptionBloc.expand();
                } else {
                  descriptionBloc.collapse();
                }
              },
              child: Text(
                snapshot.data == DescriptionState.collapsed
                    ? 'Ver mais'
                    : 'Ver menos',
                style: const TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
