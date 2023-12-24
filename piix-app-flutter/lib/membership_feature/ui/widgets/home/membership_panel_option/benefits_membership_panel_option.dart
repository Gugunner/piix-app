import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';
import 'package:piix_mobile/general_app_feature/utils/constants/piix_icons.dart';
import 'package:piix_mobile/membership_feature/membership_screen_barrel_file.dart';
import 'package:piix_mobile/membership_feature/ui/widgets/home/membership_panel_option/app_membership_panel_option.dart';

class BenefitsMembershipPanelOption extends AppMembershipPanelOption {
  BenefitsMembershipPanelOption({super.key, this.count = 0})
      : assert(count >= 0),
        super(
            text: 'Mis beneficios ($count)',
            icon: PiixIcons.membresias,
            onTap: () {
              //TODO: Change transition to slide in left to right 500ms
              NavigatorKeyState().fadeInRoute(
                page: const MembershipLastGradeBenefitsScreenDeprecated(),
                routeName:
                    MembershipLastGradeBenefitsScreenDeprecated.routeName,
              );
            });

  ///Number of benefits in a membership
  final int count;
}
