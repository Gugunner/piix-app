///Handles methods that instead of mutating a List
///it returns a new List with the changes.
extension ImmutableList on List {
  ///Returns a new list [T] with the updated value of
  ///type [T] in the selected index.
  List<T> updateIndexValue<T>(int index, {required T value}) => [
        if (index == 0) ...[
          value,
          ...sublist(1),
        ] else ...[
          ...sublist(0, index),
          value,
          ...sublist(index + 1),
        ],
      ];

  List<T> removeIndexValue<T>(int index) => [
        if (index == 0) ...[
          ...sublist(1),
        ] else ...[
          ...sublist(0, index),
          ...sublist(index + 1)
        ]
      ];
}

///Utils to expand the list current usages
extension ExeptionGuardList on List {
  ///Returns the [index]th element.
  ///
  ///Use [guard] to get null when the element
  ///is not found at the [index].
  T? guardElementAt<T>(int index, {bool guard = true}) {
    try {
      return elementAt(index);
    } catch (e) {
      if (!guard) rethrow;
      return null;
    }
  }
}
