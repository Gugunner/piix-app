import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piix_mobile/src/my_app.dart';

import '../../../robot.dart';
import '../../device_sizes.dart';
import '../../golden_variant.dart';

///Golden test for the welcome page on web layout.
void main() {
  final webVariant = ValueVariant({
    const GoldenVariant(TargetPlatform.macOS, DeviceSizes.webMobile),
    const GoldenVariant(TargetPlatform.macOS, DeviceSizes.webTablet),
    const GoldenVariant(TargetPlatform.macOS, DeviceSizes.webDesktop),
  });

  testWidgets(
    'Golden Welcome Page Web',
    (tester) async {
      //* This is the robot that will help us interact with the widgets
      final robot = Robot(tester);
      //* Get the current variant
      final currentVariant = webVariant.currentValue!;
      //* Get the current size from the current variant
      final currentSize = currentVariant.size;
      //* Setup the golden test surface size and load all the necessary fonts
      await robot.golden.setSurfaceSize(currentSize);
      await robot.golden.loadMaterialIconFont();
      await robot.golden.loadRalewayFont();
      //* Set the platform for the test to run
      //* Use any value that is not android or iOS to change the platform to web
      debugDefaultTargetPlatformOverride = currentVariant.platform;
      //* Pump the app with fakes
      await robot.pumpMyAppWithFakes();
      //* Precache all the images and svgs
      await robot.golden.precacheDecorationImages();
      await robot.golden.precacheImages();
      await robot.golden.precacheSvgs();
      await expectLater(
        find.byType(MyApp),
        matchesGoldenFile(
          currentVariant.getGoldenFileName('welcome_page'),
        ),
      );
      //* Checks if the setPreferredOrientations method was called
      await robot.expectCallSetPrefferedOrientations(currentSize);
      //* Always return platform to null to avoid an assert exception
      debugDefaultTargetPlatformOverride = null;
    },
    variant: webVariant,
    tags: ['golden', 'layout', 'web'],
    skip: false,
  );
}