class VerificationCodeCopies {
  static const successVerification = 'Verificación exitosa';
  static String successSignUpPhoneVerification(String credential) =>
      'Ya estás registrado dentro de PIIX con el '
      'número $credential, ahora ingresa tus datos '
      'para crear tu membresía.';
  static String succesSignUpEmailVerification(String credential) =>
      'Ya estás registrado dentro de PIIX con el email '
      '$credential, a continuación ingresa tus '
      'datos para crear tu membresía.';
}
