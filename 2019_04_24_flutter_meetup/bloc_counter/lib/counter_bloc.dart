import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int _counter = 0;

  BehaviorSubject<int> _counterStateSubject;
  PublishSubject<void> _incrementEventSubject;

  Stream<int> get counter => _counterStateSubject.stream;
  Sink<void> get increment => _incrementEventSubject.sink;

  StreamSubscription<void> _incrementEventSubscription;

  CounterBloc() {
    _counterStateSubject = BehaviorSubject<int>.seeded(_counter);
    _incrementEventSubject = PublishSubject<void>();
    _incrementEventSubscription =
        _incrementEventSubject.listen(_handleIncrement);
  }

  void dispose() {
    _incrementEventSubscription.cancel();
    _incrementEventSubject.close();
    _counterStateSubject.close();
  }

  void _handleIncrement(_) {
    _counterStateSubject.add(++_counter);
  }
}
