
///Defines the method used to pass values from a child
///[Widget] to its parent [Form] class.
typedef HandleFormValue<T> = void Function({
  required T? value,
  int? index,
  bool? required,
});
