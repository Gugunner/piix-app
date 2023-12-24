import 'package:piix_mobile/auth_feature/domain/model/user_app_model.dart';
import 'package:piix_mobile/general_app_feature/utils/extension/int_extention.dart';
import 'package:piix_mobile/membership_user_feature_deprecated/domain/model/membership_model/membership_model_deprecated.dart';

@Deprecated('Will be removed in 4.0')
class PiixCopiesDeprecated {
  ///Membership Drawer
  static const disclaimerMessage = 'Revisa nuestro Aviso de privacidad y '
      'Términos y condiciones PIIX en '
      'www.piixapp.com';

  ///Simple words
  static const hello = 'Hola';
  static const view = 'Ver';

  ///Button copies
  static const loadingButton = 'Cargando...';
  static const closeSession = 'Cerrar sesión';
  static const retry = 'Reintentar';
  static const couldRetry = 'Podrias reintentar de nuevo.';
  static const errorNumber = 'Favor de introducir un número válido';
  static const emailHint = 'Correo electrónico*';
  static const passwordHint = 'Contraseña *';
  static const errorWhatsapp = 'Lo sentimos Whatsapp no pudo ser abierto.';
  static const errorCall = 'Lo sentimos el teléfono no pudo ser abierto.';
  static const invalidNumber = 'Ingresa un número valido';
  static const invalidPercentage =
      'Ingresa un valor porcentual entre 0% y 100%';
  static const emailInstructions =
      'Ingrese el correo electrónico o el Id de usuario';
  static const passwordInstructions =
      'La contraseña debe contener al menos una mayúscula, una minúscula, un '
      'número y un carácter especial, con un mínimo de 8 y máximo de 16 '
      'caracteres.';
  static const wrongCredentials =
      'El teléfono/correo electrónico y/o la contraseña son incorrectos';
  static const wrongUserCredential =
      'El correo electrónico/teléfono no pudo ser reconocido';
  static const errorLogin = 'El correo electrónico / Id de usuario o '
      'contraseña ingresada son incorrectos. Verifica los datos e '
      'intenta nuevamente.';
  static const sorryPleaseTryAgain =
      'Lo sentimos hubo un error al enviar la información, '
      'por favor vuelve a intentarlo.';
  static const loginButton = 'Iniciar Sesión';
  static const membershipTitle = 'Mis membresías';
  static const welcomeText = 'Bienvenido(a)';
  static const noAssociatedMemberships =
      'No encontramos membresías asociadas a tu cuenta';
  static const notFoundMembership = 'No se ha encontrado la membresía';
  static const yourRequestsContinuesMonitored =
      'Tus solicitudes siguen siendo monitoreadas.';
  static const rememberYourRequest =
      'No olvides revisar la guía de solicitud del beneficio que estas '
      'solicitando.';
  static const membershipInstructions =
      'Selecciona la membresía que quieres consultar';
  static const requiredFieldsInstruction =
      'Los campos marcados con * son obligatorios.';
  static const noMembershipsText = 'Sin membresías';
  static const userInProcessOfVerification = 'Lo sentimos,\n este usuario no '
      'cuenta con membresias, '
      'o sigue en proceso de verificar su información.';
  static const notLoadedMembership = 'No se cargo la membresia';
  static const piix = 'PIIX';
  static const membershipWord = 'Membresía';
  //Product Status
  static const activeProduct = 'Activo';
  static const inactiveProduct = 'Inactivo';
  static const pendingProduct = 'Pendiente';
  static const pendingActivation = 'Por activar';
  static const canceledProduct = 'Cancelado';
  static const activatingProduct = 'Activando';
  static const noProduct = 'En espera';
  //
  static const protectedText = 'Protegidos';
  static const addProtecteds = 'Agrega nuevos protegidos >>';
  static const singularProtectedText = 'Protegido';
  static const additionsText = 'Adiciones';
  static const profileText = 'Perfil';
  static const partnerText = 'Socio';
  static const protectedPartners = 'Socios Protegidos';
  static const actuallyHave = 'Actualmente tienes';
  static const actuallyDontHave = 'Actualmente no tienes';
  static const protectedInMembership = 'protegidos con PIIX en tu Membresía';

  static const partnerHyphen = 'Socio - ';
  static const titular = '- Titular';
  static const id = 'Id:';
  static const validityFrom = 'Vigente desde:';
  static const fromValidity = 'Vigencia desde:';
  static const validityTo = 'Hasta:';
  static const protectedNumber = 'Número de protegido:';
  static const relationship = 'Parentesco';
  static const birthDate = 'Fecha de nacimiento';
  static String ageInYears(String age) => 'Edad: $age años';
  static const upDate = 'Fecha de alta:';
  static const ownerInformation = 'Información personal';
  static const generalInformation = 'Generales';
  static const emergencyContact = 'Contacto de emergencia';
  static const hideButton = 'OCULTAR';
  static const viewText = 'VER';
  static const logoutMessage = '¿Está seguro que quiere cerrar sesión?';
  static const logout = 'Cerrar Sesión';
  static const oneMoment = '¡Un momento!';
  static const cancelButton = 'Cancelar';
  static const okButton = 'Aceptar';
  static const Curp = 'CURP';
  static const address = 'Dirección';
  static const levelColon = 'Nivel:';
  static const status = 'Estatus';

  static const plans = 'Planes';
  static const membershipCoverage = 'Cobertura de membresía';
  static const pdfButton = 'VER PDF';
  static const policy = 'Póliza';
  static const supplier = 'Proveedor';
  static const coverage = 'Cobertura:';
  static const detailButton = 'VER DETALLE';
  static const coBenefits = 'Cobeneficios';
  static const loadingCobenefits = 'Cargando cobeneficios...';
  static const notCoBenefits = 'No tiene Cobeneficios';
  static const whatCoverage = '¿Qué te cubre?';
  static const exclusions = 'Exclusiones';
  static const compensationProcedure = 'Procedimiento de indemnización';
  static const coBenefitExtra =
      '*Consulta con tu proveedor de servicios \ncuántos te quedan';
  static const PdfTitle = 'PDF';
  static const call = 'Llamada';
  static const whatsapp = 'Whatsapp';
  static const membresias = 'Membresías';
  static const contactFlash = 'Contacto rápido';
  static const firstPageMembership =
      'Consulta la información de tu membresía y '
      'descarga el PDF para revisar el detalle de tus coberturas.';
  static const secondPageMembership =
      'Rápidamente reporta siniestros o solicita nuevos servicios, seguros, '
      'asistencias o beneficios por llamada directa o mensaje.';
  static const protectedPage =
      'Consulta la información de los protegidos dentro de tu membresía.';
  static const additionalOwner = 'Protegidos Adicionales';
  static const compInfo = ', completa la información para apoyarte con rapidez'
      ' en el momento que sufras un siniestro.';
  static const hi = 'Hola';
  static const titleComplementaryForm = 'Datos complementarios de usuario';
  static const titleEmergencyComplementaryForm = 'Contactos de emergencia';
  static const pdfText = 'PDF';
  static const viewConditionsText = 'Ver condiciones >>';
  static const buyText = 'COMPRAR';
  static const viewMoreText = 'Ver más';
  static const viewLessText = 'Ver menos';
  static const savingText = 'Ahorro:';
  static const totalSavingText = 'Ahorro total:';
  static const signatureText = 'Requiere Firma';
  static const paymentText = 'Pago';
  static const readyText = 'LISTO';
  static const closeText = 'CERRAR';
  static const instructionLabel = 'Instrucciones';
  static const additionTitle = 'Beneficios adicionales';
  static const additionsCatalogInstruction =
      'Selecciona el tipo de adición que deseas realizar';
  static const whatAddition = '¿Qué adición quieres realizar?';
  static const paymentsInstruction =
      'Selecciona el método de pago que deseas usar.';
  static const comboCatalogAdditionLabel = 'Adición en combo para ahorrar más';
  static const individualCatalogAdditionLabel =
      'Adición individual para mayor flexibilidad';
  static const discountCombo = 'Disponible en combo con precio más bajo';
  static const findingPiix = 'Encuéntralo sólo en PIIX';
  static const recommendedPrice = 'Precio recomendado:';
  static const membershipPrice = 'Precio con membresía PIIX:';
  static const individualPrice = 'Precio individual:';
  static const comboPrice = 'Precio en combo:';
  static const priceOfCombo = 'Precio del combo:';
  static const haveACombo = 'Actualmente cuentas con este combo';
  static const haveAnAddition =
      'Actualmente cuentas con esta adición individual.';
  static const buyInCombo = 'Comprando en combo ahorras hasta un ';
  static const benefitsInCombo = 'Beneficios incluidos en el combo';
  static const separatePrice = 'Precio comprando por separado:';
  static const paymentLine =
      'La línea de captura será el medio para realizar el pago en efectivo para'
      ' el método seleccionado.';
  static const paymentLineInstructions = 'Se ha generado con éxito la línea de '
      'captura para realizar el pago en';
  static const thisLabel = 'Esta ';
  static const paymentLinePay = 'línea de captura ';
  static const referencePay = 'referencia ';
  static const referenceInstructions = 'Se ha generado con éxito la '
      'referencia para realizar el pago en';
  static const paymentAmount = 'MONTO A PAGAR';
  static const expire = 'Expira:';
  static const emittedDate = 'Fecha de emisión:';
  static const importantTitle = 'Nota importante:';
  static const ticketFirstLabel =
      'Indica en caja que quieres realizar un pago de Mercado Pago. ';
  static const ticketSecondLabel =
      'Recuerda que con esta compra ahorras para seguir cuidando a tu familia.';
  static const showInstructions = 'Ver instrucciones para realizar el pago en';
  static const ticketRoute =
      'Esta línea de captura la encontrarás disponible en Perfil-Historial de '
      'pagos-Linea de captura';
  static const firstStepPayment =
      '1. Tienes 24 horas para realizar el pago, de lo contrario se cancelará '
      'esta orden.';
  static const goTo = '2. Acude a ';
  static const thirdStepPayment =
      '3. Indica en caja que quieres realizar un pago de ';
  static const mercadoPago = 'Mercado Pago.';
  static const fourthStepPayment =
      '4. Escanea el código o dicta al cajero el número de referencia de esta '
      'línea de captura para que se teclee directamente en la pantalla de '
      'venta.';
  static const fifthStepPayment = '5. Realiza el pago correspondiente con';
  static const moneyText = ' dinero en efectivo.';
  static const sixthStepPayment =
      '6. Al confirmar tu pago, el cajero te entregará un comprobante impreso '
      'de que se realizo correctamente el pago. ';
  static const keepVoucher = 'Conserva el comprobante';
  static const seventhStepPayment =
      '7. Una vez realizado el pago, será procesado, aplicado y se verá '
      'reflejado ';
  static const saleConcept = 'Concepto:';
  static const accountNumber = 'Número de cuenta';
  static const bankRefference = 'Referencia';
  static const paymentLineTitle = 'Línea de captura';
  static const paymentTitle = 'Pagos';
  static const paymentReceipt = 'Recibo de pago';
  static const approvedStatus = 'Aprobado';
  static const forPaymentStatus = 'Por pagar';
  static const expiredStatus = 'Expirado';
  static const oxxo = 'Oxxo';
  static const banks = 'Bancos';
  static const bank = 'Banco';
  static const stores = 'Tiendas de conveniencia';
  static const store = 'Tienda';
  static const availableBanks = 'Bancos disponibles:';
  static const availableStores = 'Tiendas disponibles:';
  static const maleArticle = 'el';
  static const femaleArticle = 'la';
  static const maleSingularCloserSentence = ' más cercano.';
  static const femaleSingularCloserSentence = ' más cercana.';
  static const malePluralCloserSentence = ' más cercanos.';
  static const femalePluralCloserSentence = ' más cercanas.';
  static const theStore = 'la tienda ';
  static const maleOneOf = 'uno de los ';
  static const femaleOneOf = 'una de las ';
  static const validityDays = 'de 1 a 2 días hábiles.';
  static const validityHours = 'en menos de 1 hora.';
  static const checkPiixData = 'Valida tus datos dentro de PIIX';
  static const belongGroup =
      'Ser parte de un grupo te abre las puertas a PIIX. '
      'Ingresa la información para validar tu identidad y realizar tu '
      'registro.';
  static const uniqueId = 'ID único';
  static const prefix = 'Prefijo';
  static const package = 'Paquete';
  static const packageId = 'ID de paquete';
  static const firstName = 'Primer nombre';
  static const secondName = 'Segundo nombre';
  static const names = 'Nombres';
  static const namesError =
      'Ingresa nombres validos empezando con mayúscula separados por espacios.';
  static const lastNamesError =
      'Ingresa apellidos validos empezando con mayúscula separados por espacios.';
  static const firstLastName = 'Primer apellido';
  static const secondLastName = 'Segundo apellido';
  static const lastNames = 'Apellidos';
  static const typeValidName = 'Ingrese un nómbre válido';
  static const typeValidLastName = 'Ingrese un apellido válido';
  static const typeValidPhone = 'Ingrese un teléfono válido';
  static const benefitSeparatePrice = 'Precio de cada beneficio por separado:';
  static const singularBuyCombo = 'Comprando en combo:';
  static const subTotal = 'Subtotal';
  static const taxes = 'Impuestos';
  static const total = 'Total';
  static const paymentLineButton = 'generar línea de captura';
  static const buttonReference = 'generar referencia bancaria';
  static const createPassword = 'Crea tu contraseña';
  static const validatedUserInfo =
      'Se ha validado la información del usuario. Ingresa tu correo '
      'electrónico y tu contraseña.';
  static const typeValidateEmail = 'Ingresa un correo válido';
  static const typeValidatePassword = 'Ingresa una contraseña válida';
  static const samePassword = 'La contraseña no puede ser igual a la anterior';
  static const incorrectPassword = 'La contraseña no es correcta';
  static const email = 'Correo electrónico';
  static const phone = 'Teléfono';
  static const matchEmails = 'Ambos correos deben coincidir';
  static const matchPasswords = 'Las contraseñas deben coincidir';
  static const confirmEmail = 'Confirma el correo electrónico';
  static const confirmPassword = 'Confirma la contraseña';
  static const buyer = 'Comprador';
  static const owner = 'Titular';
  static const ticketNumber = 'Número de ticket';
  static const ticketDate = 'Fecha de orden';
  static const paymentMethod = 'Método de pago';
  static const client = 'Cliente';
  static const approveDate = 'Fecha de aprobación';
  static const youProtected =
      'Ya estás protegido con tu nueva adición. Ahora tu poliza ';
  static const haveText = 'tiene:';
  static const quantity = 'Cantidad';
  static const otherAddition = 'Realizar otra adición';
  static const considerations = 'Consideraciones de tu adición';
  static const contactUs = 'CONTÁCTANOS';
  static const receiptLocation =
      'Este recibo de pago lo encontrarás disponible en Perfil-Historial de '
      'pagos-Recibo de pago.';
  static const activeTime =
      'El periodo de activación tardará hasta 72 hrs después de que el pago '
      'haya sido aprobado.';
  static const validityFirst = 'Esta adición está vigente hasta el';
  static const expireDate = 'fecha de vencimiento de la póliza enlazada.';

  static const membershipInfo = 'Información de membresía';

  static const showPaymentLine = 'VER LÍNEA';
  static const showReference = 'VER REFERENCIA';
  static const showReceipt = 'VER RECIBO';
  static const purchase = 'COMPRAR';
  static const paymentLineInfo =
      'será el medio para realizar el pago en efectivo para'
      ' el método seleccionado.';
  static const paymentMethods = 'Métodos de pago';
  static const availablePaymentMethods = 'Lugares de pago disponibles:';
  static const storesLabel = 'tiendas';
  static const yourAdditions = 'Tus adiciones';
  static const signInfoLabel = 'Este beneficio requiere firma*';
  static const fillInfoLabel = 'Este beneficio requiere llenado*';
  static const signCoInfoLabel = 'Este cobeneficio requiere firma*';
  static const fillCoInfoLabel = 'Este cobeneficio requiere llenado*';
  static const signLabel = 'Firmar';
  static const fillLabel = 'Llenar';
  static const filledLabel = 'Llenado';
  static const additionLabel = 'Adición';
  static const userInfoIncomplete = 'Datos de usuario incompletos';
  static const gettingCountries = 'Obteniendo países...';
  static const gettingStates = 'Obteniendo estados...';
  static const gettingKinships = 'Obteniendo parentezcos...';
  static const gettingPrefixes = 'Obteniendo prefijos...';
  static const gettingGenders = 'Obteniendo géneros...';
  static const gettingUserInfo = 'Obteniendo información de la membresía...';
  static const gettingProtectedInfo = 'Obteniendo información del protegido...';
  static const gettingPaymentMethods = 'Obteniendo métodos de pago...';
  static const gettingAdditionList =
      'Obteniendo lista de adiciones individuales...';
  static const gettingComboList = 'Obteniendo lista de combos...';
  static const idCopied = 'Se ha copiado tu Id.';
  static const membershipInfoCopied = 'Se ha copiado la info de tu membresía.';
  static const gettingBenefitsInfo =
      'Obteniendo información de beneficio y cobeneficios...';
  static const validityLabel = 'Vigente ';
  static const notProtectedTo =
      'Actualmente no tienes socios protegidos con Piix para el paquete';
  static const renderingPDF = 'Renderizando su PDF...';
  static const gettingMemberships = 'Obteniendo membresías de usuario...';
  static const validatingLocation = 'Validando permisos de ubicación...';
  static const gettingClientsIntermediaries =
      'Obteniendo clientes e intermediarios del paquete...';
  static const gettingBenefitForm =
      'Obteniendo la información necesaria para el formulario de beneficio...';
  static const sendingBenefitForm =
      'Mandando la información, un momento por favor...';
  static const benefitFormLabel = 'Formulario beneficio';
  static const saveErrorForm =
      'Hubo un error al guardar el formulario, inténtelo de nuevo';
  static const succesSaveForm =
      'El formulario se ha guardado de forma correcta.';
  static const paymetMethodsEmpty =
      'Ocurrió un error al cargar los métodos de pago.';
  static const verticalDragLabel =
      'Desliza hacía abajo para volver a cargarlos.';
  static const gettingAdditionHistory =
      'Obteniendo el historial de adiciones...';
  static const gettingYourAddition = 'Obteniendo sus adiciones...';
  static const generatingPaymentLine = 'Generando línea de captura...';
  static const generatingPayReference = 'Generando referencia bancaria...';
  static const haveError = 'Hubo un error al';
  static const retryLabel = 'inténtelo nuevamente';
  static const noEmail = 'Agregar correo electrónico';
  static const emailError = 'Ingresa un correo electrónico valido';
  static const noPhone = 'Agregar teléfono';
  static const noContact1 = 'Sin información del contacto de emergencia';
  static const notificationLabel = 'Notificaciones';
  static const allowsPay = 'te permite pagar en ';
  static const anyEstablishments =
      'cualquiera de los siguientes establecimientos:';
  static const individualBenefit = 'Beneficios individuales';
  static const combos = 'Combos';
  static const myCoverage = 'Mi cobertura';
  static const myAdditions = 'Mis compras';
  static const benefitAndCombos = 'Beneficios y combos';
  static const changePlan = 'Cambio de plan';
  static const changeLevel = 'Cambio de nivel';
  static const descriptionBenefitAndCombos = 'Agrega nuevos beneficios para '
      'tener una cobertura completa acorde a tus necesidades.';
  static const descriptionChangePlan = 'Agrega a tus seres queridos y asegúrate'
      ' que están protegidos.';
  static const descriptionChangeLevel =
      'Incrementa las sumas aseguradas de tus '
      'beneficios actuales para estar más protegido.';
  static const currentHasPlan = 'Actualmente cuentas con este plan';
  static const knownPlans = 'Conoce los planes PIIX que puedes elegir.';
  static const blueChoicePlan = 'Selecciona los que están en azul.';
  static const thereAre = '*Hay';
  static const availablePlans = 'planes disponibles para está membresía';
  static const navigatePlanDetail = 'VER >>';
  static const changeLevelInstruction =
      'Selecciona el nivel que quieres alcanzar';
  static const viewMoreLevels = 'Ver otros niveles';
  static const viewMorePlans = 'Ver otros planes';
  static const choosePlan = 'Elegir plan';
  static const currentHaveLevel = 'Actualmente cuentas con este nivel*';
  static const specialFutures = 'Características especiales';
  static const requiredField = 'Campo obligatorio.';
  static const optionalField = 'Campo opcional.';
  static const useHolderData = 'Usar datos del titular';
  static const identificationInfo = 'INFORMACIÓN DE IDENTIFICACIÓN';
  static const emergencyInfo = 'Información de contacto de emergencia';
  static const holderEmergencyData =
      'Para los datos de emergencia se toman los datos del titular';
  static const specifyWhich = '*Especifique cuál';
  static const protectedIncluded =
      'Este plan incluye los siguientes protegidos';
  static const forFill = 'Por llenar';
  static const complete = 'Completo';
  static const save = 'Guardar';
  static const backText = 'Regresar';
  static const yourCurrentPlan = 'Actualmente cuentas con este plan*';
  static const fillProtected =
      '*Una vez activo el plan, recuerda llenar la información de tus '
      'protegidos para que gocen de todos tus beneficios.';
  static const protectedInfo = 'Información de tus protegidos';
  static const priceRules =
      '*Los precios del mercado son el estimado de los precios de este plan '
      'fuera de PIIX y los precios con membresía PIIX son los que obtienes por '
      'pertenecer al grupo.';
  static const emergencyInfoMin =
      'Debe ingresar la información completa de al menos un contacto de '
      'emergencia';
  static const makeLater = 'Lo hago luego';
  static const addressInstructions =
      'La información de la dirección del usuario debe '
      'completarse, de lo contrario no se guardará.';
  static const errorComplementary =
      'Ha ocurrido un error favor de revisar nuevamente los campos';
  static const invalidPhone = 'Teléfono invalido';
  static const searchByCountry = 'Busque por el nombre del país';
  static const gettingComboBenefitsInfo =
      'Obteniendo la información completa de los beneficios del combo';
  static const acquiredText = 'ADQUIRIDO';
  static const savingApportionTitle = 'Desglose de tu ahorro con PIIX';
  static const savingBuyMember = 'Ahorro por comprarlo con membresia PIIX:';
  static const savingByProtecteds =
      'Ahorro por tu número de protegidos activos:';
  static const recomendedPricesInfo =
      '*Los precios recomendados son el estimado de los precios de este plan '
      'fuera de PIIX y los precios con membresía PIIX son los que obtienes por '
      'pertenecer al grupo.';
  static const apportionLabel = 'Ver desglose';
  static const detailRate = 'Detalle de tarifa';
  static const addCombo = 'Estás agregando un combo de';
  static const addIndividual = 'Estás agregando la adición de';
  static const discountInAddition = 'De descuento en esta adición';
  static const rates = 'Tasas';
  static const changeActive = 'Este cambio te activa';
  static const piixThinkingSlogan =
      'porque PIIX siempre piensa en tus seres queridos para que todos gocen de'
      ' las adiciones y los cambios de plan y nivel.';
  static const rememberCombos =
      'Recuerda que al elegir combos dentro de PIIX, tienes los mejores '
      'descuentos';
  static const rememberIndividual =
      'Recuerda que al elegir beneficios adicionales dentro de PIIX, tienes los'
      ' mejores descuentos';
  static const forAll = 'para todos tus protegidos';
  static const continueText = 'Continuar';
  static const help = 'Ayuda';
  static const goToPayments =
      'Continuar te llevará a seleccionar el método de pago para que termines '
      'tu adición exitosamente.';
  static const youChangeYourLevel = 'Estás subiendo de categoría tu nivel';
  static const upgradeFrom = 'Pasas de';
  static const changeInclude = 'Este cambio incluye a todos tus';
  static const rememberPlanAndLevel =
      'Recuerda que entre más protegidos, mayor descuento dentro de PIIX.';
  static const youChangeYourPlan = 'Estás cambiando tu plan';
  static const upgradePlan = 'Estás subiendo de categoría tu plan,';
  static const recomendedPlanPricesInfo =
      '*Los precios recomendados son el estimado de los precios de este plan '
      'fuera de PIIX y los precios con membresía PIIX son los que obtienes por '
      'pertenecer al grupo.';
  static const upgradeLevel = 'Estás subiendo de categoría tu nivel,';
  static const recomendedLevelPricesInfo =
      '*Los precios recomendados son el estimado de los precios de este nivel '
      'fuera de PIIX y los precios con membresía PIIX son los que obtienes por '
      'pertenecer al grupo.';
  static const phoneEmailLabelText = 'Teléfono/Correo electrónico*';
  static const phoneEmailHelperText =
      'Ingresa el teléfono o correo electrónico del usuario.';
  static const iHaveAleradyCode = 'Ya tengo código';
  static const forgotPassword = 'Olvidé contraseña';
  static const wannaRegister = 'Quiero registrarme';
  static const register = 'Registro';
  static const registerButtonText = 'Registrarme';
  static const uniqueIdHelperText =
      'El ID único te lo proporciona el grupo al que perteneces.';
  static const areaCode = 'Lada';
  static const idNotFound = 'ID único no encontrado';
  static const idAlreadyRegistered = 'ID único ya registrado';
  static const successfulRegistration = '¡Registro exitoso!';
  static const emailSent =
      'Se te ha enviado un correo electrónico con contraseña temporal. Valida '
      'tu cuenta, inicia sesión, actualiza tu contraseña y completa la '
      'información básica.';
  static const smsSent =
      'Se te ha enviado un SMS con código de validación. Valida tu cuenta, '
      'inicia sesión y completa la información básica.';
  static const unexpectedError = 'Error inesperado';
  static const unexpectedErrorOccurred =
      'Ocurrió un error inesperado y no se ha podido completar el registro.'
      ' Intenta de nuevo.';
  static const uniqueIdTooltip = 'El Id único es el número que te '
      'identifica dentro del grupo. Por ejemplo, '
      'la CURP o el número del predial '
      'son IDs únicos frecuentes. Si no conoces '
      'tu ID, comunícate con tu representante '
      'de grupo y solicítalo.';
  static const enterEmailRecovery =
      'Ingresa el correo de tu cuenta PIIX y recibirás un '
      'correo electrónico con las instrucciones para recuperar'
      ' tu contraseña';
  static const enterPhoneOrEmailRecovery =
      'Ingresa el télefono o correo registrado en tu cuenta Piix. '
      'A continuación recibiras un SMS o correo electrónico con las instrucciones '
      'para recuperar tu contraseña.';
  static const recoverPassword = 'Recuperar contraseña';
  static const updatePassword =
      'Actualiza la contraseña para continuar con el proceso de registro';
  static const updatePasswordButton = 'Actualizar contraseña';
  static const temporalPasswordLabelText = 'Contraseña temporal*';
  static const newPasswordLabelText = 'Nueva contraseña*';
  static const repeatNewPasswordLabelText = 'Repetir nueva contraseña*';
  static const updateEmail = 'Actualizar correo';
  static const updatePhone = 'Actualizar teléfono';
  static const updateButton = 'Actualizar';
  static const enterUserEmail =
      'Ingresa el correo electrónico a registrar dentro de PIIX.';
  static const enterUserPhone =
      'Ingresa el teléfono a registrar dentro de PIIX.';
  static const smsSentTempPassword =
      'Se ha enviado una contraseña temporal al teléfono registrado, ingrésala'
      ' para validar tu cuenta.';
  static const sendAgain = 'Volver a enviar';
  static const enterPhoneTempPassword =
      'Ingresa la contraseña temporal que recibiste en el SMS.';
  static const enterEmailTempPassword =
      'Ingresa la contraseña temporal que recibiste en el correo de '
      'validación.';
  static const emailSentTempPassword =
      'Se ha enviado una contraseña temporal al correo registrado, ingrésala '
      'para validar tu cuenta.';
  static const linkSentSuccess =
      '¡Se ha enviado la liga para recuperar tu contraseña!';
  static const appFailure = 'Lo sentimos ocurrio un error';
  static const successfulRecoveryEmailSent =
      'Se ha enviado el enlace a tu correo electrónico.';
  static const successfulRecoverySMSSent =
      'Se ha enviado el SMS a tu teléfono.';
  static const failedRecoveryEmailSent =
      'No se pudo enviar el enlace a tu correo electrónico';
  static const failedRecoverySMSSent = 'No se pudo enviar el SMS a tu teléfono';
  static const recoveryEmailNotFound =
      'No se encontro en nuestros registros el correo electrónico';
  static const recoveryPhoneNotFound =
      'No se encontro en nuestros registros el número de teléfono';
  static const tryAgain = 'Volver a intentar';
  static const enterPhoneEmailValid =
      'Ingresa un correo electrónico/teléfono de 10 digitos válido.';
  static const checkYourEmail = 'Ingresa un correo electrónico válido.';
  static const checkYourPhone = 'Ingresa un teléfono válido.';
  static const checkYourPassword =
      'Favor de revisar que la contraseña sea correcta.';
  static const sendingRestore =
      'Enviando enlace de recuperación de contraseña...';
  static const pleaseWait = 'Por favor espera...';
  static const successfulUpdate = '¡Actualización exitosa!';
  static const failedUpdate = 'Actualización fallida';
  static const passwordSuccessfulUpdated =
      'Se ha actualizado exitosamente tu contraseña.';
  static const updatingPassword = 'Actualizando contraseña...';
  static const passwordFailedUpdated =
      'Ocurrió un error inesperado y no se ha actualizado tu contraseña, '
      'intenta de nuevo.';
  static const sos = 'SOS';
  static const successfulUpload = 'Carga exitosa';
  static const basicInfoSuccessfullyUploaded =
      'Se ha cargado la información básica exitosamente.';
  static const basicInfoNotFull = 'Información básica sin llenar';
  static const fullTheBasicInfo =
      'Llena la información para continuar con la activación de tu membresía.';
  static const formInfoNotFound =
      'No se pudo obtener la información del formulario.';
  static const inactiveMembership = 'Inactiva';
  static const activeMembership = 'Activa';
  static const packageText = 'Paquete';
  static const packageLoading = 'Cargando los paquetes';
  static const packageLoadError = 'No se cargaron los paquetes';
  static const levelText = 'Nivel';
  static const membershipIsActivating =
      'Tu membresía está en proceso de activación';
  static const membershipFillBasicInfo =
      'Llena la información básica para seguir con el proceso de activación'
      ' de tu membresía.';
  static const fromHere = 'Desde aquí >>';
  static const youHaveAdditionalForms = 'Tienes formularios adicionales';
  static const fillAdditionalForms =
      'Llénalos para continuar con la activación de tu membresía.';
  static const fillThe = 'LLena la ';
  static const basicInfo = 'Información básica';
  static const continueActiveProcess =
      ' para seguir con el proceso de activación de tu membresía.';
  static const fillFormBasicInfo =
      'A continuación, en el formulario debes llenar los campos de información '
      'básicos para activar tu cuenta y empezar a usar los beneficios dentro de PIIX.';
  static const personalData = 'Tus datos';
  static const gender = 'Género';
  static const leaveCurrentPage =
      '¿Estás seguro de abandonar lo que estas haciendo?';
  static const leaveForm = '¿Estás seguro de abandonar el formulario?';
  static const leaveFormMessage =
      "Al presionar 'Aceptar' se perderá cualquier dato ingresado dentro del"
      ' formulario. Recuerda que debes completar todos los datos obligatorios '
      'para guardar la información básica.';

  static const hereLabel = 'aquí';
  static const genderLabel = 'Género';
  static const myPiixInfo = 'Mi info PIIX es:';
  static const copyInfo = 'Copiar info';
  static const totalProtected = 'Protegidos totales';
  static const youHave = 'Cuentas con';
  static const protectedToRegister = 'Protegidos por registrar';
  static const toRegister = 'Registrar';
  static const protectedWithAssignedMembership =
      'Protegidos con membresía activa';
  static const protectedWithoutAssignedMembership =
      'Protegidos con membresía inactiva';
  static const activeYourProtected = 'Activa tu protegido';
  static const confirmSaveProtected =
      'Confirmar el guardado del registro de tu protegido';
  static const acceptSaveProtected =
      'Al presionar "Aceptar" confirmo que he cargado la información de '
      'registro de mi protegido para este plan. Conozco que esta información '
      'será cargada y utilizada para la póliza y el servicio.';
  static const successfulCredentialChange =
      'Se ha cambiado la información exitosamente!';
  static const reauthenticatePassword = 'Por favor vuelve a introducir la '
      'contraseña para mantener la sesión activa';
  static const editEmail = 'Editar correo electrónico';
  static const editPhone = 'Editar teléfono';
  static const addEmail = 'Agregar correo electrónico';
  static const addPhone = 'Agregar teléfono';
  static const editEmailInstruction =
      'Ingresa el nuevo correo electrónico para tu cuenta piix. Asegúrate que '
      'sea un correo válido.';
  static const editPhoneInstruction =
      'Ingresa el nuevo teléfono para tu cuenta Piix. Asegúrate que sea un '
      'teléfono válido.';
  static const addEmailInstruction =
      'Ingresa el nuevo correo electrónico que deseas agregar. Asegúrate que '
      'sea un correo válido.';
  static const addPhoneInstruction =
      'Ingresa el nuevo teléfono que deseas agregar. Asegúrate que '
      'sea un teléfono válido.';
  static const edittingEmail = 'Editando correo electrónico...';
  static const addingEmail = 'Agregando correo electrónico...';
  static const edittingPhone = 'Editando teléfono...';
  static const addingPhone = 'Agregando teléfono...';
  static const successEditEmail = '¡Actualización de correo exitosa!';
  static const successEditPhone = '¡Actualización de teléfono exitosa!';
  static const errorEditEmail = '¡Actualización de correo fallida!';
  static const errorEditPhone = '¡Actualización de teléfono fallida!';
  static const userNotFound = 'El usuario no fue encontrado';
  static const userNotAuthenticated = '\nEl usuario no fue reconocido, '
      'vuelve a iniciar sesión. '
      'Es probable que el correo, '
      'teléfono o contraseña cambiaron.';
  static const successEditEmailContent =
      'Recuerda que con este correo puedes iniciar sesión.';
  static const successEditPhoneContent =
      'Recuerda que con este teléfono puedes iniciar sesión.';
  static const errorEditEmailContent =
      'No se ha podido editar el correo. Intenta de nuevo.';
  static const errorEditPhoneContent =
      'No se ha podido editar el teléfono. Intenta de nuevo.';
  static const startUpdatingProcess =
      'Iniciando proceso de actualización de credenciales...';
  static const withActiveMembreship = 'Con membresía activa';
  static const withInactiveMembership = 'Con membresía inactiva';
  static const activateProtected = 'Activa tu protegido ';
  static const fillBasicForm = 'Llenar formulario básico';
  static const protectedInProcess =
      'Protegido en proceso de activación de membresía. '
      'Visualiza la información de tu protegido.';
  static const country = 'País';
  static const state = 'Estado';
  static const city = 'Ciudad';
  static const postalCode = 'Código postal';
  static const memberSince = 'Miembro desde';
  static const validity = 'Vigencia';
  static const validitySince = 'Vigencia desde';
  static const validityUntil = 'Vigencia hasta';
  static const policyNumber = 'Número de póliza';
  static const membershipID = 'ID de membresía';
  static const viewMembership = 'Ver membresía';
  static const viewCurrentMembership = 'Ver membresía actual';
  static const userType = 'Tipo de usuario';
  static const areaCodeAndPhone = 'Lada y teléfono';
  static const fillBasicProtectedForm1 =
      'A continuación, en el formulario debes llenar los campos de información'
      ' básicos de tu protegido para';
  static const fillBasicProtectedForm2 = 'comenzar el proceso de activación';
  static const fillBasicProtectedForm3 = 'de su cuenta.';
  static const writeOfficialNames =
      'Escribe el/los nombre(s) tal y como aparecen en los documentos de '
      'identificación oficial.';
  static const writeOfficialLastNames =
      'Escribe el/los apellido(s) tal y como aparecen en los documentos de '
      'identificación oficial.';
  static const seePlanAboutToActivate1 = 'Si ves un plan por activar';
  static const seePlanAboutToActivate2 =
      'es que está en proceso de ser activado.';
  static const choosePlanInfo =
      'Al elegir este plan accedes a mejores descuentos porque aumentas tu '
      'número de protegidos activos.';
  static const inProcesssLabel = 'En proceso';
  static const membershipToActivate = 'Membresía por activar';
  static const kinshipColon = 'Parentesco:';
  static const birthDateColon = 'Fecha de nacimiento:';
  static const activatedMembership = 'Membresía activada';
  static const advantagesLabel = 'Ventajas';
  static const requirementsLabel = 'Requerimientos';
  static const idealForLabel = 'Ideal para';
  static const signatureBenefitText = 'Firmar';
  static const provisionerSingularLabel = 'Proveedor';
  static const provisionerPluralLabel = 'Proveedores';
  static const signedLabel = 'Firmado';
  static const paymentApprovedStatus = 'Pagado';
  static const acquirePlanSaving =
      'Al elegir este plan accedes a mejores descuentos '
      'porque aumentas tu número de protegidos activos.';
  static const viewProtected = 'Ver protegidos';
  static const protectedLabel = 'Protegido';
  static const proccessActiveAddition =
      'Adición en proceso de ser activada. Este proceso de activación puede '
      'durar hasta 72 horas.';
  static const piixExclusive = 'Exclusivo PIIX';
  static const piixPriceExclusive = 'Precios exclusivos PIIX';
  static const gettingPlansToAcquired =
      'Obteniendo lista de planes para adquirir...';
  static const rememberPlan =
      'Recuerda que entre más protegidos, mayor descuento dentro de PIIX.';
  static const rememberLevel =
      'Recuerda que entre más protegidos mayor descuento dentro de PIIX.';
  static const notHaveAdditions =
      'Aún no has realizado compras en la tienda virtual.';
  static const acquireLevelSaving =
      'Al elegir este nivel accedes a mejores descuentos.';
  static const choiceLevelLabel = 'Elegir nivel';
  static const yourCurrentLevel = 'Actualmente cuentas con este nivel*';
  static const gettingLevelsToAcquired =
      'Obteniendo lista de niveles para adquirir...';
  static const levelBenefits = 'Beneficios del nivel';
  static const youSave = 'Ahorras';
  static const notificationHistory = 'Historial de notificaciones';
  static const noNotificationsLabel = 'No tiene notificaciones al momento.';
  static const importantLabel = 'Importante';
  static const gettingAdditionsAndCombosList =
      'Obteniendo lista de adiciones y combos...';
  static const withoutMembership = 'Sin membresía';
  static const withMembership = 'Con membresía';
  static const generalError = 'Ocurrio un error inesperado. Inténtalo de nuevo';
  static const validate = 'Validar';
  static const haveNotPassword = 'No tengo contraseña';
  static const validatingCode = 'Estamos validando tú código';
  static const ifItIsCorrect = 'Si es correcto';
  static const loginForYou = 'iniciaremos sesión por ti';
  static const succesfulRecoveryLinkSent =
      'Se enviado correctamente el enlace a tu correo electrónico para recuperar tu contraseña';
  static const failedRecoveryLinkSent =
      'No se envió correctamente el correo, intenta de nuevo';
  static const enterYourPassword = 'Ingresa tu contraseña';
  static const registeringUser = 'Registrando usuario';
  static const registerUserNotFound =
      'No se encontró un usuario con esa información para el paquete';
  static const registerUserAlreadyExists =
      'Se encontró ya un usuario con esa información registrado.';
  static const emailSMSRegistrationSent =
      'Se te ha enviado un correo electrónico y un SMS con contraseña temporal.'
      ' Valida tu cuenta, inicia sesión, actualiza tu contraseña y completa la'
      ' información básica.';
  static const smsRegistrationSent =
      'Se te ha enviado un SMS con contraseña temporal. '
      'Valida tu cuenta, inicia sesión y completa la información básica.';
  static const signatureConfirmedCorrectly =
      'Se ha confirmado correctamente la firma';
  static const errorUploadingSignatureImage =
      'Hubo un error al subir la imagen de firma. Intenta de nuevo.';
  static const confirmSignature = 'Confirmar firma';
  static const clearSignature = 'Limpiar firma';
  static const signature = 'Firma';
  static const loadVariousImages = 'Puedes cargar varias imágenes.';
  static const takeNewPhoto = 'Tomar nueva foto';
  static const enterValidTime = 'Ingresa una hora y minuto validos.';
  static const hour = 'Hora';
  static const minute = 'Minuto';
  static const enterTime = 'Ingresa la hora y minuto';
  static const enterValidHour = 'Ingresa una hora dentro del rango válido';
  static const example = 'Ejemplo';
  static const clear = 'Limpiar';
  static const accept = 'Aceptar';
  static const cancel = 'Cancelar';
  static const confirm = 'Confirmar';
  static const use = 'Usar';
  static const savingInfo = 'Guardando información...';
  static const thereWasAnErrorLoadingImage =
      'Hubo un error al cargar la imagen';
  static const errorRegistrationTitle = '¡Registro fallido!';
  static const successfulProtectedRegisterText =
      'Tu protegido se ha dado de alta.';
  static const errorProtectedRegisterText =
      'Ocurrió un error y no se ha podido hacer el registro '
      'de tu protegido, intenta nuevamente.';
  static const gettingProtected = 'Obteniendo la información de protegidos...';
  static const registeringProtected = 'Registrando protegido...';
  static const gettingBasicFormInfo =
      'Obteniendo información del formulario básico...';
  static const successfulBasicFormInfo =
      'Se ha guardado correctamente la información del formulario básico.';
  static const errorBasicFormInfo =
      'Ocurrió un error al guardar la información del formulario básico.';
  static const notBuyCombo = 'No tienes combos.';
  static const notBuyIndividual = 'No tienes beneficios individuales.';
  static const actuallyHavePlan = 'Actualmente tienes el plan ';
  static const haveNotProtected = 'por lo que no cuentas con protegidos.';
  static const migratePlanInvite =
      'PIIX protege a quienes más quieres. Para activar protegidos revisa los '
      'planes que tiene PIIX y contrata el plan que se ajuste a tus '
      'necesidades.';
  static const viewOtherPlans = 'Ver otros planes >>';
  static const goToAddition = 'Ir a Tienda >>';
  static const userAlreadyRegister = 'ID único de usuario ya registrado';
  static const phoneAlreadyRegister = 'Teléfono de usuario ya registrado';
  static const userNotInList =
      'No hemos encontrado este ID de usuario para el paquete seleccionado. '
      'Revísalo e intenta nuevamente';
  static const successfulSave = '¡Guardado exitoso!';
  static const requests = 'Solicitudes';
  static const requestsHistory = 'Historial de solicitudes';
  static const requestNumber = 'Número de solicitud';
  static const requestDate = 'Fecha de solicitud';
  static const updateDate = 'Fecha de actualización';
  static const activatedDate = 'Fecha de activación';
  static const cancelDate = 'Fecha de cancelación';
  static const finishDate = 'Fecha de finalización';
  static const reportProblem = 'Reportar problema';
  static const haveProblem = 'Problema reportado';
  static const cancelRequest = 'Cancelar solicitud';
  static const finishRequest = 'Terminar solicitud';
  static const requestAgain = 'Volver a solicitar';

  static const exit = 'Salir';

  static const successfulFinish = 'Terminación exitosa';
  static const contactSupplier = 'Contacta a tu proveedor';
  static const callByPhone = 'Llamar por teléfono';
  static const messageByWhatsApp = 'Escribir por WhatsApp';
  static const goingToStartRequestProcess =
      'Vas a comenzar tu proceso de solicitud con PIIX';

  static const sendText = 'Enviar';
  static const finishDone = 'He terminado';
  static const haveAProblem = 'Tuve un problema';
  static const generalQualification = 'Calificación general';
  static const tellUs = 'Cuéntanos';
  static const rateUs = 'Califícanos';
  static const selectOption = ' selecciona:';
  static const stillApplicationProcess = 'Aún estoy en el proceso de solicitud';
  static const applicationFinished = 'Solicitud terminada \n ¡Califícanos!';
  static const benefitRatingQuestion = '¿Cómo calificas al beneficio\n';
  static const supplierRatingQuestion = '¿Cómo calificas al proveedor\n';
  static const applicationRatingQuestion =
      '¿Qué calificación general darías a la \natención recibida en tu ';
  static const applicationLabel = 'solicitud';
  static const aboutApplication = 'Respecto a tu solicitud';
  static const ofBenefitAplication = ' del beneficio de ';
  static const sosComments =
      'Menciona el beneficio solicitado y compártenos tus comentarios '
      '(Opcional)';
  static const thanksForQualifying = 'Gracias por tu calificación';
  static const successCancellation = 'Cancelación exitosa';
  static const yourOpinionIsImportant =
      'Para nosotros tu opinión es muy importante';

  static const problemReceived = 'Problema recibido';
  static const problemReceivedDescription =
      'Lo sentimos, en breve nos contactaremos contigo para verificar el '
      'problema.';

  static const qualify = 'Calificar';
  static const requestsScreenInfo =
      'Recuerda que acá podrás encontrar las solicitudes abiertas, '
      'terminadas o canceladas que hayas realizado con PIIX';
  static const benefits = 'Beneficios';

  static const openRequest = 'Solicitud abierta';
  static const viewRequest = 'Ver solicitud';

  static const cancellingTicket = 'Cancelando solicitud...';
  static const ratingTicket = 'Enviando calificación...';
  static const reOpeniningTicket = 'Iniciando nueva solicitud...';
  static const reportingTicket = 'Reportando problema en solicitud...';
  static const checkYourConnection =
      'Revisa tu conexión a internet e intenta nuevamente';
  static const noConnection = 'No estás conectado';
  static const withNumber = 'con número';
  static const withName = 'con nombre';
  static const youWantContinueTo = '¿Tu proceso de solicitud continúa?';
  static const continueToMessage = "Al presionar 'Aceptar', confirmo que sigo"
      ' en proceso de solicitud. Para verificar el estado de solicitud ve a tu '
      'perfil en historial de solicitudes.';
  static const guideTicketTitle = 'Guía de solicitud';
  static const membershipDataLabel = 'Datos de la membresía:';
  static const requestHave = 'Tener al momento de la solicitud:';
  static const requestAsk = 'Solicitar al proveedor:';
  static const requestConsider = 'Tener en consideración:';
  static const should = 'debes:';
  static const instuctionGuides = 'para realizar con éxito tu solicitud';
  static const buttonGuideInstructions =
      'Da clic en el siguiente botón para seleccionar el medio de contacto y '
      'comenzar una solicitud con el monitoreo, así cuidamos la calidad de tu'
      ' beneficio.';
  static const startRequest = 'Iniciar solicitud';
  static const membershipId = 'Id de la membresía:';
  static const planColon = 'Plan:';
  static const validitySinceColon = 'Vigencia desde:';
  static const validityUntilColon = 'Vigencia hasta:';
  static const requestcanceled = 'Solicitud cancelada';
  static const requestclosed = 'Solicitud cerrada';
  static const requestLabel = 'Solicitud';
  static const tooltipActiveMembership =
      'Puedes hacer uso de tu membresía, tanto de beneficios, cobeneficios y '
      'solicitudes.';
  static const tooltipInActiveMembership =
      'Por el momento no puedes hacer uso de los beneficios de tu membresía, '
      'pero tienes la posibilidad de explorar todo que Piix tiene en espera '
      'para ti.';
  static const reachedProtectedLimit =
      'No puedes agregar protegidos, haz alcanzado el límite para tú paquete.';
  static const upgradePlanToAddMoreProtected =
      'Si quieres agregar más protegidos, debes adquirir más planes.';
  static const emailAlreadyExists =
      'El correo electrónico que ingresó ya existe, intente con otro correo '
      'electrónico.';
  static const phoneAlreadyExists =
      'El teléfono que ingresó ya existe, intente con otro teléfono';
  static const signInAgain =
      'Por favor termina tu sesión y vuelve a iniciarla.';
  //***********************Piix Signature Input***********************///
  static const signatureNameGuideline =
      'Ingresa con el dedo tu nombre o firma tal como lo muestra el ejemplo '
      'en el siguiente campo.';
  static const signatureDAndPGuideline =
      'Ingresa con el dedo la fecha y lugar donde te encuentras tal como '
      'lo muestra el ejemplo en el siguiente campo.';
  ////**************************************************************////
  //**********************Piix Camera Input**************************///
  static String documentTypeGuideline(int minPhotos, String documentName) =>
      'Toma minimo $minPhotos fotos de tu ${documentName}. '
      'Toma una foto por delante y por detras. '
      'La información debe ser legible.';
  static const selfieTypeGuideline =
      'Tomate una fotografía que confirme tu identidad para activar este beneficio.';
  ////**************************************************************////
  static const String sureToExit = '¿Estás seguro que deseas \nsalir?';

  // Rich text functions
  static String minCharactersValidatorText(int minLength) =>
      'El campo debe tener mínimo $minLength caracteres.';
  static String showExampleFillField(String fieldName) =>
      'A continuación se muestra un ejemplo de cómo llenar $fieldName.';
  static String confirmedCorrectly(String fieldName) =>
      'Se ha confirmado correctamente $fieldName';
  static String accumulatedPercentage(num? percentage) =>
      'Tu porcentaje acumulado es $percentage %';
  static String minimumPercentage(num? percentage) =>
      'Ingresa un porcentaje mínimo de $percentage %';
  static String youHaveExceededMaximumPercentage(
          num? totalPercentage, num? actualPercentage) =>
      'Has superado el porcentaje máximo permitido. Ajusta los campos para acumular el $totalPercentage %. (Acumulado actual: $actualPercentage %)';
  static String enterMaximumPercentage(
          num? maxPercentage, num? actualPercentage) =>
      'Ingresa un porcentaje máximo de $maxPercentage %. (Acumulado actual: $actualPercentage %)';

  static String chatMessage(
          {UserAppModel? user,
          MembershipModelDeprecated? membership,
          String? benefitName = ''}) =>
      benefitName == null
          ? 'Hola, mi nombre es ${user?.displayName ?? '-'} '
              'con número de membresia PIIX *${user?.uniqueId ?? '-'}*. '
              'para el paquete *${membership?.package.name ?? '-'}*. '
              'y necesito ayuda urgente.'
          : 'Hola, mi nombre es *${user?.displayName ?? '-'}* '
              'con número de membresia PIIX *${user?.uniqueId ?? '-'}*. '
              'Estoy solicitando el beneficio *$benefitName* '
              'para el paquete *${membership?.package.name ?? '-'}*. '
              'Muchas gracias por la atención.';

  static String reportProblemMessage(String benefitName) =>
      'Estás iniciando un reporte de un problema con el beneficio'
      "'$benefitName'. Al presionar 'Aceptar' se "
      'iniciará el monitoreo para resolver el problema reportado.';
  static String cancelProblemMessage(String benefitName) =>
      'Al presionar "Aceptar" confirmo que quiero cancelar mi solicitud. '
      'Para verificar la cancelación revisa tu perfil en historial de solicitudes.';
  static String initNewBenefitMonitoring(String benefitName) =>
      "Se iniciará un nuevo monitoreo para el beneficio de '$benefitName'.";

  static String youHaveCanceledTheRequest(String benefitName) =>
      'Has cancelado la solicitud \'$benefitName\'';

  static String benefitQualification(String benefitName) =>
      'Calificación del Beneficio de $benefitName';

  static String supplierQualification(String supplierName) =>
      'Calificación del Proveedor $supplierName';

  // Claims copies
  static const claimsLabel = 'Solicitudes';
  static const historyClaims = 'Historial de solicitudes';
  static const gettingTicketHistory = 'Obteniendo historial de solicitudes...';
  static const claimInstructions = 'Quiero tener una solicitud exitosa';
  static const startClaim = 'Iniciar solicitud';
  static const startClaimPeak = 'Iniciar solicitud >>';
  static const youWantToFinishAClaim =
      '¿Estás seguro de que deseas terminar la solicitud?';
  static const finishProblemMessage = "Al presionar 'Aceptar' terminarás la "
      'solicitud, podrás calificar la '
      'atención que se te ha brindado.';
  static const claimInProcess = 'Solicitud en proceso';
  static const createClaimErrorMessage =
      'No se ha podido crear la solicitud, intenta nuevamente.';
  static const cancelClaimErrorMessage =
      'No se ha podido cancelar la solicitud, intenta nuevamente.';
  static const reportClaimErrorMessage =
      'No se ha podido reportar la solicitud, intenta nuevamente.';
  static const finishClaimErrorMessage =
      'No se ha podido terminar la solicitud, intenta nuevamente';
  static const ticketInProcess = 'Solicitud en proceso';
  static const ticketFromSOS = 'Solicitud desde SOS';
  static const ticketInProcessLabel =
      'En 48 horas nos volveremos a contactar contigo para dar seguimiento a '
      'tu solicitud';
  static const claimQualificationError =
      'No se ha podido registrar tu calificación, intenta nuevamente';
  static const generalQualificationDescription =
      'Esta calificación es el promedio entre la calificación del beneficio y '
      'el proveedor. Esta será la calificación que verás en el Historial de '
      'solicitud.';
  static const yourOpinionMatters =
      'Tu opinión nos importa. Cuéntanos por qué has cancelado la solicitud.';
  static const yourOpinionProblem =
      'Tu opinión nos importa. Cuéntanos sobre tu problema:';
  static const problemComments = 'Cuéntanos sobre tu problema';
  static const areYouSureReportProblem =
      '¿Estás seguro de que deseas reportar un problema?';
  static const sharedComments = 'Compártenos tus comentarios (Opcional)';
  static const areYouSureStartClaim =
      '¿Estás seguro de comenzar una solicitud?';
  static const youGoingToStartProcess = 'Vas a comenzar un proceso de';
  static const whatsAppRequest = 'solicitud con WhatsApp';
  static const phoneRequest = 'solicitud con Llamada';
  static const willActivateSystemMonitoring =
      'Al aceptar se activará el sistema de monitoreo PIIX para dar '
      'seguimiento a tu solicitud.';
  static const acceptStartClaimText =
      'Dar clic en "Aceptar" copiará los datos de tu membresía para que los '
      'puedas compartir.';
  static const requestBenefitGuide = 'Guía para solicitar un beneficio';
  static const descriptionLabel = 'Descripción';
  static const contains = 'Contiene';

  // Claim rich copies
  static String claimRequestFinishedAndClosed(String benefitName) =>
      'Se ha terminado el proceso de monitoreo y se ha cerrado la solicitud '
      "para el beneficio '$benefitName.'";

  static String successCancellationDescription(String benefitName) {
    var cancelDescription = 'Se ha cancelado tu ';
    if (benefitName.isEmpty)
      return (cancelDescription += PiixCopiesDeprecated.ticketFromSOS);
    return (cancelDescription += ' solicitud para el beneficio $benefitName');
  }

  static String startingReportProblem(String benefitName) =>
      'Estás iniciando un reporte de un problema con el beneficio'
      " '$benefitName' al presionar "
      "'Aceptar' se iniciará el monitoreo para resolver el problema reportado.";

  static String claimBenefitAgain(String benefitName) =>
      "¿Deseas volver a solicitar el beneficio de '$benefitName'?";

  static String finishClaimSuccessMessage(String benefitName) =>
      "Se ha terminado con éxito la solicitud del beneficio '$benefitName.'";

  static String youWantToCancelAClaim(String? benefitName) =>
      '¿Estás seguro de que deseas cancelar la solicitud'
      '${benefitName != null ? " '$benefitName'" : ''}?';

  static String forBenefitName(String benefitName) => 'para "$benefitName".';

  //************************************Camera Errors Copies************************************//
  static const cameraPermission =
      'Por favor autoriza a la camara para poder usarla en la aplicación';
  static const cameraCouldNotStart = 'La camara no pudo iniciar';
  static const cameraNotFound =
      'La camara no se pudo encontrar en el dispositivo.';
  static const captureAlreadyActive = 'La imagen ya esta siendo capturada.';
  static const cannotCreateFile =
      'No se pudo crear el archivo para almacenar la captura.';
  static const captureTimeout = 'No se pudo completar la petición de captura.';
  static const captureFailure =
      'Ha ocurrido un error al intentar capturar la imagen';
  static const IOError = 'No se pudo guardar la imagen';
  static const videoRecordingFailed =
      'Ocurrio un error al intentar grabar el video.';
  static const setFlashModeFailed =
      'La función de modo flash o el modo flash seleccionado no esta disponible en el dispositivo.';
  static const setExposureModeFailed =
      'La función de exposición o el modo de exposición seleccionado no esta disponible en el dispositivo';
  static const setExposurePointFailed =
      'El dispositivo no cuenta con capacidades de limites para el modo de exposición.';
  static const setFocusModeFailed =
      'La función de focalización o el modo de focalización seleccionado no esta disponible en el dispositivo.';
  static const zoomError =
      'Se ha seleccionado un nivel de zoom que no puede utilizarse.';
  static const unknownCameraError =
      'Ocurrio un error desconocido con la camara';
  static const maximumPhotosReached =
      'Has alcanzado el límite de fotos para este documento. Elimina una o algunas fotos para tomar una nueva.';

  //============================STORE COPIES==================================//
  static const String storeLabel = 'Tienda';
  static const String currentNotHave = 'Actualmente no se \nencuentran ';
  static const String availableToBuy = '\n disponibles para comprar.';
  static const String backToStore = 'Regresar a tienda';
  static const String specialOffers = 'Ofertas especiales';
  static const String quoteIndividualBenefits =
      'Cotiza beneficios individuales';
  static const String productsForYou = 'Productos para tí';
  static const String everything = 'Todo';
  static const String allBenefits = 'Todos los beneficios';
  static const String additionalBenefitListBrief =
      'Piix ofrece beneficios adicionales con precios accesibles'
      ' para mejorar tu membresía. La cotización es gratuita.';
  static const String knowMore = 'Saber más';
  static const String quoteButtonLabel = 'Cotiza sin compromiso';
  static const String quoteToProtectedLabel = 'Cotiza para protegidos';
  static const String discoverPrice =
      'Descubre tu precio y cobertura personalizados';
  static const String yearValidity = '1 año a partir de la compra';
  static const String benefitDetail = 'Detalle de beneficio';
  static const String alreadyAcquiredBenefit = 'Ya cuentas con este beneficio';
  static const String htmlDescription = '<p> <b>Descripción:</b> ';
  static const String htmlParagraphTag = '<p>';
  static const String combosListBrief =
      'Para mejorar tu membresía, PIIX te ofrece beneficios adicionales que en '
      'combo tienen mayor descuento.';
  static const String attendanceTooltipInfo =
      'Las asistencias las solicitas de manera \n'
      'directa y sin pago previo en el caso de una \n'
      'emergencia. Desde limpieza dental hasta \n'
      'plomería, encuentra asistencias confiables.';
  static const String insuranceTooltipInfo =
      'Accede a los seguros más completos con \n'
      'la mejor protección del mercado. \n'
      'Considera que para un seguro debes \n'
      'cubrir el gasto y esperar un reembolso. ';
  static const String servicesTooltipInfo =
      'Un servicio es una prestación brindada por \n'
      'profesionales para realizar determinadas \n'
      'tareas o resolver problemas de un \nasegurado.';
  static const String allBenefitsTooltipInfo =
      'En esta sección se muestran los 3 tipos de \n'
      'beneficio que ofrece Piix App: Asistencias, \n'
      'Seguros y Servicios.   ';
  static const String combosTooltipInfo =
      'Los combos brindan un conjunto de \nbeneficios, seguros, asistencias y '
      'servicios \npara dar mayor cobertura al asegurado a \nun menor precio; '
      'ya que al estar en \npaquete, los beneficios pueden tener \nmejores '
      'descuentos. ';
  static const String ofDiscount = 'de descuento';
  static const String inAllBenefits = 'en los beneficios';
  static const String comboDetail = 'Detalle de combo';
  static const String alreadyAcquiredCombo = 'Ya cuentas con este combo';
  static const String noMoreAddBenefitsInCombo =
      'A un combo no se le pueden agregar ni quitar más beneficios que los que '
      'ofrece, pero si estás interesado en adquirir un beneficio que no está en'
      ' la lista, se puede comprar de manera individual.';
  static const String buyCombosBrief =
      'Comprar beneficios en combo te asegura un descuento sobre el precio de '
      'cada beneficio. Descubre más descuentos al cotizar.';
  static const comboBenefits = 'Beneficios de este combo:';
  static const viewThisBenefit = 'Ver este beneficio';
  static const viewThisCombo = 'Ver este combo';
  static const viewThisLevel = 'Ver este nivel';
  static const currrentComboDiscount = 'Descuento en este combo';
  static const String unexpectedErrorStore =
      'Ocurrió un error inesperado, intenta nuevamente.';
  static const String quoteGenerated = 'Generar cotización';
  static const String uniquePay =
      'Pago único. Esta compra beneficia a todos tus protegidos';
  static const String goToPay = 'Ir a pagar';
  static const String cardTotalToPay = 'Total a pagar con el';
  static const String discountWithTax = '% de descuento (IVA incluido)';
  static const String obtainedDiscount = 'Descuento\nobtenido:';
  static const String priceIncludesTaxes = 'Este precio incluye impuestos*';
  static const String priceToBuyBenefit =
      'Tu precio total para comprar el beneficio';
  static const String quoteDate = 'Fecha de cotización';
  static const String yearValidityBenefit =
      'Este beneficio tiene una vigencia de un año a partir de la compra.';
  static const String quoteDetail = 'Detalle de cotización';
  static const String withoutDiscount = 'Sin descuentos';
  static const String discountOf = 'Descuento de';
  static const String withLabel = 'Con';
  static const String tooltipMarketDiscount =
      'El descuento de mercado sale al comparar el precio del producto dentro'
      ' de una membresía PIIX, con el estimado de precio del producto en '
      'canales tradicionales de comercio fuera de PIIX.';
  static const String tooltipVolumeDiscount =
      'El descuento por volumen depende de la cantidad de protegidos en tu '
      'membresía PIIX. Entré más protegidos tengas mayor descuento '
      'generas.';
  static const String tooltipComboDiscount =
      'El descuento de combo es un incentivo monetario que se da por comprar '
      'más de un beneficio en conjunto.';
  static const String marketDiscount = 'Descuento mercado';
  static const String volumeDiscount = 'Descuento volumen';
  static const String comboDiscount = 'Descuento de combo';
  static const String breakdownQuote = 'Desglose de descuentos';
  static const String totalToPay = 'Total a pagar';
  static const String totalDiscount = 'Descuento total';
  static const String totalAmount = 'Monto total';
  static const String summedTotalPremium = 'Suma asegurada';
  static const String priceToBuyCombo = 'Tu precio total para comprar el combo';
  static const String yearValidityCombo =
      'Los beneficios de este combo tienen una vigencia de un año a partir de'
      ' la compra.';
  static const String breakdownBenefits = 'Desglose de beneficios';
  static const String events = 'Evento';
  static const String outComboPrice = 'Precio fuera de combo';
  static const String analizingMembershipInfo = 'Estamos analizando la \n'
      'información de tu membresía...';
  static const String couldNotBeLoadedMembershipInfo =
      'No se ha podido cargar la información de tu membresía';
  static const String calculatingDiscounts = 'Hemos comenzado a calcular tus \n'
      'descuentos...';
  static const String generatingQuotation = 'Estamos creando tu cotización \n'
      'personalizada...';
  static const String emptyErrorQuotation =
      'No se ha podido cargar tu cotización, intenta nuevamente refrescando';
  static const String additionalBenefitPerSupplierHasBenefitForm =
      'Para solicitar este beficio se necesita llenar un formulario al '
      'finalizar la compra.';
  static const String someAdditionalBenefitInComboHasBenefitForm =
      'Uno o algunos beneficios de este combo requieren llenar un formulario '
      'para ser solicitados después de la compra.';
  static const String createYourQuotation = 'Crea tu cotización';
  static const String createQuotationInFourSteps =
      'Crea tu cotización en 4 \nsencillos pasos';
  static const String verifyMaxProtected =
      'Verifica el número máximo de protegidos que puedes agregar.';
  static const String addProtectedInOption =
      'Agrega los protegidos en cada una de las opciones.';
  static const String searchProtected =
      'Si deseas incluir otros protegidos que no sean los más usados, búscalo '
      'en “Seleccionar protegidos” te saldrán los disponibles según tu '
      'paquete.';
  static const String whenFinishClickQuote = 'Una vez hayas terminado de '
      'agregar los protegidos deseados, da clic en cotizar para continuar, no '
      'tienes que llenar todos.';
  static const String protectedInfoAfterBuy =
      'La información personal del protegido la podrás agregar después de '
      'adquirir los planes desde la sección de protegidos.';
  static const String understoodLabel = 'Entendido';
  static const String configureYourProtected =
      'Configura tu plan, selecciona los protegidos que quieras agregar según '
      'tu membresía.';
  static const String startAddingProtectedToQuotation =
      'Comienza a agregar protegidos para cotizar';
  static const String quoteLabel = 'Cotizar';
  static const String notPlansToQuotation =
      'Actualmente no se encuentran planes disponibles para ver y cotizar';
  static const String extendsToCoverage =
      'Extiende tu cobertura a los que más quieres, con los mejores descuentos';
  static const String rememberRenewCoverage =
      'Recuerda:\nLos protegidos agregados tienen cobertura por un año y '
      'siempre puedes renovarla.';
  static const String limitLabel = 'Límite';
  static const String maxProtectedNumber = 'Número máximo de protegidos';
  static const String maxAge = 'Edad máxima';
  static const String yearLabel = 'años';
  static const String addProtected = 'Agregar protegido';
  static const String loseQuotation =
      'Al presionar "Aceptar" perderás el progreso de tu cotización';
  static const String alwaysCanQuote = 'Siempre puedes volver a cotizar';
  static String alwaysCanAdd = 'Recuerda que siempre puedes volver a agregarlo '
      'seleccionando la opción';
  static const String quotationPlanError =
      'Ha ocurrido un error y no se ha podido \ncotizar tu configuración'
      ', intenta nuevamente.';
  static const String yearValidityPlan =
      'La cobertura de los protegidos que se \nagreguen tiene una vigencia de '
      'un año a \npartir de la compra.';
  static const String protectedUniquePay =
      'Pago único. Entre más protegidos agregues, más descuentos tienes';
  static const String breakdownProtected = 'Desglose de protegidos';
  static const String totalPriceToAdd = 'El precio total por agregar a';
  static const String numberProtectedToAdd = 'Número de protegidos a agregar';
  static const String sureToExitQuotation =
      '¿Estás seguro de abandonar \nesta cotización?';
  static const String pressAcceptDeleteQuotation =
      'Al presionar “Aceptar” se eliminará tu \ncotización y deberás volver a '
      '\ngenerarla. Te recomendamos \ngenerar tu línea de captura para que \n'
      'guardes la información de tu \ncotización.';
  static const String levels = 'Niveles';
  static const String notLevelsToQuotation =
      'Actualmente no se encuentran niveles disponible para ver y cotizar.';
  static const String levelTooltipText =
      'Un nivel es un paso más para mejorar tu membresía Piix con nuevos '
      'beneficios exclusivos, mayor cantidad de eventos en asistencias y mayor'
      ' suma asegurada en caso de algún percance.';
  static const String eventLabel = 'Evento';
  static const String eventDescription =
      'La cantidad de veces que se puede usar un beneficio.';
  static const String summedTotalDescription =
      'La cantidad máxima que puede cubrir el seguro ante un siniestro o '
      'situación donde se solicite.';
  static const String benefitsOfMembership = 'Beneficios de tu membresía';
  static const String currentLevel = 'Nivel actual: ';
  static const String newCoverageApplyToProtected =
      'La nueva cobertura adquirida aplica a todos tus protegidos';
  static const String newBenefits = 'Beneficios nuevos';
  static const String eachLevelOfferBenefit =
      'Cada nivel te ofrece beneficios nuevos que al adquirirlos en conjunto '
      'puedes obtener mayor descuento.';
  static const String benefitsWithBetterCoverage =
      'Beneficios con cobertura mejorada';
  static const String levelUpLabel =
      'Subir de nivel permite que aumentes la cantidad de eventos de un '
      'servicio o asistencia que ya tengas, o bien, la suma asegurada de un '
      'seguro.';
  static const String discoverBenefitsofLevel =
      'Descubre el costo de acceder a \nmejores beneficios con este nivel';
  static const String knowTheCoverage =
      'Para conocer la cobertura da clic en el botón "Cotiza sin compromiso"';
  static const String improveCurrentBenefits =
      'Mejora la cobertura de tus beneficios actuales y obtén acceso '
      'a nuevos beneficios respecto a tu membresía actual, con '
      'descuentos exclusivos.';
  static const String benefitAndCobenefits = 'Beneficios y cobeneficios';
  static const String currentCoverage = 'Cobertura del nivel actual';
  static const String currentLevelCoverage = 'Cobertura nivel actual';
  static const String coverageType = 'Tipo de cobertura';
  static const String coverageValue = 'Valor de cobertura';
  static const String quotationLabel = 'Cotización';
  static const String priceToBuyLevel = 'Tu precio total para comprar el nivel';
  static const String yearValidityLevel =
      'La cobertura de este nivel tiene una \nvigencia de un año a partir de '
      'su activación.';
  static const String newBenefitsReverse = 'Nuevos beneficios';
  static const String breakdownNewBenefits = 'Desglose de nuevos beneficios';
  static const String viewEnhancedCoverage = 'Ver cobertura mejorada';
  static const String viewEnhancedBenefits =
      'Aquí puedes ver tus beneficios mejorados';
  static const String instructionEnhancedCoverageDialog =
      'En esta sección se muestran los beneficios y cobeneficios que tienes '
      'actualmente, con la cobertura de cada beneficio y la cobertura que '
      'tendrías al adquirir este nivel.';
  static const String currentLevelIs = 'Tu nivel actual es';
  static const String quotationLevelIs = 'El nivel cotizado es';
  static const String meaningColors = 'Significado de colores';
  static const String quotedLevelBenefit =
      'Beneficio adquirido en la tienda virtual.';
  static const String includedBenefitInMembership =
      'Beneficio incluido en tu nivel actual.';
  static const String levelCoverage = 'Cobertura del nuevo nivel';
  static const String hasCobenefits = 'Contiene cobeneficios';
  static const String youSureToExit = '¿Estás seguro de que deseas salir?';
  static const String looseYoureProgress = 'Al presionar “Aceptar” se perderá '
      'el proceso realizado. \nTe recomendamos terminar para crear tu línea de '
      'captura.';
  static const String choosePaymentMethod =
      'Elige uno de los métodos de pago en efectivo que tenemos para tí.';
  static const String afterChoosingPaymentMethod =
      'Después de seleccionar el método de pago deseado, podrás ver las '
      'sucursales sugeridas a las que puedes ir a pagar.';
  static const String finallyChoosingPaymentMethod =
      'Finalmente presiona “Generar linea de captura” para poder ir a pagar al'
      ' lugar de acuerdo al método de pago seleccionado.';
  static const String enjoyAcquiredBenefits =
      '¡Disfruta de los beneficios adquiridos!';
  static const String buyNowToUpgrade =
      '¡Compra ahora para mejorar tu cobertura y las de tus protegidos!';
  static const String emptyPaymentMethods =
      'No se han podido cargar los métodos de pago, intenta nuevamente '
      'refrescando';
  static const String refreshLabel = 'Refrescar';
  static const String selectPaymentMethod = 'Selecciona el método de pago';
  static const String seeOfficesToPay =
      'Al seleccionar, podrás ver las sucursales en las que puedes ir a pagar';
  static const String telecomm = 'Telecomm';
  static const String sevenEleven = '7-Eleven';
  static const String circleK = 'Circle K';
  static const String soriana = 'Soriana';
  static const String extraSuper = 'Extra';
  static const String calimax = 'Calimax';
  static const String farmaciaDelAhorro = 'Farmacia del ahorro';
  static const String casaLey = 'Casa Ley';
  static const String backedUp = 'Respaldado por';
  static const String payEasyWithPaymentLine =
      'Paga fácil con tu línea de captura';
  static const String receiptExitDialogText =
      'Las líneas de captura que has emitido las encuentras dentro de tu'
      'perfil, en la sección ';
  static const String purchaseHistory = 'Historial de compras';
  static const String rememberLabelEllipsis = 'Recuerda...';
  static const String generatedPurchaseTicket =
      'Has generado un ticket de compra';
  static const String detailsInRecord =
      'Encuentra los detalles en tu perfil en la sección de Historial de '
      'compras.';
  static const String notInfoInReceipt =
      'Actualmente no se encuentra información para tu recibo de compra';
  //Product Type Labels
  static const String benefitLabel = 'Beneficio';
  static const String comboLabel = 'Combo';
  static const String planLabel = 'Plan';
  static const String levelLabel = 'Nivel';
  //
  static const String emissionDate = 'Fecha de emisión';
  static const String includedProtected = 'Protegidos incluidos';
  static const String cashPayment = 'Total a pagar en efectivo';
  static const String validityOfPaymentLineLabel =
      'Está línea de captura tiene una vigencia de ';
  static const String validityOfReferenceLabel =
      'Está referencia tiene una vigencia de ';
  static const String validityOfReceiptPayment = '5 días (120hrs)';
  static const String availableUntil = 'Disponible hasta';
  static const String cashToPayment =
      'Paga en efectivo en cualquier \nsucursal de:';
  static const String findPaymentLines =
      'Encuentra tus líneas de captura dentro \nde tu perfil en '
      'Historial de compras.';
  static const String download = 'Descargar';
  static const String paymentLineError =
      'Ha ocurrido un error y no se ha podido generar la linea de captura. '
      'Intenta nuevamente.';
  static const String badRequestAlert =
      'La cotización que intenta generar ya fue generada, favor de volver a '
      'cotizar';

  static const String stepThreeToMakePayment = 'Indica en caja que quieres '
      'realizar un pago de Mercado Pago';
  static const String stepFourToMakePayment =
      'Escanea el código o dicta al cajero el número de referencia de esta '
      'línea de captura para que se teclee directamente en la pantalla de '
      'venta.';
  static const String stepFiveToMakePayment =
      'Realiza el pago correspondiente con dinero en efectivo.';
  static const String stepSixToMakePayment =
      'Al confirmar tu pago, el cajero te entregará un comprobante para validar'
      ' que se realizó correctamente el pago. Conserva el comprobante.';
  static const String stepSevenToMakePayment = 'Una vez realizado el pago, este'
      ' será procesado y aplicado en un plazo no menor a 5 días hábiles.';
  static const String howToMakeAPayment = 'Cómo realizar el pago';
  static const String paymentLineSaved =
      'Línea de captura guardada en tu galería de fotos.';
  static const String goToAnyOxxo = 'Acude a la tienda Oxxo más cercana.';
  static const String goToConvenienceStores =
      'Acude a una de las tiendas de conveniencia mencionadas.';
  static const String goToBanksOrStores =
      'Acude a uno de los bancos o tiendas de conveniencia mencionadas.';
  static const String goToSantander =
      'Acude a la sucursal de banco Santander más cercana.';
  static const String shoppingInStore = 'Compras en tienda';
  static const String shoppingHistory = 'Historial de compras';
  static const String viewTicket = 'Ver ticket';

  static const String purchaseInvoiceInstruction =
      'Aquí encontrarás las compras que has realizado con nosotros, cada una '
      'contiene un ticket donde podrás ver el detalle.';
  static const String ticketIsDocument =
      'es un documento que puedes usar como comprobante de pago. Contiene '
      'información del titular, detalle del producto, vigencia de éste y el '
      'estatus de pago, así como la línea de captura para realizar el pago si '
      'aún no lo has realizado.';
  static const String purchaseTicket = 'Ticket de compra';
  static const String the = 'El';
  static const String inActivation = 'Por activar';

  static const String viewAllTheProducts = 'Ver todos los productos';
  static const String upgradeYourMembership =
      'Mejora tu membresía comprando en nuestra\n tienda virtual';
  static const String benefitSlogan = '¡Cotiza y aprovecha los descuentos!';
  static const String comboSlogan = '¡Cotiza y comprueba la diferencia!';
  static const String discoverSpecialOffers =
      '¡Descubre tus ofertas especiales!';
  static const String addToProtecteds = 'Agrega a tus seres queridos';
  static const String upgradeMembershipLabel = 'Mejora tu membresía';
  static const String exploreOurComboOffers = 'Explora las ofertas de combo';
  static const String exploreBenefits = 'Explora los beneficios';
  static const String addProtectedButton = 'Agrega protegidos';
  static const String knowLevels = 'Conocer niveles';
  static const String seeCombos = 'Ver combos';
  static const String firstWordBenefits = 'Agrega ';
  static const String firstWordPlans = '!Cambia ';
  static const String firstWordLevels = 'Incrementa ';
  static const String firstWordCombo = 'Mayor protección. Encuentra ';
  static const String typeOfBenefitLabel = 'seguros, asistencias y servicios ';
  static const String benefitsResume = 'para tener una cobertura más amplia en '
      'caso de cualquier incidente. Conoce todo lo que PIIX tiene para ti.';
  static const String plansResume = 'de plan dentro de PIIX! Nos adaptamos al '
      'crecimiento, entre más personas proteges, accedes a mejores precios.';
  static const String levelsResume =
      'la suma asegurada o eventos de tus beneficios actuales y accede a los '
      'nuevos beneficios que vienen dentro del nivel.';
  static const String comboResume =
      'descuentos insuperables en estos conjuntos de beneficios, para mejorar '
      'tu bienestar y el de tus seres queridos.';
  static const String simultaneousBenefit =
      'Cuentas con beneficios que alguno(s) de tus protegidos no tiene.';
  static const String anyProtectedNoBenefit =
      'Alguno(s) de tus protegidos no tienen este beneficio';
  static const String pendingInvoices =
      'Tienes una linea de captura pendiente de pago para este producto.';
  static const String quoteAndPendingInvoice =
      'Ya cotizaste este beneficio y tienes una\n línea de captura pendiente de '
      'pago';
  static const String haveThisBenefitButYourProtectedNo =
      'Ya cuentas con este beneficio, pero alguno(s) de tus protegidos no lo '
      'tiene.';
  static const String haveThisLevelButAnyProtectedNoBanner =
      'Ya cuentas con este nivel, pero alguno de tus protegidos no.';
  static const String haveThisLevelButAnyProtectedNo =
      'Alguno(s) de tus protegidos no tienen este nivel';
  static const String supplierPlural = 'Proveedores';
  static const String simultaneousCombo =
      'Cuentas con combos que alguno(s) de tus protegidos no tiene.';
  static const String haveThisComboButYourProtectedNo =
      'Ya cuentas con este combo, pero alguno(s) de tus protegidos no lo '
      'tiene.';
  static const String anyProtectedNoCombo =
      'Alguno(s) de tus protegidos no tienen este combo';
  static const String quoteAndPendingComboInvoice =
      'Ya cotizaste este combo y tienes una\n línea de captura pendiente de '
      'pago';
  static const String alreadyBenefitsInCombo =
      'Ya cuentas con uno o más beneficios de esta lista, éstos están marcados'
      ' con verde y se descontarán de tu cotización';
  static const String alreadyBenefitsInLevel =
      'Uno o algunos beneficios de este combo requieren llenar un formulario '
      'para ser solicitados después de la compra.';
  static const String quantityInMXN =
      'Las cantidades que se muestran en la tabla con el signo de “\$” están '
      'expresadas en pesos mexicanos (MXN) y corresponden a la suma asegurada '
      'de cada beneficio.';
  static const String youHaveAQuestion =
      '¿Tienes algún problema? Ve que puedes hacer';
  static const String frequentQuestions = 'Preguntas Frecuentes';
  static const String firstFrequentQuestion =
      '1. ¿Qué pasa si ya pagué pero no cambia el estatus del ticket?\n';
  static const String firstFrequentAnswer =
      'En ocasiones los pagos pueden tardar hasta 72 hrs en verse reflejados. '
      'Si ya pasó el tiempo y el estatus sigue igual, comunícate a ';
  static const String secondFrequentQuestion =
      '2. Si quiero hacer una reclamación o aclaración, ¿A dónde puedo acudir?\n';
  static const String secondFrequentAnswer =
      'Comunícate con el encargado del grupo que te proporcionó la membresía, '
      'y compártele el detalle de tu caso. ';
  static const String thirdFrequentQuestion = '3. ¿Puedo cancelar mi compra?\n';
  static const String thirdFrequentAnswer =
      'Si ya pagaste no es posible cancelar la compra o pedir un reembolso. Si '
      'no has pagado, la compra será automáticamente cancelada pasado su tiempo'
      ' de vigencia.';
  static const String fourthFrequentQuestion =
      '4. Si tengo algún problema que no se encuentra aquí, ¿Qué puedo hacer?\n';
  static const String fourtFrequentAnswer =
      'Puedes contactarte con el siguiente correo';
  static const String fourtFrequentAnswerTwo = ' y comunicar tu situación.';
  static const String mailContact = 'contacto@piixapp.com';
  static const String aditionalsLabel = 'adicionales';

  static const String oneYearAfterActivate =
      'Una vez activo tendrá vigencia de 1 año';
  static const String dateAndPay = 'Fecha y Pago';
  static const String cancelTicket = 'Cancelar ticket';
  static const String purchaseDetail = 'Detalle de compra';
  static const String personProtected = 'Personas protegidas';
  static const String improvedLabel = 'Se mejora';
  static const String joinedLabel = 'Se agrega';
  static const String detailOff = 'Detalle de';
  static const String limitProtectedReached =
      'Has alcanzado el número máximo de protegidos';
  static const String loadingBenefitDetail = 'Cargando detalle de beneficio...';
  static const String loadingComboDetail = 'Cargando detalle de combo...';
  static const String coveragePeople = 'Personas cubiertas';
  static const String howToPay = 'Cómo realizar el pago';
  static const String stepOneHowToPay =
      'Genera tu línea de captura. Te recomendamos tomar una captura de '
      'pantalla de ella para tenerla a la mano al momento del pago.';
  static const String stepTwoHowToPay =
      'Asiste a alguna de las sucursales de  la cadena que elegiste para '
      'realizar tu pago.';
  static const String stepThreeHowToPay = 'Realiza el pago en efectivo';
  static const String stepFourHowToPay = 'Una vez realizado el pago, conserva'
      ' tu comprobante. El producto se activará en la fecha que indica la '
      'vigencia.';
  static const String updatePay =
      'El pago puede tardar hasta 72 hrs en verse reflejado.';
  static const ratesChanged =
      'Estas tarifas podrían cambiar en futuras compras';
  static const includedBenefits = 'Beneficios incluidos:';
  static const planTicketDetail =
      'Los beneficios, combos y niveles que tienes se extienden a cubrir '
      'también a los protegidos agregados:';
  static const newCoverageApplyForAll =
      'La nueva cobertura adquirida aplica para tí y todos tus protegidos.';
  static const improvedLevelBenefitsTicket = 'Beneficios mejorados:';
  static const breakDownLevel = 'Desglose de beneficios';
  static const navigateToMembershipTitle =
      'Se te llevará a la sección de Membresía, ¿deseas continuar?';
  static const navigateToMembershipSubTitle =
      'Al presionar “Aceptar”, saldrás de esta sección y se te llevará a la '
      'sección de tu Membresía.';
  static const navigateToQuotationTitle =
      'Se te llevará a la sección de cotización, ¿deseas continuar?';
  static const navigateToQuotationSubTitle =
      'Al presionar “Aceptar” saldrás de esta sección y se cargará la '
      'cotización de este producto para generar una línea de captura.';
  static const ticketNotFound =
      '''Ya no existe el beneficio que estás buscando, se eliminó de la tienda.
 
Es posible que tengamos alguno similar o que próximamente se ofrezca de nuevo. 

Te recomendamos estar al pendiente de nuestras ofertas.''';
  static const areYouSureToCancelInvoice =
      '¿Estas seguro de cancelar este ticket de compra?';
  static const pressOkCancelInvoice =
      'Al presionar “Aceptar”, se cancelará el ticket de compra.';
  static const buyingTips = 'Consejos de compra';
  static const weDetectedSomething = 'Hemos detectado algo...';
  static const buyBothTipOne = 'Si te interesan ambos productos ';
  static const buyBothTipTwo =
      'comprando el combo adquieres los dos y con un mayor descuento en el beneficio. ';
  static const buySeparateTipOne = 'O si quieres comprar por separado ';
  static const buySeparateTipTwo =
      'te recomendamos hacer primero el pago del beneficio y después volver a '
      'cotizar el combo para que se te descuente dicho beneficio.';
  static const planDuplicateOne =
      'Tienes beneficio(s), combo(s) o nivel(es) pendiente de pago en el ';
  static const planDuplicateTwo =
      ' y el plan que estás cotizando sólo contempla los productos que están '
      'pagados y activos.';
  static const buyPlanTipOne = 'Te recomendamos adquirir el plan ';
  static const buyPlanTipTwo =
      'y posteriormente  cotizar el beneficio faltante para los protegidos que '
      'agregues porque esto te generará mayor descuento por volumen.';
  static const buyAllCoverageTipOne =
      'O si te interesa tener toda la cobertura para tus protegidos ';
  static const buyAllCoverageTipTwo =
      'puedes pagar primero el producto pendiente y volver a cotizar el plan.';
  static const quoteAnyway = 'Cotizar de todas formas';
  static const alreadyPaymentLineTip =
      'Ya tienes una línea de captura generada para este producto. Revísala en '
      'tu ';
  static const ifYouInterested =
      ' y si estás interesado te recomendamos pagarla antes de que expire.';

  //=======STORE RICH TEXT
  static String removePlan(String planName) => 'Vas a remover '
      '"${planName}" de tu cotización, ¿Deseas continuar?';
  static String acceptRemovePlan(String planName) =>
      'Al presionar "Aceptar" se removerá el protegido '
      '"${planName}" de tu cotización.';
  static String successfulRemovePlan(String name) =>
      'Se removió "$name" exitosamente';
  static String applyDiscountInTotal(String discount) =>
      'Con un descuento aplicado del $discount%, \n en tu monto total a pagar.';
  static String anyOxxoStore(String oxxo) =>
      'Cualquier ${oxxo} de la república';
  static String includedDiscount(String discount) =>
      'con ${discount}% de descuento incluido';
  static String protectedTooltipMessage(
      int protectedNumber, bool includesMainUser) {
    if (protectedNumber == 0) return 'Esta compra cubre sólo al titular';
    final _includesTitular = includesMainUser ? 'y al titular' : '';
    return 'Esta compra cubre a $protectedNumber '
        'protegido${protectedNumber.pluralWithS} $_includesTitular';
  }

  static String stepOneToMakePayment(String time) =>
      'Tienes $time para realizar el pago, de lo contrario se '
      'cancelará esta orden y deberás hacer una nueva. Toma en cuenta que los '
      'precios y los productos pueden cambiar.';
  static String benefitDuplicate(
          {required String productName, required String duplicateIn}) =>
      'El producto “$productName" también lo encuentras en el producto '
      '“$duplicateIn" recientemente cotizado '
      'y que está pendiente de pago en el ';
  static String comboDuplicate(
          {required String productName, required String duplicateIn}) =>
      'El producto que estas cotizando: “$productName" contiene el producto'
      ' “$duplicateIn" que recientemente cotizaste '
      'y que está pendiente de pago en el ';
  //TODO: Add missing cases combo with combo, benefit with benefit, combo with benefit, benefit with combo
  //TODO: Add missing cases combo with level, level with combo, benefit with level, level with benefit, level with level
  //Benefit Form Screen Alert messages
  static const formNotFound =
      'El formulario que se esta intentando acceder no fue encontrado.';
  static const formNotRetrieved =
      'No se pudo obtener el formulario, intente nuevamente.';
  static const formSentNoEmailRegistered =
      'Se ha enviado exitosamente el formulario pero al no tener un '
      'correo registrado, no se te puede enviar una copia.';
  static const formSentNoEmailSent =
      'Lo sentimos, el formulario se ha enviado exitosamente pero no se pudo '
      'enviar una copia a tu correo electronico, si necesitas una copia '
      'contactanos a info@piixapp.com';
  static const formSent =
      'Se ha enviado exitosamente el formulario a nuestro sistema y '
      'una copia con las respuestas a tu correo electrónico';

  //Permission messages
  static const permissionRejected = 'El permiso esta denegado';
  static const openAppSettings =
      'Para habilitar el permiso, es necesario abrir '
      'las configuraciones de la app.';
  static const locationServiceDisabled = 'Servicio de ubicación deshabilitado';
  static const locationServiceDenied = 'Permiso de ubicación negado';
  static const locationServiceIsDenied = 'El permiso de ubicación esta negado';
}
