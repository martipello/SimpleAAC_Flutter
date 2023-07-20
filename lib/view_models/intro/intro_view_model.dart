import 'package:rxdart/rxdart.dart';

class IntroViewModel {
  final currentPageStream = BehaviorSubject<int>.seeded(0);

  void setCurrentPage(final int currentPage) {
    currentPageStream.add(currentPage);
  }
}
