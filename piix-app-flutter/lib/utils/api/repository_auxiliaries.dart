
import 'package:dio/dio.dart';
import 'package:piix_mobile/api/dio/app_dio.dart';
import 'package:piix_mobile/app_config.dart';

///A simple mixin that stores two getter that are called in all
///the repositories that connect to the app api services.
///
///Gets the singleton instance of [AppConfig] which contains all
///the module endpoints needed to call the api.
///
///Gets the [Dio] instance inside the singleton [AppDio] to 
///handle any [HTTP] requests.
mixin RepositoryAuxiliaries {
    AppConfig get appConfig => AppConfig.instance;

  Dio get dio => AppDio().dio;
}