import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_use_case_test.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/claim_ticket_request.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/providers/claim_ticket_provider.dart';
import 'package:piix_mobile/general_app_feature/api/piix_api_deprecated.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../general_app_feature/api/mock_dio.mocks.dart';
import '../../../general_app_feature/api/test_endpoints.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  setupGetIt();
  setEndpoints();
  final mockDio = MockDio();
  PiixApiDeprecated.setDio(mockDio);
  final claimTicketProvider = getIt<ClaimTicketProvider>();
  const membershipId = '21e1f38b93f9c2c10adc58b9c2';
  const userId = '180f430b70b2c4ad85f058a6';
  final fakeTickets = getIt<ClaimTicketRepository>().fakeJsonTickets;
  final fakeTicketResponse = getIt<ClaimTicketRepository>().fakeTicketResponse;
  fakeTickets.sort(((a, b) => b['registerDate'].compareTo(a['registerDate'])));
  var path = '';
  var request = ClaimTicketRequest();

  group('get ticket history', () {
    setUpAll(() {
      path = '${EndPoints.getTicketHistory}membershipId=${membershipId}';
    });

    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
      claimTicketProvider.tickets = [];
    });

    test(
        'when the service http code response is 200 and the response includes '
        'data for a valid TicketsModel, the TicketState is retrieved',
        () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);

      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: fakeTickets,
          ));
      await claimTicketProvider.getTicketHistoryByMembership(
          membershipId: membershipId);
      expect(claimTicketProvider.tickets.isNotEmpty, true);
      expect(claimTicketProvider.tickets.first.ticketId,
          fakeTickets.first['ticketId']);
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.retrieved);
    });

    test(
        'when the service http code response is 200 and the response includes '
        'data for a valid TicketsModel even if is empty, the TicketState is '
        'empty', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);

      when(mockDio.get(path)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: path),
            statusCode: HttpStatus.ok,
            data: [],
          ));
      await claimTicketProvider.getTicketHistoryByMembership(
          membershipId: membershipId);
      expect(claimTicketProvider.tickets.isEmpty, true);
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.empty);
    });
  });

  group('get ticket history exceptions', () {
    setUpAll(() {
      path = '${EndPoints.getTicketHistory}membershipId=${membershipId}';
    });

    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
      claimTicketProvider.tickets = [];
    });

    test('when the service http code response is 409, the TicketState is empty',
        () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);

      when(mockDio.get(path)).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.conflict,
              data: <String, dynamic>{
                'errorName': 'Piix Error Conflict',
                'errorMessage': 'The tickets id were not in sync',
                'errorMessages': '[]'
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.getTicketHistoryByMembership(
        membershipId: membershipId,
        useLoggers: false,
      );
      expect(claimTicketProvider.tickets.isNotEmpty, false);
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.empty);
    });

    test(
        'when the service http code response is 200 and the response does not '
        'include data for a valid TicketsModel, the TicketState is '
        'retrievedError', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);
      when(mockDio.get(path)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: path),
          statusCode: HttpStatus.ok,
          data: null));
      await claimTicketProvider.getTicketHistoryByMembership(
        membershipId: membershipId,
        useLoggers: false,
      );
      expect(claimTicketProvider.tickets.isNotEmpty, false);
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.retrieveError);
    });

    test(
        'when the app throws a DioErrorType connect timeout or other, the '
        'TicketState is retrievedError', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);
      when(mockDio.get(path)).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          type: DioErrorType.connectionTimeout));
      await claimTicketProvider.getTicketHistoryByMembership(
        membershipId: membershipId,
        useLoggers: false,
      );
      expect(claimTicketProvider.tickets.isNotEmpty, false);
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.retrieveError);
    });
  });

  group('create  claim ticket', () {
    setUpAll(() {
      path = EndPoints.createClaimTicket;
      request = ClaimTicketRequest(
        userId: '180f430b70b2c4ad85f058a6',
        membershipId: '21e1f38b93f9c2c10adc58b9c2',
        isSOS: true,
        benefitPerSupplierId: null,
        cobenefitPerSupplierId: null,
        additionalBenefitPerSupplierId: null,
      );
    });
    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    });

    test(
        'when the service http code response is 201 and the response includes '
        'data, the ClaimTicketState is created', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.post(path, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.created,
                data: fakeTicketResponse,
              ));
      await claimTicketProvider.createTicket(
        userId: userId,
        membershipId: membershipId,
        isSos: true,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.created);
    });

    test(
        'when the service http code response is 201 and the response do not'
        'includes data the ClaimTicketState is error', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.post(path, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.created,
                data: null,
              ));
      await claimTicketProvider.createTicket(
        userId: userId,
        membershipId: membershipId,
        isSos: true,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.error);
    });
  });

  group('create claim ticket exceptions', () {
    setUpAll(() {
      path = EndPoints.createClaimTicket;
      request = ClaimTicketRequest(
        userId: '180f430b70b2c4ad85f058a6',
        membershipId: '21e1f38b93f9c2c10adc58b9c2',
        isSOS: true,
        benefitPerSupplierId: null,
        cobenefitPerSupplierId: null,
        additionalBenefitPerSupplierId: null,
      );
    });

    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    });

    test(
        'when the service http code response is 400, the TicketState is '
        'conflict', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.post(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.badRequest,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error creating the ticket: At least one of '
                        'the parameters is invalid.',
                'errorName': 'Piix Error Ticket Params.',
                'errorMessages': [
                  'User does not exists.',
                  'Membership does not exists or the given membership is not '
                      'valid for the user.'
                ],
                'errorCodes': [],
                'detailedErrorCodes': []
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.createTicket(
        userId: userId,
        membershipId: membershipId,
        isSos: true,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.conflict);
    });

    test(
        'when the service http code response is 404, the TicketState is '
        'not found', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.post(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.notFound,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error creating the ticket: Membership with '
                        'id: CNOC-2022-01-24-00PP was not found.',
                'errorName': 'Piix Error Resource not found',
                'errorMessages': [],
                'errorCodes': [],
                'detailedErrorCodes': []
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.createTicket(
        userId: userId,
        membershipId: membershipId,
        isSos: true,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.notFound);
    });

    test(
        'when the app throws a DioErrorType connect timeout or other, the '
        'TicketState is retrievedError', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);
      when(mockDio.post(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          type: DioErrorType.connectionTimeout));
      await claimTicketProvider.createTicket(
        userId: userId,
        membershipId: membershipId,
        isSos: true,
        useLoggers: false,
      );
      expect(claimTicketProvider.tickets.isNotEmpty, false);
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.retrieveError);
    });
  });

  group('cancelled claim ticket', () {
    setUpAll(() {
      path = EndPoints.cancelClaimTicket;
      request = ClaimTicketRequest.cancel(
          ticketId: 'piix_20230111_0006_34604',
          cancellationReason: 'Por falta de uso');
    });
    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    });

    test(
        'when the service http code response is 200 and the response includes '
        'data, the ClaimTicketState is cancelled', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: fakeTicketResponse,
              ));
      await claimTicketProvider.cancelTicket(
        ticketId: request.ticketId!,
        cancellationReason: request.cancellationReason,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.cancelled);
    });

    test(
        'when the service http code response is 200 and the response do not'
        'includes data the ClaimTicketState is error', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: null,
              ));
      await claimTicketProvider.cancelTicket(
        ticketId: request.ticketId!,
        cancellationReason: request.cancellationReason,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.error);
    });
  });

  group('cancel claim ticket exceptions', () {
    setUpAll(() {
      path = EndPoints.cancelClaimTicket;
      request = ClaimTicketRequest.cancel(
          ticketId: 'piix_20230111_0006_34604',
          cancellationReason: 'Por falta de uso');
    });
    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    });

    test(
        'when the service http code response is 409, the TicketState is '
        'conflict', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.conflict,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error updating the ticket: This ticket has '
                        'an invalid status for this operation.',
                'errorName': 'Piix Error Ticket Status.',
                'errorMessages': [],
                'errorCodes': [],
                'detailedErrorCodes': []
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.cancelTicket(
        ticketId: request.ticketId!,
        cancellationReason: request.cancellationReason,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.conflict);
    });

    test(
        'when the service http code response is 404, the TicketState is '
        'not found', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.notFound,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error updating the ticket: Membership with '
                        'id: CNOC-2022-01-24-00PP was not found.',
                'errorName': 'Piix Error Resource not found',
                'errorMessages': [],
                'errorCodes': [],
                'detailedErrorCodes': []
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.cancelTicket(
        ticketId: request.ticketId!,
        cancellationReason: request.cancellationReason,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.notFound);
    });

    test(
        'when the app throws a DioErrorType connect timeout or other, the '
        'TicketState is retrievedError', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);
      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          type: DioErrorType.connectionTimeout));
      await claimTicketProvider.cancelTicket(
        ticketId: request.ticketId!,
        cancellationReason: request.cancellationReason,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.retrieveError);
    });
  });

  group('closed claim ticket', () {
    setUpAll(() {
      path = EndPoints.closeClaimTicket;
      request = ClaimTicketRequest.close(
          ticketId: 'piix_20230111_0006_34604',
          supplierRating: 4.0,
          benefitPerSupplierRating: 3.0,
          comments: 'Se requiere cerrar el ticket');
    });
    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    });

    test(
        'when the service http code response is 200 and the response includes '
        'data, the ClaimTicketState is closed', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: fakeTicketResponse,
              ));
      await claimTicketProvider.closeTicket(
        ticketId: request.ticketId!,
        supplierRating: request.supplierRating!,
        benefitPerSupplierRating: request.benefitPerSupplierRating,
        comments: request.comments,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.closed);
    });

    test(
        'when the service http code response is 200 and the response do not'
        'includes data the ClaimTicketState is error', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: null,
              ));
      await claimTicketProvider.closeTicket(
        ticketId: request.ticketId!,
        supplierRating: request.supplierRating!,
        benefitPerSupplierRating: request.benefitPerSupplierRating,
        comments: request.comments,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.error);
    });
  });

  group('closed claim ticket exceptions', () {
    setUpAll(() {
      path = EndPoints.closeClaimTicket;
      request = ClaimTicketRequest.close(
          ticketId: 'piix_20230111_0006_34604',
          supplierRating: 4.0,
          benefitPerSupplierRating: 3.0,
          comments: 'Se requiere cerrar el ticket');
    });
    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    });

    test(
        'when the service http code response is 409, the TicketState is '
        'conflict', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.conflict,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error updating the ticket: This ticket has '
                        'an invalid status for this operation.',
                'errorName': 'Piix Error Ticket Status.',
                'errorMessages': [],
                'errorCodes': [],
                'detailedErrorCodes': []
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.closeTicket(
        ticketId: request.ticketId!,
        supplierRating: request.supplierRating!,
        benefitPerSupplierRating: request.benefitPerSupplierRating,
        comments: request.comments,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.conflict);
    });

    test(
        'when the service http code response is 404, the TicketState is '
        'not found', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.notFound,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error updating  the ticket: Membership with '
                        'id: CNOC-2022-01-24-00PP was not found.',
                'errorName': 'Piix Error Resource not found',
                'errorMessages': [],
                'errorCodes': [],
                'detailedErrorCodes': []
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.closeTicket(
        ticketId: request.ticketId!,
        supplierRating: request.supplierRating!,
        benefitPerSupplierRating: request.benefitPerSupplierRating,
        comments: request.comments,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.notFound);
    });

    test(
        'when the app throws a DioErrorType connect timeout or other, the '
        'TicketState is retrievedError', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);
      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          type: DioErrorType.connectionTimeout));
      await claimTicketProvider.closeTicket(
        ticketId: request.ticketId!,
        supplierRating: request.supplierRating!,
        benefitPerSupplierRating: request.benefitPerSupplierRating,
        comments: request.comments,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.retrieveError);
    });
  });

  group('report claim ticket problem', () {
    setUpAll(() {
      path = EndPoints.reportClaimTicketProblem;
      request = ClaimTicketRequest.reportProblem(
          ticketId: 'piix_20230111_0006_34604',
          problemDescription: 'No he podido redimir mi beneficio');
    });
    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    });

    test(
        'when the service http code response is 200 and the response includes '
        'data, the ClaimTicketState is reported', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: fakeTicketResponse,
              ));
      await claimTicketProvider.reportTicketProblem(
        ticketId: request.ticketId!,
        problemDescription: request.problemDescription,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.reported);
    });

    test(
        'when the service http code response is 200 and the response do not'
        'includes data the ClaimTicketState is error', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson()))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: HttpStatus.ok,
                data: null,
              ));
      await claimTicketProvider.reportTicketProblem(
        ticketId: request.ticketId!,
        problemDescription: request.problemDescription,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.error);
    });
  });

  group('report claim ticket problem exceptions', () {
    setUpAll(() {
      path = EndPoints.reportClaimTicketProblem;
      request = ClaimTicketRequest.reportProblem(
          ticketId: 'piix_20230111_0006_34604',
          problemDescription: 'No he podido redimir mi beneficio');
    });
    setUp(() {
      claimTicketProvider.setClaimTicketState(ClaimTicketStateDeprecated.idle);
    });

    test(
        'when the service http code response is 409, the TicketState is '
        'conflict', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.conflict,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error updating the ticket: This ticket'
                        ' has an invalid status for this operation.',
                'errorName': 'Piix Error Ticket Status.',
                'errorMessages': [],
                'errorCodes': [],
                'detailedErrorCodes': []
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.reportTicketProblem(
        ticketId: request.ticketId!,
        problemDescription: request.problemDescription,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.conflict);
    });

    test(
        'when the service http code response is 404, the TicketState is '
        'not found', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);

      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: HttpStatus.notFound,
              data: <String, dynamic>{
                'errorMessage':
                    'There was an error updating  the ticket: Ticket with '
                        'id: idDelTicket was not found.',
                'errorName': 'Piix Error Resource not found',
                'errorMessages': [],
                'errorCodes': [],
                'detailedErrorCodes': []
              }),
          type: DioErrorType.badResponse));
      await claimTicketProvider.reportTicketProblem(
        ticketId: request.ticketId!,
        problemDescription: request.problemDescription,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.notFound);
    });

    test(
        'when the app throws a DioErrorType connect timeout or other, the '
        'TicketState is retrievedError', () async {
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.idle);
      expect(claimTicketProvider.tickets.isEmpty, true);
      when(mockDio.put(path, data: request.toJson())).thenThrow(DioError(
          requestOptions: RequestOptions(path: path),
          type: DioErrorType.connectionTimeout));
      await claimTicketProvider.reportTicketProblem(
        ticketId: request.ticketId!,
        problemDescription: request.problemDescription,
        useLoggers: false,
      );
      expect(claimTicketProvider.claimTicketState,
          ClaimTicketStateDeprecated.retrieveError);
    });
  });
}
