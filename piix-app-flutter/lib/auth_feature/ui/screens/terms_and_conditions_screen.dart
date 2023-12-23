import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/general_app_feature/api/local/app_shared_preferences.dart';
import 'package:piix_mobile/html_feature/domain/provider/html_provider.dart';
import 'package:piix_mobile/utils/shimmer/shimmer_barrel_file.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';
import 'package:piix_mobile/widgets/app_bar/logo_app_bar.dart';
import 'package:piix_mobile/widgets/app_loading_widget/app_loading_widget.dart';

///A static screen that requests from the api services the
///up to date terms and conditions of the app.
///
///If the terms can't be loaded the app can still try to show
///the user the last terms stored by the app. If the most
///updated terms are loaded the new terms are stored in memory.
class TermsAndConditionsScreen extends AppLoadingWidget {
  static const routeName = '/terms_and_conditions_screen';

  const TermsAndConditionsScreen({
    super.key,
  });

  @override
  ConsumerState<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState
    extends AppLoadingWidgetState<TermsAndConditionsScreen> {
  ///The x axis padding of the screen.
  double get _horizontal => 16.w;

  ///The y axis padding of the screen.
  double get _vertical => 16.h;

  ///The model that will store the html information
  ///once the api request finishes.
  HtmlModel? _html;

  @override
  Future<void> whileIsRequesting() async =>
      ref.watch(termsAndConditionsPodProvider).whenOrNull(data: (html) {
        _storeHtmlModel(html);
        endRequest();
      }, error: (error, stackTrace) {
        Future.delayed(const Duration(seconds: 1), () {
          _retrieveHtmlModel();
          endRequest();
        });
      });

  ///Saves the state if the [_html] property and adds
  ///the correct [Style] to the terms and conditions
  ///[_html].
  ///
  ///It also stores in [AppSharedPreferences] the [htmlText].
  Future<void> _storeHtmlModel(HtmlModel html) async {
    Future.microtask(() async {
      setState(() {
        _html = html.addStyle(
          HtmlTermsAndConditionsParser.termsAndConditionsStyle,
        );
      });
      await AppSharedPreferences.saveHtmlTerms(_html!.htmlText);
    });
  }

  ///If the request fails then the app tries to recover the [htmlText]
  ///from the [AppSharedPreferences] if it is possible it adds the
  ///correct [Style] and then saves the state.
  Future<void> _retrieveHtmlModel() async {
    var htmlText = await AppSharedPreferences.recoverHtmlTerms();
    if (kDebugMode) {
      htmlText = HtmlTermsAndConditionsParser.termsAndConditionsHtmlTextExample;
    }
    final html = HtmlModel(htmlText: htmlText!);
    setState(() {
      _html = html.addStyle(
        HtmlTermsAndConditionsParser.termsAndConditionsStyle,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //Can call an async method because it won't rebuild.
    if (isRequesting) whileIsRequesting();
    return Scaffold(
      appBar: LogoAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: _horizontal,
          vertical: _vertical,
        ),
        child: SizedBox(
          child: Builder(builder: (context) {
            //TODO: Add an error screen when designed
            ///If html is not loaded it keeps loading
            if (_html == null)
              return SizedBox(
                child: Shimmer(
                  child: ShimmerLoading(
                    isLoading: isRequesting,
                    child: Column(
                      children: [
                        ShimmerWrap(
                          child: SizedBox(
                            height: 60.h,
                            width: context.width,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        ShimmerWrap(
                          child: SizedBox(
                            height: 80.h,
                            width: context.width,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        ShimmerWrap(
                          child: SizedBox(
                            height: context.height,
                            width: context.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

            return Html(
              data: _html!.htmlText,
              style: _html!.style!,
            );
          }),
        ),
      ),
    );
  }
}
