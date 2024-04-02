import 'package:envied/envied.dart';
import 'package:piix_mobile/env/env_interface.dart';

part 'env_local.g.dart';

/// Development environment variables
@Envied(path: '.env.dev')
class LocalEnv implements Env {
  //** Firebase environment variables */
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  @override
  final String apiKey = _LocalEnv.apiKey;
  @EnviedField(varName: 'APP_ID', obfuscate: true)
  @override
  final String appId = _LocalEnv.appId;
  @EnviedField(varName: 'MESSAGE_SENDER_ID')
  @override
  final String messageSenderId = _LocalEnv.messageSenderId;
  @EnviedField(varName: 'PROJECT_ID', obfuscate: true)
  @override
  final String projectId = _LocalEnv.projectId;
  @EnviedField(varName: 'PROJECT_ID', obfuscate: true)
  @override
  final String storageBucket = _LocalEnv.storageBucket;
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  @override
  final String baseUrl = _LocalEnv.baseUrl;
}
