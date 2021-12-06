import 'package:beer_app/widget/action_handler.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocBase {
  void dispose();
}

abstract class BlocBaseWithState<ScreenState> extends BlocBase {
  final Subject<ActionEvent> _actions = BehaviorSubject<ActionEvent>();
  late final BehaviorSubject<ScreenState> _state;

  ScreenState? get currentState => _state.valueOrNull;

  Stream<ScreenState> get state => _state;

  Stream<ActionEvent> get actions => _actions
      .where((event) => !event.handled)
      .doOnData((event) => event.consume());

  BlocBaseWithState() {
    _state = BehaviorSubject<ScreenState>(
      onListen: () => doOnStateListen(),
      onCancel: () => doOnStateStopListen(),
    );
  }

  void doOnStateListen() {
    // Start subscriptions here
    // Can be called multiple times
  }

  void doOnStateStopListen() {
    // Pause subscriptions here
    // Can be called multiple times
  }

  void sendAction(String action, [dynamic payload]) {
    _actions.add(ActionEvent(action, payload: payload));
  }

  void setState(ScreenState newState) {
    if (_state.isClosed) return;
    _state.add(newState);
  }

  void updateState() {
    final state = currentState;
    if (state != null) setState(state);
  }

  void sendActionError([dynamic payload]) =>
      sendAction(ActionEvent.actionShowError, payload);

  @override
  @mustCallSuper
  void dispose() {
    _actions.close();
    _state.close();
  }
}