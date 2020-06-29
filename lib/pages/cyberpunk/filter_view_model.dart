import 'package:rxdart/rxdart.dart';

class FilterViewModel {
  BehaviorSubject<bool> hasFilter = BehaviorSubject.seeded(true);

  FilterViewModel();

  void showFilter({bool isShow}) {
    hasFilter.add(isShow??true);
  }
}