import 'package:envied/envied.dart';

part 'test.env.g.dart';

@Envied(path: 'test.env')
abstract class TestEnv {
  @EnviedField(varName: 'BACKEND_ENDPOINT', obfuscate: true)
  static final backendEndpoint = _TestEnv.backendEndpoint;
  @EnviedField(varName: 'PAYMENT_ENDPOINT', obfuscate: true)
  static final paymentEndpoint = _TestEnv.paymentEndpoint;
  @EnviedField(varName: 'SIGNUP_ENDPOINT', obfuscate: true)
  static final signUpEndpoint = _TestEnv.signUpEndpoint;
  @EnviedField(varName: 'CATALOG_ENDPOINT', obfuscate: true)
  static final catalogEndpoint = _TestEnv.catalogEndpoint;
  @EnviedField(varName: 'PIIX_APP_S3', obfuscate: true)
  static final piixAppS3 = _TestEnv.piixAppS3;
}
