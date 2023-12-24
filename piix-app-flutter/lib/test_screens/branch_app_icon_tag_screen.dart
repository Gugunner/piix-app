import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/benefit_per_supplier_feature/utils/branch_type_enum.dart';
import 'package:piix_mobile/test_screens/app_tag_screen.dart';

class BranchAppIconTagScreen extends StatelessWidget {
  static const routeName = '/branch_app_icon_tag_screen';

  const BranchAppIconTagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Wrap(
            children: [
              TagContainer(
                child: BranchType.funerary.tag,
              ),
              TagContainer(
                child: BranchType.laboratory.tag,
              ),
              TagContainer(
                child: BranchType.health.tag,
              ),
              TagContainer(
                child: BranchType.automobile.tag,
              ),
              TagContainer(
                child: BranchType.home_veterinary.tag,
              ),
              TagContainer(
                child: BranchType.legal.tag,
              ),
              TagContainer(
                child: BranchType.household.tag,
              ),
              TagContainer(
                child: BranchType.unkown.tag,
              ),
              TagContainer(
                child: BranchType.unkown.tag,
              ),
              TagContainer(
                child: BranchType.entertainment.tag,
              ),
              TagContainer(
                child: BranchType.dentist.tag,
              ),
              TagContainer(
                child: BranchType.robbery.tag,
              ),
              TagContainer(
                child: BranchType.incendiary.tag,
              ),
              TagContainer(
                child: BranchType.earthquake.tag,
              ),
              TagContainer(
                child: BranchType.unkown.tag,
              ),
              TagContainer(
                child: BranchType.transport.tag,
              ),
              TagContainer(
                child: BranchType.tramits.tag,
              ),
              TagContainer(
                child: BranchType.flooding.tag,
              ),
              TagContainer(
                child: BranchType.psychology.tag,
              ),
              TagContainer(
                child: BranchType.nutriology.tag,
              ),
              TagContainer(
                child: BranchType.farm_veterinary.tag,
              ),
              TagContainer(
                child: BranchType.emergency.tag,
              ),
              TagContainer(
                child: BranchType.technology.tag,
              ),
              TagContainer(
                child: BranchType.life.tag,
              ),
              TagContainer(
                child: BranchType.general_assistance.tag,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
