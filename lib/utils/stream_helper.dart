import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

Stream<Tuple2<A, B>> combine2<A, B>(
  final Stream<A> streamOne,
  final Stream<B> streamTwo, {
  final Duration? debounceTime,
}) {
  return CombineLatestStream<dynamic, Tuple2<A, B>>(
    [
      streamOne,
      streamTwo,
    ],
    (final values) => Tuple2(
      values[0] as A,
      values[1] as B,
    ),
  ).debounceTime(
    debounceTime ?? Duration.zero,
  );
}

Stream<Tuple3<A, B, C>> combine3<A, B, C>(
  final Stream<A> streamOne,
  final Stream<B> streamTwo,
  final Stream<C> streamThree, {
  final Duration? debounceTime,
}) {
  return CombineLatestStream<dynamic, Tuple3<A, B, C>>(
    [
      streamOne,
      streamTwo,
      streamThree,
    ],
    (final values) => Tuple3(
      values[0] as A,
      values[1] as B,
      values[2] as C,
    ),
  ).debounceTime(
    debounceTime ?? Duration.zero,
  );
}

Stream<Tuple4<A, B, C, D>> combine4<A, B, C, D>(
  final Stream<A> streamOne,
  final Stream<B> streamTwo,
  final Stream<C> streamThree,
  final Stream<C> streamFour, {
  final Duration? debounceTime,
}) {
  return CombineLatestStream<dynamic, Tuple4<A, B, C, D>>(
    [
      streamOne,
      streamTwo,
      streamThree,
      streamFour,
    ],
    (final values) => Tuple4(
      values[0] as A,
      values[1] as B,
      values[2] as C,
      values[3] as D,
    ),
  ).debounceTime(
    debounceTime ?? Duration.zero,
  );
}
