import 'package:rxdart/rxdart.dart';

class TabBarViewModel {
  final currentTabIndex = BehaviorSubject<int>.seeded(0);

  void setCurrentTabIndex(int index) {
    currentTabIndex.add(index);
  }

  void dispose() {
    currentTabIndex.close();
  }
}
