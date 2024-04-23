import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class VolumeBloc extends BlocBase {
  final _volumeController = BehaviorSubject<double>.seeded(100);
  final _showVolumeController = BehaviorSubject<bool>.seeded(false);

  Stream<double> get volumeStream => _volumeController.stream;
  Stream<bool> get showVolumeStream => _showVolumeController.stream;

  void changeVolume(double value) {
    _volumeController.sink.add(value);
  }

  void toggleShowVolume() {
    _showVolumeController.sink.add(!_showVolumeController.value);
  }

  @override
  void dispose() {
    _volumeController.close();
    _showVolumeController.close();
    super.dispose();
  }
}
