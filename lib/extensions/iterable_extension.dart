extension IterableExtension<E> on Iterable<E> {
  Iterable<E> whereNot(bool Function(E event) test) => where((e) => !test(e));

  Iterable<E> ofSameType<E>() => whereType<E>();

  E? firstOrNull() {
    try {
      return first;
    } catch (e) {
      return null;
    }
  }

  E? secondOrNull() {
    try {
      return toList()[1];
    } catch (e) {
      return null;
    }
  }

  E? firstWhereOrNull(bool Function(E element) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  Iterable<T> mapIndexed<T>(T Function(E e, int index) f) {
    var index = 0;
    return map((e) => f(e, index++));
  }

  Iterable<Iterable<E>> chunked(int chunkSize) {
    final chunksAmount = length ~/ chunkSize + (length % chunkSize == 0 ? 0 : 1);
    return List.generate(chunksAmount, (index) => skip(index * chunkSize).take(chunkSize));
  }

  Map<T, List<E>> groupBy<T>(T Function(E e) keySelector) {
    var groups = <T, List<E>>{};
    for (final value in this) {
      final key = keySelector(value);
      groups[key] ??= [];
      groups[key]?.add(value);
    }
    return groups;
  }

  E get(int index) => elementAt(index);

  E? getOrNull(int index) => 0 <= index && index < length ? get(index) : null;

  bool none(bool Function(E element) test) => !any(test);

  bool all(bool Function(E element) test) => every(test);

  Iterable<E> uniqueBy<T>(T Function(E e) extractor) {
    final ids = map(extractor).toSet();

    return where((element) {
      final id = extractor(element);
      final isInIds = ids.contains(id);
      if (isInIds) {
        ids.remove(id);
      }
      return isInIds;
    });
  }

  num sumBy<T>(num Function(E e) keySelector) {
    num sum = 0;
    for (var item in this) {
      sum += keySelector(item);
    }
    return sum;
  }
}

extension NullableIterableExtension<E> on Iterable<E>? {
  bool isNotNullAndIsNotEmpty() => this != null && this!.isNotEmpty == true;
  bool isNullOrEmpty() => this == null || this!.isEmpty == true;
}

extension NestedIterableExtension<E> on Iterable<Iterable<E>> {
  Iterable<E> expanded() => expand((element) => element);
}
