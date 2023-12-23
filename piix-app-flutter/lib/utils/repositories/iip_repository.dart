abstract interface class IIPRepository {
  ///Returns the IPv4 address of the device.
  Future<String> getIPAddress();
}
