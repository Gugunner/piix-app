import 'package:flutter/material.dart';
import 'package:piix_mobile/general_app_feature/utils/firebase_asset_model.dart';

@Deprecated('Will be removed in 5.0')
class ConstantsDeprecated {
  static const double staggeredPaymentsSpacing = 15;
  static const int staggeredPaymentsFit = 1;
  static const String moneySymbol = '\$';
  static const String mxn = 'MXN';
  static const String mexicanLada = '+52';
  static const String userCredentialType = 'userCredential';
  static const String activeType = 'active';
  static const String loginType = 'loginType';
  static const String approvedId = 'approved';
  static const String pendingId = 'pending';
  static const String expiredId = 'expired';
  static const String rejectedId = 'rejected';
  static const String chargedBackId = 'charged_back';
  static const String refundedId = 'refunded';
  static const String inMediationId = 'in_mediation';
  static const String authorizedId = 'authorized';
  static const String inProcessId = 'in_process';
  static const String cancelledId = 'cancelled';
  static const String pendingControlId = 'PENDING';
  static const String activeControlId = 'ACTIVE';
  static const String inactiveControlId = 'INACTIVE';
  static const String placeHolderString = '';
  static const String oxxoId = 'oxxo';
  static const String santanderId = 'serfin';
  static const String bancomerId = 'bancomer';
  static const String banamexId = 'banamex';
  static const String payCashId = 'paycash';
  static const String clabeId = 'clabe';
  static const String textInput = 'Text';
  static const String phoneInput = 'Phone';
  static const String dateInput = 'Date';
  static const String selectorInput = 'Selector';
  static const String kinship1Selector = 'kinship1';
  static const String kinship2Selector = 'kinship2';
  static const String countrySelector = 'country';
  static const String stateSelector = 'state';
  static const String prefixSelector = 'prefix';
  static const String genderSelector = 'gender';
  static const String errorType = 'error';
  static const String successType = 'success';
  static const String labelType = 'label';
  static const String subLabelType = 'subLabel';
  static const String displayType = 'display';
  static const String stringType = 'string';
  static const String numberType = 'number';
  static const String amountType = 'amount';
  static const String signatureType = 'signedName';
  static const String dateType = 'date';
  static const String timeType = 'time';
  static const String phoneType = 'phone';
  static const String arrayType = 'main_fields_array';
  static const String singleArrayType = 'array';
  static const String sectionType = 'section';
  static const String objectType = 'object';
  static const String documentType = 'camera_documents_picture';
  static const String selfieType = 'camera_selfie_picture';
  static const String locationType = 'location';
  static const String instructionType = 'instructions';
  static const String imagePngFileType = 'image/png';
  static const String imageJpgFileType = 'image/jpg';
  static const String csvFileType = 'application/csv';
  static const String pdfFileType = 'application/pdf';
  static const String inssurance = 'Seguros';
  static const String assists = 'Asistencias';
  static const String services = 'Servicios';
  static const String rewards = 'Recompensas';
  static const String boldOk = '*Aceptar*';
  static const String networkFailed = 'network-request-failed';
  static const String selectedKey = 'selected';
  static const String statusKey = 'status';
  static const String sumInsured = 'SUM_INSURED';
  static const String events = 'EVENTS';
  static const String signedHour = 'signedHour';
  static const String signedDate = 'signedDate';
  static const String signedIp = 'signedIP';
  static const String signedUsersFormPhoto = 'signedUsersFormPhoto';
  static const String signedGeolocalization = 'signedGeolocalization';
  static const String right = 'right';
  static const String left = 'left';
  static const List<String> addressFields = [
    'city',
    'country',
    'externalNumber',
    'interiorNumber',
    'state',
    'street',
    'subThoroughfare',
    'thoroughfare',
    'zipCode'
  ];
  static const List<String> emergencyContactsFields = [
    'emergencyName1',
    'emergencyLastName1',
    'emergencyKinship1',
    'emergencyPhone1',
    'emergencyName2',
    'emergencyLastName2',
    'emergencyKinship2',
    'emergencyPhone2',
  ];
  static const List<String> BENEFIT_TYPES = [
    'Seguros',
    'Asistencias',
    'Recompensas',
    'Salud',
    'Servicios',
    'Pensiones',
    'Fianzas'
  ];
  static const String placeAndDateUrl =
      'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/forms%2Fassets%2FsignedPlaceAndDate-example.png?alt=media&token=880bba62-22b0-4944-b98b-fee89dbb8ae0';
  static const String completeNameUrl =
      'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/forms%2Fassets%2Fcomplete_name_example.png?alt=media&token=766e201e-9edb-4b35-bee2-2585ecc94f8d';
  static const internationalPhoneCodes = ['+52'];
  //TODO: Check how to stream images from firebase instead of storing them in the app
  static const List<FirebaseAssetModel> payCashPlaces = [
    FirebaseAssetModel(
        name: 'Soriana',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Fsoriana.png?alt=media&token=fc3fe374-a9c5-42a3-b387-75b38fbe3cbc'),
    FirebaseAssetModel(
        name: 'Extra',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Fextra.png?alt=media&token=615a3894-0330-4b1b-9c8a-7d8a4391d33d'),
    FirebaseAssetModel(
        name: '7-Eleven',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Fseven.png?alt=media&token=02020745-a30a-414f-9c93-910a42bf3c0b'),
    FirebaseAssetModel(
        name: 'Cicle K',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Fcircle-k.png?alt=media&token=61990f8f-2676-4792-b8bd-0616ea242dae'),
    FirebaseAssetModel(
        name: 'Calimax',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Fcalimax.png?alt=media&token=3423dbc7-326b-4fcc-ba8a-8dc705cac355'),
  ];
  static const List<FirebaseAssetModel> bancomerPlaces = [
    FirebaseAssetModel(
        name: 'Farmacia del ahorro',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Ffarmacia_ahorro.png?alt=media&token=7e72d2a6-f599-42e1-93e1-bcb62a344821'),
    FirebaseAssetModel(
        name: 'Casa Ley',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Fley.png?alt=media&token=8e40e8d1-0e49-452a-8816-30681b8bbf96'),
  ];
  static const List<FirebaseAssetModel> banamexPlaces = [
    FirebaseAssetModel(
        name: 'Chedraui',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Fchedraui.png?alt=media&token=0cb15d7f-5880-4e42-8cfc-7f98a3d95439'),
    FirebaseAssetModel(
        name: 'Telecomm',
        url:
            'https://firebasestorage.googleapis.com/v0/b/piix-dev.appspot.com/o/payment_places%2Ftelecomm.png?alt=media&token=e2cfaae0-f919-4230-8227-87395e6a6697'),
  ];
  static DateTime lowestDate = DateTime(1900);
  static List<String> ladas = ['+52'];
  static const designSize = Size(320.0, 568.0);
  static const ticketAlertTime = Duration(seconds: 8);
  static double lineStepperHeight = 32.0;

  //PADDING CONSTANTS
  static const minPadding = 8.0;
  static const mediumPadding = 16.0;
  static const largePadding = 32.0;
}
