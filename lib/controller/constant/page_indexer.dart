class PageViewIndexer {
  static final PageViewIndexer _instance = PageViewIndexer._internal();
  factory PageViewIndexer() => _instance;
  PageViewIndexer._internal();
  static get instance => _instance;
  int previousIndex = 0;
  int currentIndex = 0;
  Future<void> next(int index) async {
    previousIndex = currentIndex;
    currentIndex = index;
  }

  Future<int> previous() async {
    int mid = currentIndex;
    currentIndex = previousIndex;
    previousIndex = mid;
    return currentIndex;
  }
}
