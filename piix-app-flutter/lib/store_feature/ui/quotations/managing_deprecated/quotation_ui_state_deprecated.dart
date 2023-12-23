import 'package:flutter/material.dart';
import 'package:piix_mobile/enums/enums.dart';

@Deprecated('Will be removed in 4.0')
class QuotationUiStateDeprecated {
  QuotationUiStateDeprecated({required this.setState});
  final StateSetter setState;

  AlertStateDeprecated _showBuyingTips = AlertStateDeprecated.show;
  AlertStateDeprecated get showBuyingTips => _showBuyingTips;
  set showBuyingTips(AlertStateDeprecated value) {
    _showBuyingTips = value;
    setState(() {});
  }

  ///This function is used for hide plan alert automatically
  ///
  void hideBuyingTipsAlert() {
    showBuyingTips = AlertStateDeprecated.hide;
  }

  void cleanState() {
    showBuyingTips = AlertStateDeprecated.show;
  }
}
