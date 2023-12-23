import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:piix_mobile/claim_ticket_feature/data/repository/claim_ticket_repository_deprecated.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/claim_ticket_request.dart';
import 'package:piix_mobile/data/localdata/thumbs_type_list.dart';
import 'package:piix_mobile/enums/enums.dart';
import 'package:piix_mobile/utils/api/app_api_log_exception.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/general_app_feature/utils/piix_logger/piix_logger.dart';
import 'package:piix_mobile/claim_ticket_feature/domain/model/ticket_model.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/ticket_model/tickets_model.dart';

/// A class with all logics and variables for a claim modules.
class ClaimTicketProvider with ChangeNotifier {
  ///Controls if the api requests call the real api or instead read from a
  ///fake response.
  bool _appTest = false;
  bool get appTest => _appTest;
  void setAppTest(bool value) {
    _appTest = value;
  }

  ///Stores the [ClaimTicketStateDeprecated] and is used by all the
  ///methods that call an api inside [ClaimTicketProvider]
  ClaimTicketStateDeprecated _claimTicketState =
      ClaimTicketStateDeprecated.idle;
  ClaimTicketStateDeprecated get claimTicketState => _claimTicketState;
  void setClaimTicketState(ClaimTicketStateDeprecated state) {
    _claimTicketState = state;
    notifyListeners();
  }

  dynamic _benefitToClaim;
  dynamic get benefitToClaim => _benefitToClaim;
  set benefitToClaim(value) {
    _benefitToClaim = value;
    notifyListeners();
  }

  int _currentRatingScreen = 0;
  int get currentRatingScreen => _currentRatingScreen;
  set currentRatingScreen(int value) {
    _currentRatingScreen = value;
    notifyListeners();
  }

  double _benefitRatingValue = 0;
  double get benefitRatingValue => _benefitRatingValue;
  set benefitRatingValue(double value) {
    _benefitRatingValue = value;
    notifyListeners();
  }

  double _supplierRatingValue = 0;
  double get supplierRatingValue => _supplierRatingValue;
  set supplierRatingValue(double value) {
    _supplierRatingValue = value;
    notifyListeners();
  }

  ThumbsStatus _thumbsStatus = ThumbsStatus.thumbsNone;
  ThumbsStatus get thumbsStatus => _thumbsStatus;
  set thumbsStatus(ThumbsStatus value) {
    _thumbsStatus = value;
    notifyListeners();
  }

  //TODO: Check if a named constructor can be created

  TicketModel? _selectedTicket;
  TicketModel? get selectedTicket => _selectedTicket;
  set selectedTicket(TicketModel? ticket) {
    _selectedTicket = ticket;
    notifyListeners();
  }

  bool get isSOS => selectedTicket?.isSOS ?? false;

  void updateBenefitClaimTicketRating(double rating) {
    if (_selectedTicket == null) return;
    _selectedTicket = _selectedTicket?.copyWith(benefitRatingValue: rating);
    notifyListeners();
  }

  void updateSupplierClaimTicketRating(double rating) {
    if (_selectedTicket == null) return;
    _selectedTicket = _selectedTicket?.copyWith(supplierRatingValue: rating);
    notifyListeners();
  }

  void clearClaimTicketRatings() {
    if (_selectedTicket == null) return;
    _selectedTicket = _selectedTicket?.copyWith(benefitRatingValue: 0.0);
    _selectedTicket = _selectedTicket?.copyWith(supplierRatingValue: 0.0);
    notifyListeners();
  }

  bool enabledButton() {
    if (_selectedTicket == null) return false;
    if (_selectedTicket!.isSOS) {
      return _selectedTicket!.benefitRatingValue > 0;
    } else {
      return _selectedTicket!.benefitRatingValue > 0 &&
          _selectedTicket!.supplierRatingValue > 0;
    }
  }

  bool _isShowTicketAlert = false;
  bool get isShowTicketAlert => _isShowTicketAlert;
  set isShowTicketAlert(bool SOSclaim) {
    _isShowTicketAlert = SOSclaim;
    notifyListeners();
  }

  String _titleTicket = '';
  String get titleTicket => _titleTicket;
  set titleTicket(String value) {
    _titleTicket = value;
    notifyListeners();
  }

  String _subtitleTicket = '';
  String get subtitleTicket => _subtitleTicket;
  set subtitleTicket(String value) {
    _subtitleTicket = value;
    notifyListeners();
  }

  IconData _iconTicket = Icons.info;
  IconData get iconTicket => _iconTicket;
  set iconTicket(IconData value) {
    _iconTicket = value;
    notifyListeners();
  }

  Color _colorTicket = PiixColors.infoLight;
  Color get colorTicket => _colorTicket;
  set colorTicket(Color value) {
    _colorTicket = value;
    notifyListeners();
  }

  VoidCallback? _onCloseTicket = null;
  VoidCallback? get onCloseTicket => _onCloseTicket;
  set onCloseTicket(VoidCallback? value) {
    _onCloseTicket = value;
    notifyListeners();
  }

  TextEditingController commentTicketsController = TextEditingController();

  ///This is a list of buttons that thumbs up or thumbs down a ticket, that's
  /// why it's called thumbsList
  final List<Map<String, dynamic>> _thumbs = thumbsList;
  List<Map<String, dynamic>> get thumbs => _thumbs;

  ///Stores the list of [TicketModel] inside it's own property [tickets]
  final TicketsModel _tickets = TicketsModel(tickets: []);

  ///Retrieves the property of [tickets] inside [TicketsModel] private
  ///property [_tickets]
  List<TicketModel> get tickets => _tickets.tickets;

  ///Stores [tickets] a new list of [TicketModel] inside the private
  ///property [_tickets]
  set tickets(List<TicketModel> tickets) {
    _tickets.tickets = tickets;
    notifyListeners();
  }

  ///Stores the list of [TicketModel] that have a [TicketStatus]
  ///alert_system_one inside it's own property [tickets]
  final TicketsModel _showNotificationTickets = TicketsModel(tickets: []);
  List<TicketModel> get showNotificationTickets =>
      _showNotificationTickets.tickets;
  void setShowNotificationsTicket(List<TicketModel> tickets) {
    _showNotificationTickets.tickets = tickets;
    notifyListeners();
  }

  void setClaimTicketStatusLocal({
    required String ticketId,
    required TicketStatus status,
    double? supplierRating,
    double? benefitPerSupplierRating,
  }) {
    final index =
        _tickets.tickets.indexWhere((element) => element.ticketId == ticketId);
    if (index < 0) return;
    var ticket = _tickets.tickets[index].copyWith(status: status);
    if (supplierRating != null) {
      ticket = ticket.copyWith(supplierRatingValue: supplierRating);
    }
    if (benefitPerSupplierRating != null) {
      ticket = ticket.copyWith(benefitRatingValue: benefitPerSupplierRating);
    }
    _tickets.tickets[index] = ticket;
    notifyListeners();
  }

  ///Set a selected thumb element
  void setSelectedThumbs(ThumbsStatus thumbsStatus) {
    _thumbs.forEach((element) {
      if (element['status'] == thumbsStatus) {
        element['selected'] = !element['selected'];
        _thumbsStatus = thumbsStatus;
      } else {
        element['selected'] = false;
      }
      notifyListeners();
    });
  }

  ///Instantiated a service locator for [ClaimTicketRepository]
  ///
  ClaimTicketRepository get _claimTicketRepository =>
      getIt<ClaimTicketRepository>();

  ///Retrieves list of [TicketModel] by calling [_ticketRepository]
  ///getTicketHistoryRequested method.
  ///
  /// Stores the new list of [TicketModel] as a property [tickets]
  ///  inside [_tickets]
  /// and also stores a new list of [TicketModel] filtered by ticket that
  /// have the TicketStatus
  /// system_alert_one inside [_showNotificationTickets].
  /// Finally it establishes the [TicketState] retrieved if the request
  /// is successful.
  ///
  /// If the request is not successful it either sets [TicketState] in
  /// [ticketState] as retrievedError or empty.
  Future<void> getTicketHistoryByMembership({
    required String membershipId,
    bool useLoggers = true,
  }) async {
    try {
      setClaimTicketState(ClaimTicketStateDeprecated.retrieving);
      final data =
          await _claimTicketRepository.getTicketHistoryByMembershipRequested(
        membershipId: membershipId,
        test: appTest,
        useLoggers: useLoggers,
      );
      if (data is ClaimTicketStateDeprecated) {
        tickets = [];
        setClaimTicketState(data);
      } else {
        tickets = TicketsModel.fromJson(data).tickets;
        tickets.sort(
          (a, b) {
            final compare = a.compareTo(b);
            return compare;
          },
        );
        if (tickets.isEmpty) {
          setClaimTicketState(ClaimTicketStateDeprecated.empty);
          return;
        }
        final notificationTickets =
            TicketsModel.notificationTicket(tickets: tickets).tickets;
        setShowNotificationsTicket(
          notificationTickets,
        );
        setClaimTicketState(data['state']);
      }
    } catch (e) {
      if (!useLoggers) {
        setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
        return;
      }
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in getTicketHistory with membership id '
            '$membershipId',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
    }
  }

  ///Cancel a ticket by ticket id
  Future<void> cancelTicket({
    required String ticketId,
    String? cancellationReason,
    bool useLoggers = true,
  }) async {
    try {
      setClaimTicketState(ClaimTicketStateDeprecated.retrieving);
      final cancelRequest = ClaimTicketRequest.cancel(
        ticketId: ticketId,
        cancellationReason: cancellationReason,
      );
      final data = await _claimTicketRepository.cancelClaimTicketRequested(
        cancelRequest: cancelRequest,
        test: appTest,
        useLoggers: useLoggers,
      );
      if (data is ClaimTicketStateDeprecated) {
        setClaimTicketState(data);
      } else {
        setClaimTicketState(data['state']);
      }
    } catch (e) {
      if (!useLoggers) {
        setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
        return;
      }
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in cancelTicket whit ticketId ${ticketId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
    }
  }

  ///Close ticket by ticketId
  Future<void> closeTicket({
    required String ticketId,
    required double? supplierRating,
    required double? benefitPerSupplierRating,
    required String? comments,
    bool useLoggers = true,
  }) async {
    try {
      setClaimTicketState(ClaimTicketStateDeprecated.retrieving);
      final closeRequest = ClaimTicketRequest.close(
        ticketId: ticketId,
        supplierRating: supplierRating,
        benefitPerSupplierRating: benefitPerSupplierRating,
        comments: comments,
      );
      final data = await _claimTicketRepository.closeClaimTicketRequested(
        closeRequest: closeRequest,
        test: appTest,
        useLoggers: useLoggers,
      );
      if (data is ClaimTicketStateDeprecated) {
        setClaimTicketState(data);
      } else {
        setClaimTicketState(data['state']);
      }
    } catch (e) {
      if (!useLoggers) {
        setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
        return;
      }
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in close ticket whit ticketId ${ticketId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
    }
  }

  ///Report a ticket by ticketId
  Future<void> reportTicketProblem({
    required String ticketId,
    String? problemDescription,
    bool useLoggers = true,
  }) async {
    setClaimTicketState(ClaimTicketStateDeprecated.retrieving);
    try {
      final reportRequest = ClaimTicketRequest.reportProblem(
        ticketId: ticketId,
        problemDescription: problemDescription,
      );
      final data =
          await _claimTicketRepository.reportClaimTicketProblemRequested(
        reportRequest: reportRequest,
        test: appTest,
        useLoggers: useLoggers,
      );
      if (data is ClaimTicketStateDeprecated) {
        setClaimTicketState(data);
      } else {
        setClaimTicketState(data['state']);
      }
    } catch (e) {
      if (!useLoggers) {
        setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
        return;
      }
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in reportTicketProblem whit ticketId ${ticketId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
    }
  }

  //TODO: Check logic to replace != null
  Future<void> createTicket({
    required String userId,
    required String membershipId,
    required bool isSos,
    String? benefitPerSupplierId,
    String? cobenefitPerSupplierId,
    String? additionalBenefitPerSupplierId,
    bool useLoggers = true,
  }) async {
    setClaimTicketState(ClaimTicketStateDeprecated.retrieving);
    try {
      final createRequest = ClaimTicketRequest.create(
          userId: userId,
          membershipId: membershipId,
          isSOS: isSos,
          benefitPerSupplierId: benefitPerSupplierId,
          cobenefitPerSupplierId: cobenefitPerSupplierId,
          additionalBenefitPerSupplierId: additionalBenefitPerSupplierId);
      final data = await _claimTicketRepository.createClaimTicketRequested(
        createRequest: createRequest,
        test: appTest,
        useLoggers: useLoggers,
      );
      if (data is ClaimTicketStateDeprecated) {
        setClaimTicketState(data);
      } else {
        selectedTicket = data['ticket'];
        setClaimTicketState(data['state']);
      }
    } catch (e) {
      if (!useLoggers) {
        setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
        return;
      }
      final loggerInstance = PiixLogger.instance;
      final logMessage = loggerInstance.errorMessage(
        messageName: 'Error in createTicket whit membershipId ${membershipId}'
            'and benefit id '
            '${additionalBenefitPerSupplierId ?? cobenefitPerSupplierId ?? benefitPerSupplierId}',
        message: e.toString(),
        isLoggable: isApiException(e),
      );
      loggerInstance.log(
        logMessage: logMessage.toString(),
        error: e,
        level: Level.error,
        sendToCrashlytics: true,
      );
      setClaimTicketState(ClaimTicketStateDeprecated.retrieveError);
    }
  }

  /// Set to false all flags
  void clearProvider() {
    _selectedTicket = null;
    _isShowTicketAlert = false;
    _titleTicket = '';
    _subtitleTicket = '';
    _iconTicket = Icons.info;
    _colorTicket = PiixColors.infoLight;
    _onCloseTicket = null;
    notifyListeners();
  }
}
