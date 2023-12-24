import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/store_feature/data/repository/plans/plans_repository.dart';
import 'package:piix_mobile/store_feature/domain/model/plans_list_model.dart';
import 'package:piix_mobile/store_feature/domain/model/plan_model_deprecated.dart';
import 'package:piix_mobile/store_feature/domain/model/plan_quote_price_model.dart';
import 'package:piix_mobile/store_feature/domain/model/quote_price_request_model/plans_quote_price_request_model_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This BLoC is where all the levels logic is located
///
class PlansBLoCDeprecated with ChangeNotifier {
  ///Stores the [PlanStateDeprecated] and is used by all the
  ///methods that call an api inside [PlanStateDeprecated]
  PlanStateDeprecated _planState = PlanStateDeprecated.idle;
  PlanStateDeprecated get planState => _planState;
  set planState(PlanStateDeprecated state) {
    _planState = state;
    notifyListeners();
  }

  ///Stores the [PlanStateDeprecated] and is used by all the
  ///methods that call an api inside [quotationState]
  PlanStateDeprecated _quotationPlanState = PlanStateDeprecated.idle;
  PlanStateDeprecated get quotationPlanState => _quotationPlanState;
  set quotationPlanState(PlanStateDeprecated state) {
    _quotationPlanState = state;
    notifyListeners();
  }

  ///Stores a plan list in [PlansListModel]
  PlansListModel? _plansList;
  PlansListModel? get plansList => _plansList;

  List<PlanModel> _plansWithoutProtectedList = [];
  List<PlanModel> get plansWithoutProtectedList => _plansWithoutProtectedList;

  void addPlanToSelectPlanList(PlanModel plan) {
    _plansWithoutProtectedList.add(plan);
    notifyListeners();
  }

  void removePlanFromSelectPlanList(String planId) {
    _plansWithoutProtectedList
        .removeWhere((element) => element.planId == planId);
    notifyListeners();
  }

  List<PlanModel> _plansWithProtectedAcquiredList = [];
  List<PlanModel> get plansWithProtectedAcquiredList =>
      _plansWithProtectedAcquiredList;

  void addPlanToQuotationList(PlanModel plan) {
    plan.maybeMap((value) {
      _plansWithProtectedAcquiredList.add(
        value.copyWith(
          protectedAcquired: 1,
        ),
      );
      notifyListeners();
    }, orElse: () {});
  }

  void removePlanFromQuotationList(String planId) {
    _plansWithProtectedAcquiredList
        .removeWhere((element) => element.planId == planId);
    notifyListeners();
  }

  String? _removedPlanName;
  String? get removedPlanName => _removedPlanName;
  set removedPlanName(String? name) {
    _removedPlanName = name;
    notifyListeners();
  }

  ///Stores the apackage combo by id [PlanQuotePriceModel]
  PlanQuotePriceModel? _planQuotation;
  PlanQuotePriceModel? get planQuotation => _planQuotation;

  ///Stores the plans ids
  String? _currentPlanIds;
  String? get currentPlanIds => _currentPlanIds;
  set currentPlanIds(String? id) {
    _currentPlanIds = id;
    notifyListeners();
  }

  ///Stores the plans ids
  int _protectedCount = 0;
  int get protectedCount => _protectedCount;
  set protectedCount(int count) {
    _protectedCount = count;
    notifyListeners();
  }

  ///Instantiated a service locator for [PlansRepositoryDeprecated]
  ///
  PlansRepositoryDeprecated get _plansRepository =>
      getIt<PlansRepositoryDeprecated>();

  ///Retrieves the detailed information of a plans
  /// by calling [_plansRepository] getPackageCombosByMembership
  /// method.
  ///
  /// Stores the plan list in [plansList]
  ///  and establishes the [PlanStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [PlanStateDeprecated]
  /// in [planState] as error, conflict, notFound or unexpectedError.
  /// These states can be set since the service response can be conflict,
  ///  not found or unexpectedError;
  ///
  Future<void> getPlansByMembership({
    required String membershipId,
  }) async {
    try {
      planState = PlanStateDeprecated.getting;
      final data = await _plansRepository.getPlansByMembershipRequested(
          membershipId: membershipId);

      if (data is PlanStateDeprecated) {
        _planState = data;
        _plansList = null;
      } else {
        _plansList = PlansListModel.fromJson(data);
        if (plansList!.plans.isEmpty) {
          _planState = PlanStateDeprecated.empty;
        } else {
          _planState = PlanStateDeprecated.accomplished;
          final plansWithoutProtectedListToSort = _plansList!.plans
              .where(
                (plan) => plan.maxUsersInPlan > plan.protectedAcquired,
              )
              .toList();
          plansWithoutProtectedListToSort.sort(
            (a, b) => a.name.compareTo(b.name),
          );
          _plansWithoutProtectedList = plansWithoutProtectedListToSort;
          _plansWithProtectedAcquiredList = [];
        }
      }
      notifyListeners();
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getPlansByMembership '
            'with id $membershipId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      planState = PlanStateDeprecated.error;
    }
  }

  ///Retrieves the detailed information of a plans
  /// by calling [_plansRepository]
  /// getPackageCombosWithDetailsAndPriceByMembership method.
  ///
  /// Stores the package combo by id in [planQuotation]
  /// and establishes the [PlanStateDeprecated] accomplished
  /// if the request is successful.
  ///
  /// If the request is not successful it either sets [PlanStateDeprecated]
  /// in [planState] as error, conflict, notFound or unexpectedError.
  /// These states can be set since the service response can be conflict,
  ///  not found or unexpectedError
  ///
  Future<PlanStateDeprecated> getPlansQuotationByMembership(
      {required PlansQuotePriceRequestModel requestModel}) async {
    try {
      quotationPlanState = PlanStateDeprecated.getting;
      final data = await _plansRepository.getPlansQuotationByMembership(
          requestModel: requestModel);
      if (data is PlanStateDeprecated) {
        _quotationPlanState = data;
        _planQuotation = null;
      } else {
        _planQuotation = PlanQuotePriceModel.fromJson(data);
        if (planQuotation!.plans.isEmpty) {
          _quotationPlanState = PlanStateDeprecated.empty;
        } else {
          _quotationPlanState = PlanStateDeprecated.accomplished;
        }
      }
      notifyListeners();
      return _quotationPlanState;
    } catch (e) {
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in '
            'getPackageCombosWithDetailsAndPriceByMembership '
            'with id membership ${requestModel.membershipId}'
            ' and plan ids ${requestModel.planIds} ',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      quotationPlanState = PlanStateDeprecated.error;
      return _quotationPlanState;
    }
  }
}
