// ignore_for_file: unused_local_variable
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/data/repository/benefit_form_repository_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_form_provider.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/bloc/benefit_per_supplier_bloc_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/domain/model/benefit_per_supplier_model_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/benefit_form_states_screen_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/ui/widgets/benefit_form_data_deprecated.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/benefit_form_utils_deprecated.dart';
import 'package:piix_mobile/email_feature/data/repository/email_system_repository.dart';
import 'package:piix_mobile/email_feature/domain/bloc/email_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/data/repository/catalog_repository.dart';
import 'package:piix_mobile/general_app_feature/data/repository/file_system_repository_deprecated.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/catalog_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/connectivity_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/file_system_bloc.dart';
import 'package:piix_mobile/general_app_feature/domain/bloc/ui_bloc.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/constants_deprecated.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_copies_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/membership_provider_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/ui/widgets/membership/piix_app_bar_deprecated.dart';
import 'package:piix_mobile/ui/common/clamping_scale_deprecated.dart';
import 'package:piix_mobile/widgets/no_internet.dart';
import 'package:piix_mobile/ui/common/piix_refresh.dart';
import 'package:provider/provider.dart';

@Deprecated('No longer in use in 4.0')

/// This screen renders the instructions and the benefit form.
class BenefitFormScreenDeprecated extends ConsumerStatefulWidget {
  static const routeName = '/benefit-form';

  const BenefitFormScreenDeprecated({super.key});

  @override
  ConsumerState createState() => _BenefitFormScreenState();
}

class _BenefitFormScreenState
    extends ConsumerState<BenefitFormScreenDeprecated> {
  late CatalogBLoC catalogBLoC;
  late BenefitPerSupplierBLoCDeprecated benefitPerSupplierBLoC;
  late MembershipProviderDeprecated membershipInfoBLoC;
  late UserBLoCDeprecated userBLoC;
  late BenefitFormNotifier benefitFormNotifier;
  late UiBLoC uiBLoC;
  late FileSystemBLoC fileSystemBLoC;

  @override
  void initState() {
    catalogBLoC = context.read<CatalogBLoC>();
    membershipInfoBLoC = context.read<MembershipProviderDeprecated>();
    benefitPerSupplierBLoC = context.read<BenefitPerSupplierBLoCDeprecated>();
    userBLoC = context.read<UserBLoCDeprecated>();
    uiBLoC = context.read<UiBLoC>();
    fileSystemBLoC = context.read<FileSystemBLoC>();
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserBLoCDeprecated>().user;
    benefitFormNotifier = ref.read(benefitFormProvider);
    final connectivityBLoC = context.watch<ConnectivityBLoC>();
    return ScreenUtilInit(
      designSize: ConstantsDeprecated.designSize,
      useInheritedMediaQuery: true,
      builder: (_, __) => ClampingScaleDeprecated(
        child: Scaffold(
          backgroundColor: PiixColors.twilightBlue,
          appBar: benefitFormNotifier.benefitFormState ==
                      BenefitFormStateDeprecated.sent ||
                  benefitFormNotifier.benefitFormState ==
                      BenefitFormStateDeprecated.sendError
              ? null
              : const PiixAppBarDeprecated(
                  title: PiixCopiesDeprecated.benefitFormLabel),
          body: !connectivityBLoC.fullConnection
              ? const NoInternet()
              : !connectivityBLoC.isConnectionAvailable
                  ? PiixRefresh(onRefresh: _initScreen)
                  : BenefitFormStatesScreen(
                      onConfirm: () => _onConfirm(context),
                      onSubmitForm: _onSubmitForm,
                    ),
        ),
      ),
    );
  }

  Future<void> _initScreen() async {
    uiBLoC..loadText = PiixCopiesDeprecated.gettingBenefitForm;
    final packageId = membershipInfoBLoC.selectedMembership?.package.id;
    final selectedCobenefit = benefitPerSupplierBLoC
        .selectedCobenefitPerSupplier
        ?.mapOrNull((value) => null, cobenefit: (value) => value);
    //This method is only called when it is a co-benefit form, since a
    //co-benefit can have a different provider than the parent benefit,
    //so we call it here only when it is a co-benefit form
    if (selectedCobenefit != null &&
        selectedCobenefit.supplier.logo.isNotEmpty) {
      await _setCobenefitSupplierLogo(selectedCobenefit);
    }
    if (packageId != null) {
      await Future.wait([
        if (catalogBLoC.kinships.isEmpty)
          catalogBLoC.getAllFromCatalogName(CatalogName.kinships),
        benefitFormNotifier.getBenefitForm(),
      ]);
    }
  }

  Future<void> _setCobenefitSupplierLogo(
      BenefitPerSupplierModel selectedCobenefit) async {
    final fileModel = await fileSystemBLoC.getFileFromPath(
      userId: userBLoC.user?.userId ?? '',
      filePath: selectedCobenefit.supplier?.logo ?? '',
      propertyName: 'supplierLogo',
    );
    if (fileModel != null) {
      benefitPerSupplierBLoC.setCobenefitSupplierLogo(fileModel);
    }
  }

  void _onConfirm(BuildContext context) {
    if (benefitFormNotifier.benefitFormState ==
            BenefitFormStateDeprecated.retrievedError ||
        benefitFormNotifier.benefitFormState ==
            BenefitFormStateDeprecated.notFound ||
        benefitFormNotifier.benefitFormState ==
            BenefitFormStateDeprecated.sendError) {
      _onRetry(context);
      return;
    }
    _onSuccess(context);
  }

  void _onRetry(BuildContext context) async {
    final userBLoc = context.read<MembershipProviderDeprecated>();
    final packageId = membershipInfoBLoC.selectedMembership?.package.id;
    if (benefitFormNotifier.benefitFormState ==
            BenefitFormStateDeprecated.retrievedError ||
        benefitFormNotifier.benefitFormState ==
            BenefitFormStateDeprecated.notFound) {
      await _initScreen();
      return;
    }
    if (benefitFormNotifier.benefitFormState ==
        BenefitFormStateDeprecated.sendError) {
      await _onSubmitForm();
    }
  }

  void _onSuccess(BuildContext context) {
    final emailSystemBLoC = context.read<EmailSystemBLoC>();
    final fileSystemBLoC = context.read<FileSystemBLoC>();
    benefitFormNotifier.benefitForm = null;
    benefitFormNotifier.benefitFormState = BenefitFormStateDeprecated.idle;
    emailSystemBLoC.emailState = EmailState.idle;
    fileSystemBLoC.file = null;
    fileSystemBLoC.fileState = FileStateDeprecated.idle;
    uiBLoC
      ..isLargeContainer = false
      ..loadText = '';
    Navigator.pop(context);
  }

  Future<void> _onSubmitForm() async {
    if (benefitFormKey.currentState == null) {
      benefitFormNotifier.benefitFormState =
          BenefitFormStateDeprecated.retrieved;
      return;
    }
    if (!(benefitFormKey.currentState!.validate())) {
      return;
    }
    benefitFormNotifier.benefitFormState = BenefitFormStateDeprecated.sending;
    uiBLoC.loadText = PiixCopiesDeprecated.sendingBenefitForm;
    final user = userBLoC.user;
    final packageId = membershipInfoBLoC.selectedMembership?.package.id;
    final benefitForm = benefitFormNotifier.benefitForm;
    if (user == null ||
        packageId == null ||
        benefitForm == null ||
        repaintBenefitFormKey.currentContext == null) return;
    final boundary = repaintBenefitFormKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      return;
    }
    await onSendBenefitForm(
      user: user,
      packageId: packageId,
      benefitForm: benefitForm,
      screenshotForm: byteData,
      ref: ref,
    );
  }
}
