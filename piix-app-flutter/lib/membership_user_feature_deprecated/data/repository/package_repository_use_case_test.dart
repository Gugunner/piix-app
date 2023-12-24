// ignore_for_file: prefer_single_quotes

import "package:piix_mobile/membership_user_feature_deprecated/data/repository/package_repository.dart";

//TODO: Add documentation to extension repository
extension PackageRepositoryUseCaseTest on PackageRepository {
  Future<dynamic> getAllPackagesRequestedTest() async {
    //TODO: Add failed response
    return Future.delayed(const Duration(seconds: 2), () {
      return <String, dynamic>{
        "packages": fakeJsonPackages(),
        "state": ObtainedPackageState.retrieved,
      };
    });
  }

  List<Map<String, dynamic>> fakeJsonPackages() => [
        {
          "packageId": "21e1f38b93f9c2c10adc58b9c1",
          "folio": "21e1f38b93f9c2c10adc58b9c1",
          "name": "GRUPO MEXICO PARA LAS FAMILIAS EMPODERADS"
        },
        {
          "packageId": "21e1f38b93f9c2c10adc58b9c2",
          "folio": "21e1f38b93f9c2c10adc58b9c1",
          "name": "ASOCIACIÓN DE MUJERES EMPRENDEDOREAS"
        },
        {
          "packageId": "21e1f38b93f9c2c10adc58b9c3",
          "folio": "21e1f38b93f9c2c10adc58b9c1",
          "name": "CAMARA DE COMERCIO NACIONAL DE HUTZILUCAN"
        },
        {
          "packageId": "21e1f38b93f9c2c10adc58b9c4",
          "folio": "21e1f38b93f9c2c10adc58b9c1",
          "name": "CONSEJO DE ADULTOS MAYORES CON ALZHEIMER"
        },
      ];
}
