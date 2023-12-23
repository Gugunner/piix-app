import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/auth_feature/domain/provider/verification_code_provider_deprecated.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/data/repository/auth_service_repository.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_service_provider_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';
import 'package:provider/provider.dart';

@Deprecated('Use instead VerificationCodeBox')
class VerificationCodeWidgetDeprecated extends ConsumerStatefulWidget {
  const VerificationCodeWidgetDeprecated({
    super.key,
    required this.index,
    this.hasError = false,
  });

  final int index;
  final bool hasError;

  @override
  ConsumerState<VerificationCodeWidgetDeprecated> createState() =>
      _VerificationCodeWidgetState();
}

class _VerificationCodeWidgetState
    extends ConsumerState<VerificationCodeWidgetDeprecated> {
  late VerificationCode verificationCodeProviderNotifier;
  final focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(_onFocus);
    super.initState();
  }

  bool get hasFocus => focusNode.hasFocus || focusNode.hasPrimaryFocus;

  void _refresh() => setState(() {});

  void _onFocus() {
    if (hasFocus) {
      final authServiceProvider = context.read<AuthServiceProvider>();
      authServiceProvider.setVerificationCodeState(VerificationCodeState.idle);
      _refresh();
      return;
    }
    focusNode.unfocus();
    _refresh();
  }

  void _onChanged(String textValue, int index) {
    final value = textValue.isEmpty ? -1 : int.parse(textValue);
    verificationCodeProviderNotifier.setVerificationCodeBy(
      index,
      value: value,
    );
    ref
        .read(verificationStatePodProvider.notifier)
        .setVerificationState(VerificationStateDeprecated.idle);
    if (textValue.length == 1) {
      FocusManager.instance.primaryFocus?.nextFocus();
    }
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    verificationCodeProviderNotifier =
        ref.watch(verificationCodeProvider.notifier);
    return SizedBox(
      width: 40.w,
      height: 48.h,
      child: TextFormField(
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        onChanged: (value) => _onChanged(value, widget.index),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: style(context),
        textAlign: TextAlign.center,
        decoration: decoration(context),
      ),
    );
  }
}

extension _VerificationCodeWidgetDecoration on _VerificationCodeWidgetState {
  Color get textColor => widget.hasError
      ? PiixColors.error
      : hasFocus
          ? PiixColors.active
          : PiixColors.infoDefault;

  Color get borderColor => widget.hasError
      ? PiixColors.error
      : hasFocus
          ? PiixColors.active
          : PiixColors.secondary;

  TextStyle? style(BuildContext context) =>
      context.textTheme?.titleMedium?.copyWith(
        color: textColor,
      );

  InputDecoration decoration(BuildContext context) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
    );
  }
}
