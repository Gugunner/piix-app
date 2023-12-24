import 'package:envied/envied.dart';

part 'dev.env.g.dart';

@Envied(path: 'dev.env')
abstract class DevEnv {
  @EnviedField(varName: 'BACKEND_ENDPOINT', obfuscate: true)
  static final backendEndpoint = _DevEnv.backendEndpoint;
  @EnviedField(varName: 'PAYMENT_ENDPOINT', obfuscate: true)
  static final paymentEndpoint = _DevEnv.paymentEndpoint;
  @EnviedField(varName: 'SIGNUP_ENDPOINT', obfuscate: true)
  static final signUpEndpoint = _DevEnv.signUpEndpoint;
  @EnviedField(varName: 'CATALOG_ENDPOINT', obfuscate: true)
  static final catalogEndpoint = _DevEnv.catalogEndpoint;
  @EnviedField(varName: 'PIIX_APP_S3', obfuscate: true)
  static final piixAppS3 = _DevEnv.piixAppS3;
}
