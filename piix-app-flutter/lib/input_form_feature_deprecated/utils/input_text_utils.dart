

String getTextLabel(List<String> nameArray, bool isRequired) {
  final currentName = nameArray.length > 1 ? nameArray[1] : nameArray[0];
  if (currentName.length > 84) {
    return '';
  }
  final splitArray = currentName.split('/');
  if (splitArray.length > 1) {
    return splitArray.length > 2
        ? isRequired
            ? '${splitArray[splitArray.length - 1]} *'
            : '${splitArray[splitArray.length - 1]}'
        : isRequired
            ? '* $currentName}'
            : currentName;
  }
  return isRequired ? '$currentName*' : currentName;
}

List<String> splitTextBy({required String name, String indicator = '. - '}) {
  return name.split(indicator);
}
