import 'package:piix_mobile/widgets/screen/app_screen/app_screen.dart';

class PopAppScreen extends AppScreen {
  const PopAppScreen({
    super.key,
    required super.onWillPop,
    required super.appBar,
    super.bottomNavigationBar,
    super.drawer,
    required super.body,
    super.shouldIgnore,
    super.onUnfocus,
  })  : assert(onWillPop != null),
        assert(appBar != null),
        assert(body != null);
}
