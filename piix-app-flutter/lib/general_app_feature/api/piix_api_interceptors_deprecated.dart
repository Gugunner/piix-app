import 'package:dio/dio.dart';
import 'package:piix_mobile/general_app_feature/di/service_locator.dart';
import 'package:piix_mobile/utils/endpoints.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/provider/user_bloc_deprecated.dart';

@Deprecated('Will be removed in 4.0')

///This class configures the interceptors of pix app, for a better handling of
///the requests.
///
//It sets it for before executing the requests, when the requests are
//successful or when there is an error in them.

class PiixApiInterceptorsDeprecated extends Interceptor {
  //Injects [UserBLoC] into this
  UserBLoCDeprecated get _userBLoC => getIt<UserBLoCDeprecated>();

  //This method processes the request before it is sent.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var path = options.path;
    final userId = _userBLoC.user?.userId;
    final pathWithoutParams = options.path.split('?')[0];
    final userIdParam = 'userId=$userId';
    //This variable is responsible for knowing if the path contains any path
    // need to concatenate the user id
    final hasNeedUserId = EndPoints.needUserId
        .any((endPoint) => endPoint.replaceAll('?', '') == pathWithoutParams);
    if (!hasNeedUserId || path.contains('userId')) {
      return handler.next(options);
    }
    path += (path.contains('?') ? '&' : '?') + userIdParam;
    options.path = path;
    return handler.next(options);
  }
}
