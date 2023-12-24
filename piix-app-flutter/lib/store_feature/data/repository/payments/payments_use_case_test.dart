import 'package:piix_mobile/store_feature/data/repository/payments/payments_repository_deprecated.dart';

///Is a use case test extension of [PaymentsRepositoryDeprecated]
///Contains all api mock calls
///
extension PaymentsUseCaseTest on PaymentsRepositoryDeprecated {
  ///Get all payments methods
  ///
  Future<dynamic> getPaymentsMethodsTest(
      {required PaymentResponseTypesDeprecated type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case PaymentResponseTypesDeprecated.empty:
          return [];
        case PaymentResponseTypesDeprecated.success:
          return fakePaymentsJson;
        case PaymentResponseTypesDeprecated.error:
          return PaymentStateDeprecated.error;
        case PaymentResponseTypesDeprecated.unexpectedError:
        default:
          return PaymentStateDeprecated.unexpectedError;
      }
    });
  }

  ///Make user payment test
  ///
  Future<dynamic> makeUserPaymentTest(
      {required PaymentResponseTypesDeprecated type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case PaymentResponseTypesDeprecated.success:
          return fakePaymentsJson;
        case PaymentResponseTypesDeprecated.badRequest:
          return PaymentStateDeprecated.badRequest;
        case PaymentResponseTypesDeprecated.conflict:
          return PaymentStateDeprecated.conflict;
        case PaymentResponseTypesDeprecated.error:
          return PaymentStateDeprecated.error;
        case PaymentResponseTypesDeprecated.unexpectedError:
        default:
          return PaymentStateDeprecated.unexpectedError;
      }
    });
  }

  ///Make user payment test
  ///
  Future<dynamic> cancelUserPaymentTest(
      {required PaymentResponseTypesDeprecated type}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      switch (type) {
        case PaymentResponseTypesDeprecated.success:
          return cancelUserPayment;
        case PaymentResponseTypesDeprecated.badRequest:
          return PaymentStateDeprecated.badRequest;
        case PaymentResponseTypesDeprecated.conflict:
          return PaymentStateDeprecated.conflict;
        case PaymentResponseTypesDeprecated.error:
          return PaymentStateDeprecated.error;
        case PaymentResponseTypesDeprecated.notFound:
          return PaymentStateDeprecated.notFound;
        case PaymentResponseTypesDeprecated.unexpectedError:
        default:
          return PaymentStateDeprecated.unexpectedError;
      }
    });
  }

  List<Map<String, dynamic>> get fakePaymentsJson => [
        {
          'id': 'banamex',
          'name': 'Citibanamex',
          'paymentTypeId': 'atm',
          'secureThumbnail':
              'https://http2.mlstatic.com/storage/logos-api-admin/2fc79310-9a37'
                  '-11ec-aad4-c3381f368aaf-m@2x.png',
          'thumbnail':
              'https://http2.mlstatic.com/storage/logos-api-admin/2fc79310-9a37'
                  '-11ec-aad4-c3381f368aaf-m@2x.png',
          'settings': [],
          'additionalInfoNeeded': [],
          'minAllowedAmount': 5,
          'maxAllowedAmount': 40000,
          'accreditationTime': 60
        },
        {
          'id': 'serfin',
          'name': 'Santander',
          'paymentTypeId': 'atm',
          'secureThumbnail':
              'https://http2.mlstatic.com/storage/logos-api-admin/6756e0f0-24f0'
                  '-11eb-8a85-870f2cce05b3-xl@2x.png',
          'thumbnail':
              'https://http2.mlstatic.com/storage/logos-api-admin/6756e0f0-24f0'
                  '-11eb-8a85-870f2cce05b3-xl@2x.png',
          'settings': [],
          'additionalInfoNeeded': [],
          'minAllowedAmount': 5,
          'maxAllowedAmount': 40000,
          'accreditationTime': 60
        },
        {
          'id': 'bancomer',
          'name': 'BBVA Bancomer',
          'paymentTypeId': 'atm',
          'secureThumbnail':
              'https://http2.mlstatic.com/storage/logos-api-admin/65467f50-5cf3'
                  '-11ec-813c-8542a9aff8ea-xl@2x.png',
          'thumbnail':
              'https://http2.mlstatic.com/storage/logos-api-admin/65467f50-5cf3'
                  '-11ec-813c-8542a9aff8ea-xl@2x.png',
          'settings': [],
          'additionalInfoNeeded': [],
          'minAllowedAmount': 10,
          'maxAllowedAmount': 40000,
          'accreditationTime': 60
        },
        {
          'id': 'mercadopagocard',
          'name': 'Tarjeta MercadoPago',
          'paymentTypeId': 'prepaid_card',
          'secureThumbnail':
              'https://www.mercadopago.com/org-img/MP3/API/logos/mercadopagocard.gif',
          'thumbnail':
              'http://img.mlstatic.com/org-img/MP3/API/logos/mercadopagocard.gif',
          'settings': [
            {
              'card_number': {'validation': 'standard', 'length': 16},
              'bin': {'installmentsPattern': '', 'exclusionPattern': null},
              'security_code': {
                'length': 3,
                'cardLocation': 'back',
                'mode': 'mandatory'
              }
            }
          ],
          'additionalInfoNeeded': ['cardholder_name'],
          'minAllowedAmount': 5,
          'maxAllowedAmount': 300000,
          'accreditationTime': 0
        },
        {
          'id': 'oxxo',
          'name': 'OXXO',
          'paymentTypeId': 'ticket',
          'secureThumbnail':
              'https://http2.mlstatic.com/storage/logos-api-admin/87075440-571e'
                  '-11e8-823a-758d95db88db-xl@2x.png',
          'thumbnail':
              'https://http2.mlstatic.com/storage/logos-api-admin/87075440-571e'
                  '-11e8-823a-758d95db88db-xl@2x.png',
          'settings': [],
          'additionalInfoNeeded': [],
          'minAllowedAmount': 5,
          'maxAllowedAmount': 10000,
          'accreditationTime': 2880
        }
      ];

  Map<String, dynamic> get userPayment => {
        'purchaseInvoiceId': '180f430b70b2c4ad85f058a6-1309227666',
        'userId': '180f430b70b2c4ad85f058a6',
        'packageId': 'CNOC-2022-01',
        'paymentId': '1309227666',
        'paymentMethodId': 'oxxo',
        'barcode': '78000000600326813706112203381923',
        'barcodeType': 'Code128C',
        'paymentMethodReferenceId': '6003268137',
        'paymentStatus': 'pending',
        'controlStatus': 'PENDING',
        'expirationDate': '2022-11-06T18:10:18.712-04:00',
        'registerDate': '2022-11-01T22:10:18.900Z',
        'updateDate': '2022-11-01T22:10:18.900Z',
        'userQuotation': {
          'userQuotationId':
              '90bc4465bdd1dde36a742013e872e0e04446a48509146e156705359d9276ce4e',
          'userId': '180f430b70b2c4ad85f058a6',
          'packageId': 'CNOC-2022-01',
          'membershipLevelId': 'level1',
          'productType': 'LEVEL',
          'totalPremium': 3381.92,
          'totalNetPremium': 3005.5,
          'totalRiskPremium': 2816.79,
          'totalOriginalRiskPremium': 3228.78,
          'marketDiscountAmount': 33.82,
          'volumeDiscountAmount': 6.76,
          'totalDiscountAmount': 40.58,
          'levelId': 'level4',
          'quotationStatus': 'PURCHASED',
          'registerDate': '2022-11-01T22:09:46.000Z',
          'updateDate': '2022-11-01T22:10:18.940Z'
        }
      };

  Map<String, dynamic> get cancelUserPayment => {
        'purchaseInvoiceId': '180f430b70b2c4ad85f058a6-1310036504',
        'userId': '180f430b70b2c4ad85f058a6',
        'packageId': 'CNOC-2022-01',
        'userQuotationId':
            'a3a3fef03ae0b25ad3966bf79162a8500b5b53a55b0bd3e9ce73d922d3ba6980',
        'paymentId': '1310036504',
        'paymentMethodId': 'oxxo',
        'barcode': '78000000600327322708112204417352',
        'barcodeType': 'Code128C',
        'paymentMethodReferenceId': '6003273227',
        'paymentStatus': 'cancelled',
        'controlStatus': 'PENDING',
        'expirationDate': '2022-11-09T05:07:34.000Z',
        'registerDate': '2022-11-04T05:07:34.000Z',
        'updateDate': '2022-11-04T05:07:34.000Z'
      };
}
