import 'package:rxdart/rxdart.dart';

Stream<(A, B, C)> combine3<A, B, C>(
  Stream<A> streamOne,
  Stream<B> streamTwo,
  Stream<C> streamThree, {
  Duration? debounceTime,
}) {
  return CombineLatestStream<dynamic, (A, B, C)>(
    [streamOne, streamTwo, streamThree],
    (values) => (values[0] as A, values[1] as B, values[2] as C),
  ).debounceTime(debounceTime ?? Duration.zero);
}

Stream<(A, B)> combine2<A, B>(
  Stream<A> streamOne,
  Stream<B> streamTwo, {
  Duration? debounceTime,
}) {
  return CombineLatestStream<dynamic, (A, B)>(
    [streamOne, streamTwo],
    (values) => (values[0] as A, values[1] as B),
  ).debounceTime(debounceTime ?? Duration.zero);
}
