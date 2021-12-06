import 'package:beer_app/utils/bloc_base.dart';

class HomeBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  HomeBloc() {
    setState(ScreenState());
  }
}

class ScreenState {
  final List<String>? selectChips;

  ScreenState({
    this.selectChips,
  });

  ScreenState copyWith({
    List<String>? selectChips,
  }) {
    return ScreenState(
      selectChips: selectChips ?? this.selectChips,
    );
  }
}
