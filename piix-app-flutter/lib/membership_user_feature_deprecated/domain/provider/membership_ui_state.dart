import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';

///This class managing all membership ui states
///
class MembershipUiState {
  MembershipUiState({required this.setState});
  final StateSetter setState;

  bool _isAdditionsTab = false;
  bool get isAdditionsTab => _isAdditionsTab;
  void toggleMembershipTab() {
    _isAdditionsTab = !_isAdditionsTab;
    setState(() {});
  }

  String _loadText = ConstantsDeprecated.placeHolderString;
  String get loadText => _loadText;
  void setLoadText(String value) {
    _loadText = value;
    setState(() {});
  }
}
