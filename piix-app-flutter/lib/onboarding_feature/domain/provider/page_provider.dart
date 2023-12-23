import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_provider.g.dart';

@riverpod
class PageNotifier extends _$PageNotifier {
  @override
  int build() => 0;

  int get page => state;

  void setPage(int page) {
    state = page;
  }
}

@riverpod
class PageControllerNotifier extends _$PageControllerNotifier {
  @override
  PageController build() =>
      PageController(initialPage: ref.read(pageNotifierProvider));

  PageController get controller => state;

  Future<void> nextPage() => controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );

  Future<void> previousPage() => controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
}
