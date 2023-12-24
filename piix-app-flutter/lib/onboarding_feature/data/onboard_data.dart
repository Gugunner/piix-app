import 'package:piix_mobile/general_app_feature/utils/constants/piix_assets.dart';
import 'package:piix_mobile/onboarding_feature/domain/onboard_model.dart';

///TODO CHANGE TO FINALS IMAGES AND TEXTS
final List<OnboardPageModel> onboardPages = [
  const OnboardPageModel(
    image: PiixAssets.tip1,
    title: 'Tip 1',
    subtitle: 'Solicita beneficios',
    description: 'Ahora con tu app puedes reportar accidentes o solicitar '
        'servicios de forma rápida y segura.',
  ),
  const OnboardPageModel(
    image: PiixAssets.tip2,
    title: 'Tip 2',
    subtitle: 'Agrega a tus seres queridos',
    description:
        'Extiende los beneficios a tus seres queridos agregándolos a tu '
        'membresía.',
  ),
  const OnboardPageModel(
    image: PiixAssets.tip3,
    title: 'Tip 3',
    subtitle: 'Mejora tu membresía con',
    description:
        'Empieza a mejorar tu membresía, conoce la tienda y descubre las '
        'ofertas que tenemos para ti.',
  ),
];
