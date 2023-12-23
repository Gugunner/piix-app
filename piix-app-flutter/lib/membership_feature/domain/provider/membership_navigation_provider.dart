import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_navigation_provider.g.dart';


///A Riverpod Notifier class that handles the state of the 
///[MembershipNavigationBar] when the user selects an option
///and stores it.
@Riverpod(keepAlive: true)
class NavigateMembershipNotifier extends _$NavigateMembershipNotifier {
  @override
  int build() => 0;

  void set(int navigationBarItemIndex) {
    state = navigationBarItemIndex;
    navigateTo(navigationBarItemIndex);
  }

  int get currentNavigationBarItem => state;
  
  ///Depending on the [navigationItemIndex] the
  ///user navigates to a specific screen
  void navigateTo(int navigationItemIndex) {
    //TODO: Navigate to Membership Screen
    //TODO: Navigate to Protected screen
    //TODO: Navigate to Store screen
    //TODO: Navigate to Profile Screen
  }
}
