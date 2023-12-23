class AuthUserCopies {
  //--------InputState copies---------
  ///Email copies
  static const emptyEmail = 'El correo electrónico no puede estar vacio.';
  static const invalidEmail = 'El correo electrónico no es valido.';
  static const alreadyUsedEmail = 'El correo electrónico ya esta en uso.';
  static const unregisteredEmail = 'El correo electrónico no esta registrado.';
  //--------Email helper copies-------
  static const enterEmail = 'Ingresa el correo electrónico.';
  //--------Email label copies-------
  static const email = 'Correo electrónico *';

  ///Phone number copies
  static const emptyPhone = 'El teléfono no puede estar vacio.';
  static const invalidPhone = 'El teléfono no es valido.';
  static const alreadyUsedPhone = 'El teléfono ya esta en uso.';
  static const unregisteredPhone = 'El teléfono no esta registrado.';
  //--------Phone helper copies-------
  static const enterPhone = 'Ingresa el teléfono.';
  //--------Phone label copies--------
  static const phone = 'Teléfono*';
  static const lada = 'Lada*';
  //--------SignInOrSignUp copies------
  ///Sign up copies
  static const signUpPhoneTitle = 'Ingresa tu teléfono para registrarte';
  static const signUpEmailTitle = 'Ingresa tu correo para registrarte';
  static const phoneConfirmation =
      'Lo confirmaremos  con código a tu teléfono que enviaremos '
      'en un mensaje SMS.';
  static const emailConfirmation =
      'Lo confirmaremos enviando un email  con el código a tu '
      'bandeja de entrada.';
  static const phoneDisclaimer =
      'Al enviar confirmas que eres el dueño del número que ingresaste.';
  static const emailDisclaimer =
      'Al enviar confirmas que eres el dueño del email que ingresaste.';
  static const signUpByPhone = 'Registrarme por teléfono';
  static const signUpByEmail = 'Registrarme por email';
  static const piixSignIn = 'Iniciar sesión con mi cuenta';
  static const wantToSignUp = 'QUIERO REGISTRARME';

  ///Sign in copies
  static const signInPhoneTitle = 'Ingresa tu teléfono e inicia sesión';
  static const signInEmailTitle = 'Ingresa tu correo e inicia sesión';
  static const signInByPhone = 'Iniciar sesión con mi teléfono';
  static const signInByEmail = 'Iniciar sesión con mi correo';
  static const piixSignUp = 'Registrarme en PIIX';
  static const signInWithAccount = 'INICIAR SESIÓN CON MI CUENTA';

  ///General copies
  static const send = 'ENVIAR';
  static const testText = 'Texto de prueba';
  static const generalError =
      'Ocurrio un error inesperado, vuelve a intentarlo.';
  //--------Verification Code copies--------
  ///Verification Screen
  static String sentByPhone(String credential) =>
      'Envíamos un mensaje SMS con el código al número '
      '$credential.';
  static String sentByEmail(String credential) =>
      'Envíamos un email con el código al correo $credential, '
      'si no lo encuentras revisa en tu bandeja de correo no deseado o spam.';
  static const enterSentCode = 'Ingresa el código que te enviamos';
  static const codeInputLabel = 'Código de verificación*';
  static const requestNewCode = 'Solicitar otro código';
  static const timerTextSpans = ['En ', 'min, podrás'];
  static const incorrectCode = 'Código incorrecto';

  ///Verification Banner
  static const codeSentAgainByPhone = 'Envíamos el código a tu teléfono';
  static const codeSentAgainByEmail = 'Envíamos el código a tu correo';
  static const codeCouldNotBeSent =
      'Lo sentimos no se pudo enviar el código, vuelve a intentarlo.';
  //--------Documentation form copies--------
  ///Documentation
  static const uniqueIdDuplicated =
      'El número de identificación ya fue registrado para esta comunidad.';
  static const documentNotFound = 'Algunas de las imagenes no se '
      'encontraron, por favor vuelve a subirlas.';

  ///Waiting verification screen
  static const seeTheTutorialAgain = 'Volver a ver el tutorial';
  static const seeTheTutorial = 'Ver el tutorial';
  static const checkingYourData = 'Estamos revisando tus datos';
  static const verificationInstruction =
      'El equipo PIIX está revisando tus datos, te enviaremos un correo dentro '
      'de los próximos días confirmando la creación de tu membresía.';
  static const iUnderstand = 'Entiendo';
  //Startup slogan
  static const startupSlogan = 'Protege a los que más quieres';
}
