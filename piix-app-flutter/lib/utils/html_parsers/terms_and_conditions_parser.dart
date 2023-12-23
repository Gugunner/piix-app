import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_colors.dart';
import 'package:piix_mobile/utils/theme/theme_barrel_file.dart';

class HtmlTermsAndConditionsParser {
  static final baseTheme = BaseTextTheme();

  static final termsAndConditionsStyle = {
    'h1': Style(
      color: PiixColors.primary,
      fontFamily: baseTheme.displayLarge.fontFamily,
      fontWeight: baseTheme.displayLarge.fontWeight,
      fontStyle: baseTheme.displayLarge.fontStyle,
      fontSize: FontSize(baseTheme.displayLarge.fontSize!),
      lineHeight: LineHeight(baseTheme.displayLarge.height!),
      letterSpacing: baseTheme.displayLarge.letterSpacing,
      textAlign: TextAlign.start,
    ),
    'h2': Style(
      color: PiixColors.primary,
      fontFamily: baseTheme.displayMedium.fontFamily,
      fontWeight: baseTheme.displayMedium.fontWeight,
      fontStyle: baseTheme.displayMedium.fontStyle,
      fontSize: FontSize(baseTheme.displayMedium.fontSize!),
      lineHeight: LineHeight(baseTheme.displayMedium.height!),
      letterSpacing: baseTheme.displayMedium.letterSpacing,
      textAlign: TextAlign.start,
    ),
    'h3': Style(
      color: PiixColors.infoDefault,
      fontFamily: baseTheme.displaySmall.fontFamily,
      fontWeight: baseTheme.displaySmall.fontWeight,
      fontStyle: baseTheme.displaySmall.fontStyle,
      fontSize: FontSize(baseTheme.displaySmall.fontSize!),
      lineHeight: LineHeight(baseTheme.displaySmall.height!),
      letterSpacing: baseTheme.displaySmall.letterSpacing,
      textAlign: TextAlign.start,
    ),
    'h4': Style(
      color: PiixColors.infoDefault,
      fontFamily: baseTheme.headlineLarge.fontFamily,
      fontWeight: baseTheme.headlineLarge.fontWeight,
      fontStyle: baseTheme.headlineLarge.fontStyle,
      fontSize: FontSize(baseTheme.headlineLarge.fontSize!),
      lineHeight: LineHeight(baseTheme.headlineLarge.height!),
      letterSpacing: baseTheme.headlineLarge.letterSpacing,
    ),
    'h5': Style(
      color: PiixColors.infoDefault,
      fontFamily: baseTheme.headlineMedium.fontFamily,
      fontWeight: baseTheme.headlineMedium.fontWeight,
      fontStyle: baseTheme.headlineMedium.fontStyle,
      fontSize: FontSize(baseTheme.headlineMedium.fontSize!),
      lineHeight: LineHeight(baseTheme.headlineMedium.height!),
      letterSpacing: baseTheme.headlineMedium.letterSpacing,
      textAlign: TextAlign.start,
    ),
    'h6': Style(
      color: PiixColors.infoDefault,
      fontFamily: baseTheme.headlineSmall.fontFamily,
      fontWeight: baseTheme.headlineSmall.fontWeight,
      fontStyle: baseTheme.headlineSmall.fontStyle,
      fontSize: FontSize(baseTheme.headlineSmall.fontSize!),
      lineHeight: LineHeight(baseTheme.headlineSmall.height!),
      letterSpacing: baseTheme.headlineSmall.letterSpacing,
      textAlign: TextAlign.start,
    ),
    'ul': Style(
      color: PiixColors.infoDefault,
      fontFamily: baseTheme.titleMedium.fontFamily,
      fontWeight: baseTheme.titleMedium.fontWeight,
      fontStyle: baseTheme.titleMedium.fontStyle,
      fontSize: FontSize(baseTheme.titleMedium.fontSize!),
      lineHeight: LineHeight(baseTheme.titleMedium.height!),
      letterSpacing: baseTheme.titleMedium.letterSpacing,
      textAlign: TextAlign.start,
    ),
    'ol': Style(),
    'li': Style(
      textAlign: TextAlign.start,
      listStylePosition: ListStylePosition.inside,
    ),
    'div': Style(),
    'p': Style(
      color: PiixColors.infoDefault,
      fontFamily: baseTheme.titleMedium.fontFamily,
      fontWeight: baseTheme.titleMedium.fontWeight,
      fontStyle: baseTheme.titleMedium.fontStyle,
      fontSize: FontSize(baseTheme.titleMedium.fontSize!),
      lineHeight: LineHeight(baseTheme.titleMedium.height!),
      letterSpacing: baseTheme.titleMedium.letterSpacing,
      textAlign: TextAlign.start,
    ),
    'b': Style(
      color: PiixColors.infoDefault,
      fontFamily: baseTheme.titleMedium.fontFamily,
      fontWeight: FontWeight.bold,
      fontStyle: baseTheme.titleMedium.fontStyle,
      fontSize: FontSize(baseTheme.titleMedium.fontSize!),
      lineHeight: LineHeight(baseTheme.titleMedium.height!),
      letterSpacing: baseTheme.titleMedium.letterSpacing,
      textAlign: TextAlign.center,
    ),
    'span': Style(),
    'br': Style(),
    'em': Style(
      color: PiixColors.infoDefault,
      fontFamily: baseTheme.titleMedium.fontFamily,
      fontWeight: baseTheme.titleMedium.fontWeight,
      fontStyle: FontStyle.italic,
      fontSize: FontSize(baseTheme.titleMedium.fontSize!),
      lineHeight: LineHeight(baseTheme.titleMedium.height!),
      letterSpacing: baseTheme.titleMedium.letterSpacing,
      textAlign: TextAlign.center,
    ),
  };

//TODO: Delete from App when an api service returns this html string
//TODO: Delete before Piix 4.0 release

  static const termsAndConditionsHtmlTextExample = '''
<h1>Términos y condiciones PIIX</h1>
<h3>Términos y condiciones de acceso y uso de los Servicios de la Plataforma PIIX México.</h3>
<p>Bienvenido a la Plataforma PIIX México, nos da gusto que esté aquí y esperamos que disfrute de todo lo que tenemos para ofrecerle.
A continuación, le presentamos información importante por lo que amablemente le pedimos lea detenidamente los siguientes Términos y Condiciones que rigen el acceso y uso de los servicios promocionados en la Plataforma PIIX México, en adelante “Plataforma”. Usted quien en adelante será llamado “Usuario” acepta y manifiesta su consentimiento de regirse por estos Términos y Condiciones en el momento que confirme su registro en la Plataforma, la cual es administrada por JR Quark Risk Management S.A. de C.V. Recuerde que los términos y condiciones exclusivamente del uso de la plataforma son un acuerdo vinculante entre usted y la Plataforma PIIX México por conducto de JR Quark Risk Management S.A. de C.V.</p>
<p>Es posible que se le solicite que se registre y especifique una contraseña para utilizar los servicios o funciones promocionados en la Plataforma. Para registrarse, debe tener al menos 18 años de edad y debe proporcionar información veraz y precisa sobre usted, no intente hacerse pasar por nadie más cuando se registre en la Plataforma. Si su información cambia en cualquier momento, actualice su cuenta para reflejar esos cambios. Cualquier uso distinto será responsabilidad del titular de la cuenta del Usuario.</p>
<p>No puede compartir su cuenta con nadie más. Por favor, mantenga su contraseña confidencial, y trate de no usarla en otros sitios web. Si cree que su cuenta se ha visto comprometida en algún momento, notifique al Administrador.</p>
<h5>A. DEFINICIONES</h5>
<p>• Administrador. Es JR Quark Risk Management S.A. de C.V., quien está a cargo de la administración de la Plataforma en México.</p>
<p>• Aplicación Móvil. Aplicación Móvil PIIX, programa administrado y gestionado por el Administrador, bajo el nombre comercial de PIIX, descargable por el Usuario y al que puede acceder directamente desde su teléfono celular o cualquier otro dispositivo móvil con acceso a internet en los sistemas operativos android® y ios® o portal web que el Administrador designe parte de la Plataforma.</p>
<p>• Asistencias. Conjunto de contratos de servicios asistenciales que prestan un servicio de indemnización al Usuario, a cambio de un prepago de con el fin de satisfacer determinadas necesidades que se le presenten en diferentes ámbitos, como son: Asistencias personales, Asistencias de salud, Asistencias en el hogar, Asistencias viales, por mencionar algunos. Las indemnizaciones se llevarán a cabo únicamente mediante el otorgamiento de un servicio por parte del Proveedor.</p>
<p>• Compra. La contratación de una o más Asistencias la cual se configura con el pago en línea que realice el Usuario desde la Plataforma.</p>
<p>• Contratante. Es la persona física o persona moral que contrata las Asistencias, y paga las primas de las Asistencias desde la Plataforma.</p>
<p>• Membresía. Al momento que un Usuario se registra en la Plataforma se le creará una cuenta PIIX, denominada Membresía para el uso de la Plataforma.</p>
<p>• Sitio Web. Sitio Web bajo el dominio <em>www.piixapp.com</em>, administrado por el Administrador, el cual es titular de todos los derechos de uso y comercialización en México. En el Sitio Web los Usuarios tendrán información de PIIX.</p>
México. En el Sitio Web los Usuarios tendrán información de PIIX.
<p>• Titular. Usuario registrado en la Plataforma que forma parte de un Grupo.</p>
<p>• Usuario. Persona física o moral que se registre y confirme su perfil en la Plataforma y adquiera alguno de los Beneficios en el Sitio Web o en la Aplicación Móvil.</p>
''';
}
