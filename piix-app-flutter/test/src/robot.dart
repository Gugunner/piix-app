import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piix_mobile/app_bootstrap.dart';
import 'package:piix_mobile/app_bootstrap_fake.dart';
import 'package:piix_mobile/src/constants/screen_breakpoints.dart';
import 'package:piix_mobile/src/utils/set_preferred_orientations.dart';

import 'goldens/golden_robot.dart';

/// A robot that helps with testing the app with fakes
/// and golden files.
///
/// It also helps with testing the app with different
/// screen sizes.
class Robot {
  Robot(this.tester) : golden = GoldenRobot(tester);

  final WidgetTester tester;
  final GoldenRobot golden;

  final List<MethodCall> _methods = [];

  Future<void> pumpMyAppWithFakes() async {
    const appBootstrap = AppBootstrap('fake');
    final container = await appBootstrap.createFakeProviderContainer();
    //TODO: Initialize providers here
    await addWidgetBindingsMethodListener();
    //* Initialize MyApp for the test
    await tester.pumpWidget(
      appBootstrap.createHome(container: container),
    );
    //* Makes sure the Page is rendered
    await tester.pumpAndSettle();
  }

  /// Adds a listener to the SystemChannels.platform channel
  Future<void> addWidgetBindingsMethodListener() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform,
            (MethodCall methodCall) async {
      //* Each method call is added to the _methods list
      _methods.add(methodCall);
      return null;
    });
  }

  /// Expects a call to setPreferredOrientations based on the
  /// test screen size.
  Future<void> expectCallSetPrefferedOrientations(Size size) async {
    setPreferredOrientations(size.width, size.height);
    expect(_methods, isNotEmpty);
    if (size.width >= ScreenBreakPoint.md &&
        size.height >= ScreenBreakPoint.md) {
      expect(
          _methods.first,
          isMethodCall('SystemChrome.setPreferredOrientations',
              arguments: <String>[
                'DeviceOrientation.landscapeLeft',
                'DeviceOrientation.landscapeRight',
                'DeviceOrientation.portraitDown',
                'DeviceOrientation.portraitUp',
              ]));
    } else {
      expect(
          _methods.first,
          isMethodCall('SystemChrome.setPreferredOrientations',
              arguments: <String>[
                'DeviceOrientation.portraitDown',
                'DeviceOrientation.portraitUp',
              ]));
    }
  }
}
