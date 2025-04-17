extension ListExtensions on List {
  bool isAllTrue() {
    return every((element) => element is bool && element == true);
  }
}
