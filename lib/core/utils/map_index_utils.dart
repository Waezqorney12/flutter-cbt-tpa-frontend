extension ListExtension on List {
  Iterable<X> mapIndexed<X, T>({required X Function(int, T) funct}) => asMap().entries.map(
        (e) => funct(e.key, e.value as T),
      );
}
