import 'package:piix_mobile/utils/repositories/iip_repository.dart';
import 'package:piix_mobile/utils/utils_barrel_file.dart';

final class IPRepository with RepositoryAuxiliaries implements IIPRepository {
  @override
  Future<String> getIPAddress() async {
    const path = 'https://api.ipify.org';
    final response = await dio.get(path);
    return response.data;
  }
}
