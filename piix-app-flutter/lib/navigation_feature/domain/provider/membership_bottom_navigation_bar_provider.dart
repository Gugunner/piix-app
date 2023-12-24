import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_bottom_navigation_bar_provider.g.dart';

///A Riverpod Notifier Provider that handles the app state
///of the [AppBottomNavigationBar] when the user selects a 
///navigation item.
@Riverpod(keepAlive: true)
class BottomNavigationPod extends _$BottomNavigationPod {
  //Initialize in 0.
  @override
  int build() => 0;
  //Update the current item selected.
  void set(int index) => state = index;
  //Retrieve current item index selected.
  int get() => state;
  //Reset the item to the first one.
  void reset() => state = 0;
}
