import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

enum DescriptionState { collapsed, expanded }

class DescriptionBloc extends BlocBase {
  final _stateController =
      BehaviorSubject<DescriptionState>.seeded(DescriptionState.collapsed);

  Stream<DescriptionState> get stream => _stateController.stream;

  DescriptionState get state => _stateController.value;

  void expand() => _stateController.add(DescriptionState.expanded);

  void collapse() => _stateController.add(DescriptionState.collapsed);

  @override
  void dispose() {
    _stateController.close();
    super.dispose();
  }
}
