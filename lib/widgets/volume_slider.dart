import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import '../bloc/volume_bloc.dart';

class VolumeSlider extends StatelessWidget {
  final YoutubePlayerController youtubeController;

  const VolumeSlider({super.key, required this.youtubeController});

  @override
  Widget build(BuildContext context) {
    final volumeBloc = BlocProvider.getBloc<VolumeBloc>();

    return StreamBuilder<bool>(
      stream: volumeBloc.showVolumeStream,
      initialData: false,
      builder: (context, showVolumeSnapshot) {
        bool _showVolume = showVolumeSnapshot.data ?? false;

        return Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () {
                volumeBloc.toggleShowVolume();
              },
              child: StreamBuilder<double>(
                stream: volumeBloc.volumeStream,
                initialData: 100,
                builder: (context, volumeSnapshot) {
                  double volume = volumeSnapshot.data ?? 100;

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        volume == 0 ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        height: _showVolume ? 50 : 0,
                        width: _showVolume ? 100 : 0,
                        child: _showVolume
                            ? Slider(
                                value: volume,
                                min: 0,
                                max: 100,
                                thumbColor: Colors.white,
                                activeColor: Colors.red,
                                inactiveColor: Colors.white30,
                                onChanged: (value) {
                                  volumeBloc.changeVolume(value);
                                  youtubeController.setVolume(value.toInt());
                                },
                              )
                            : null,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
