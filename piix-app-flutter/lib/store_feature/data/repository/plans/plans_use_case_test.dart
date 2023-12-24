import 'package:piix_mobile/store_feature/data/repository/plans/plans_repository.dart';

///Is a use case test extension of [PlansRepositoryDeprecated]
///Contains all api mock calls
///
extension PlansUseCaseTest on PlansRepositoryDeprecated {
  ///Gets plans by membership id mock
  ///
  Future<dynamic> getPlansByMembershipRequestedTest(
      {required PlanResponseTypesDeprecated type}) async {
    return await Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case PlanResponseTypesDeprecated.empty:
          return [];
        case PlanResponseTypesDeprecated.success:
          return fakePlansJson;
        case PlanResponseTypesDeprecated.error:
          return PlanStateDeprecated.error;
        case PlanResponseTypesDeprecated.unexpectedError:
          return PlanStateDeprecated.unexpectedError;
        case PlanResponseTypesDeprecated.conflict:
          return PlanStateDeprecated.conflict;
      }
    });
  }

  ///Gets plans quotation by plans ids and
  ///membership id mock
  ///
  Future<dynamic> getPlansQuotationByMembershipTest(
      {required PlanResponseTypesDeprecated type}) async {
    return await Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case PlanResponseTypesDeprecated.success:
          return fakePlanQuotationJson;
        case PlanResponseTypesDeprecated.error:
          return PlanStateDeprecated.error;
        case PlanResponseTypesDeprecated.unexpectedError:
        default:
          return PlanStateDeprecated.unexpectedError;
      }
    });
  }

  Map<String, dynamic> get fakePlansJson => {
        'protectedLimit': 12,
        'totalProtectedAcquired': 1,
        'plans': [
          {
            'planId': 'd34662902dc43f109ff0e0440b1d18ecb226019e5f520ef9be',
            'folio': 'plan-2',
            'name': 'Hija',
            'pseudonym': 'Hija',
            'maxUsersInPlan': 2,
            'kinshipId': 'kinship11',
            'registerDate': '2022-07-14T15:38:18.000Z',
            'protectedAcquired': 0
          },
          {
            'planId': 'f45d5921fa5d6d2af44fcf9c91c76fa8a3d7ac9d686881a1e1',
            'folio': 'plan-8',
            'name': 'Conyuge',
            'pseudonym': 'Conyuge',
            'maxUsersInPlan': 1,
            'kinshipId': 'kinship2',
            'registerDate': '2022-07-14T15:38:18.000Z',
            'protectedAcquired': 1
          }
        ]
      };

  Map<String, dynamic> get fakePlansEmptyJson =>
      {'protectedLimit': 12, 'totalProtectedAcquired': 1, 'plans': []};

  Map<String, dynamic> get fakePlanQuotationJson => {
        'plans': [
          {
            'planId': 'd34662902dc43f109ff0e0440b1d18ecb226019e5f520ef9be',
            'folio': 'plan-2',
            'name': 'Hija',
            'pseudonym': 'Hija',
            'maxUsersInPlan': 2,
            'kinshipId': 'kinship11',
            'registerDate': '2022-07-14T15:38:18.000Z',
            'updateDate': null,
            'deleteDate': null,
            'protectedAcquired': 1
          }
        ],
        'productRates': {
          'summedOriginalRiskPremium': 2243,
          'summedRiskPremium': 1694,
          'summedNetPremium': 1907,
          'summedTotalPremium': 2264,
          'marketDiscount': 0.01,
          'volumeDiscount': 0.001,
          'finalDiscount': 0.011,
          'finalTotalPremium': 2239.1,
          'finalNetPremium': 1886.02,
          'finalRiskPremium': 1675.37,
          'finalOriginalRiskPremium': 2218.33,
          'finalTotalDiscountAmount': 24.63,
          'finalMarketDiscountAmount': 22.39,
          'finalVolumeDiscountAmount': 2.24
        },
        'userQuotationId':
            '1ba56bc9ae1746002881ce69b1125ccb319220d88fccee405f8fe45ef8013137',
        'quotationRegisterDate': '2022-10-07T20:16:58.823Z'
      };

  Map<String, dynamic> get fakePlanEmptyQuotationJson => {
        'plans': [],
        'productRates': {
          'summedOriginalRiskPremium': 2243,
          'summedRiskPremium': 1694,
          'summedNetPremium': 1907,
          'summedTotalPremium': 2264,
          'marketDiscount': 0.01,
          'volumeDiscount': 0.001,
          'finalDiscount': 0.011,
          'finalTotalPremium': 2239.1,
          'finalNetPremium': 1886.02,
          'finalRiskPremium': 1675.37,
          'finalOriginalRiskPremium': 2218.33,
          'finalTotalDiscountAmount': 24.63,
          'finalMarketDiscountAmount': 22.39,
          'finalVolumeDiscountAmount': 2.24
        },
        'userQuotationId':
            '1ba56bc9ae1746002881ce69b1125ccb319220d88fccee405f8fe45ef8013137',
        'quotationRegisterDate': '2022-10-07T20:16:58.823Z'
      };
}
