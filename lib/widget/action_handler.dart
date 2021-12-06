//
// Kawoon (c) 2021
//

import 'dart:async';

import 'package:flutter/widgets.dart';

class ActionHandler<T> extends StatefulWidget {
  final Widget? child;
  final void Function(T, BuildContext) handler;
  final Stream<T> stream;

  const ActionHandler(
      {Key? key, this.child, required this.handler, required this.stream})
      : super(key: key);

  @override
  State createState() {
    return _ActionHandlerState<T>();
  }
}

class _ActionHandlerState<T> extends State<ActionHandler<T>> {
  StreamSubscription? _subscription;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }

  @override
  void initState() {
    _subscribe();
    super.initState();
  }

  @override
  void didUpdateWidget(ActionHandler<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stream != widget.stream) {
      _subscription?.cancel();
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    _subscription = widget.stream.listen((event) {
      widget.handler(event, context);
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
  }
}

class ActionEvent {
  static const actionShowError = 'error';

  final String action;
  final dynamic payload;
  bool handled = false;

  ActionEvent(this.action, {this.payload});

  bool actionIdentical(String action) => identical(this.action, action);

  void consume() => handled = true;

  bool get isShowErrorAction => identical(action, actionShowError);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionEvent &&
          action == other.action &&
          payload == other.payload;

  @override
  int get hashCode => action.hashCode;

  @override
  String toString() {
    return 'ActionEvent{action: $action, payload: $payload}';
  }
}
