import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piix_mobile/html_feature/data/ihtml_repository.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

///Contains all the service calls that handle the 
///html retrieval of information.
final class HtmlRepository
    with RepositoryAuxiliaries
    implements IHtmlRepository {
  @override
  Future<HtmlModel> getTermsAndConditions() async {
    final path = '${appConfig.backendEndpoint}/legal/termsAndConditions';
    final response = await dio.get(path);
    return HtmlModel(htmlText: response.data);
  }
}

//Declare a simple Riverpod Provider that can modify the repository
final htmlRepositoryPod = Provider<IHtmlRepository>((ref) => HtmlRepository());