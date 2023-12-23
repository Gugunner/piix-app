import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/domain/provider/auth_input_provider.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_input_state_enum.dart';
import 'package:piix_mobile/auth_user_feature_deprecated/utils/auth_user_copies.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/extensions/build_context_extension.dart';

///A [TextFormField] widget for entering authentication credentials.
///
///Can handle an onSubmit call by passing an [onPress] argument and
///assigngin the [action] to TextInputAction.done or TextInputAction.save.
class AuthInputWidget extends ConsumerStatefulWidget {
  const AuthInputWidget({
    super.key,
    this.action = TextInputAction.done,
    this.textInputType,
    this.onPress,
  });

  ///Change action to control keyboard submit button
  final TextInputAction action;

  ///Change between phone or email
  final TextInputType? textInputType;

  ///Add the callback to handle onEditingComplete, requires action
  ///to be TextInputAction.send, TextInputAction.done or TextInputAction.next
  final VoidCallback? onPress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthInputWidgetState();
}

class _AuthInputWidgetState extends ConsumerState<AuthInputWidget> {
  bool submit = false;
  final FocusNode focusNode = FocusNode();
  String value = '';

  void _onSubmit() {
    final userNameCredentialNotifier =
        ref.read(usernameCredentialProvider.notifier);
    //Stores the value entered
    userNameCredentialNotifier.set(
      value,
    );
    //Submitting unfocuses the widget
    if (focusNode.hasFocus || focusNode.hasPrimaryFocus) {
      focusNode.unfocus();
    }
    userNameCredentialNotifier.check(
      value,
    );

    ///Checks if the entered information is valid
    if (!submit) {
      //Changes submit state to true so AutoValidateMode
      //is set to onUserInteraction
      setState(() {
        submit = true;
      });
    }
  }

  void _onChange(String text) {
    final userNameCredentialNotifier =
        ref.read(usernameCredentialProvider.notifier);
    //Stores entered information in the widget state
    setState(() {
      value = text;
    });
    //Resets the error state if any after a change occurs and no format
    // error is detected once the user tries to submit the information
    if (submit) {
      userNameCredentialNotifier.check(
        value,
      );
    }
  }

  //Action that occurs when done, next or send is in the TextInputAction
  void _onEditingComplete() {
    final authInputState = ref.read(authInputProvider);

    ///Submits the information normally
    _onSubmit();
    //Checks for any errors before proceeding to send the information
    if (!authInputState.incorrect) {
      //
      widget.onPress?.call();
    }
  }

  @override
  void initState() {
    //Add a listener to refresh the Ui each time this focus changes
    focusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authInputState = ref.watch(authInputProvider);
    return SizedBox(
      child: TextFormField(
        focusNode: focusNode,
        keyboardType: widget.textInputType ?? TextInputType.phone,
        textInputAction: widget.action,
        onChanged: _onChange,
        onEditingComplete: _onEditingComplete,
        onSaved: (_) => _onSubmit(),
        validator: authInputState.validate,
        autovalidateMode: submit ? AutovalidateMode.onUserInteraction : null,
        decoration: decoration,
        style: context.textTheme?.titleMedium,
      ),
    );
  }
}

extension _AuthInputWidgetDecoration on _AuthInputWidgetState {
  Color labelColor(AuthInputState authInputState) {
    if (authInputState.incorrect) {
      return PiixColors.error;
    } else if (focusNode.hasFocus || focusNode.hasPrimaryFocus) {
      return PiixColors.insurance;
    }
    return PiixColors.infoDefault;
  }

  TextStyle? labelStyle(AuthInputState authInputState) =>
      context.textTheme?.bodyMedium?.copyWith(
        color: labelColor(authInputState),
      );
  InputDecoration get decoration {
    final authInputState = ref.read(authInputProvider);
    final authMethod = ref.read(authMethodStateProvider);
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      helperText: authMethod.isPhoneNumber
          ? AuthUserCopies.enterPhone
          : AuthUserCopies.enterEmail,
      helperStyle: context.textTheme?.labelMedium?.copyWith(
        color: labelColor(authInputState),
      ),
      errorText: authInputState.validate(value),
      errorStyle: context.textTheme?.labelMedium?.copyWith(
        color: PiixColors.error,
      ),
      labelText: authMethod.isPhoneNumber
          ? AuthUserCopies.phone
          : AuthUserCopies.email,
      labelStyle: labelStyle(authInputState),
      floatingLabelStyle: labelStyle(authInputState),
    );
  }
}
