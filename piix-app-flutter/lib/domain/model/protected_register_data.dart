///This class contains all information about protected register request.
class ProtectedRegisterData {
  ProtectedRegisterData({
    required this.packageId,
    required this.names,
    required this.lastNames,
    this.email,
    required this.phoneNumber,
    required this.kinshipId,
    required this.mainUserId,
  });

  String packageId;
  String names;
  String lastNames;
  String? email;
  String phoneNumber;
  String kinshipId;
  String mainUserId;

  factory ProtectedRegisterData.fromJson(Map<String, dynamic> json) =>
      ProtectedRegisterData(
        packageId: json['packageId'],
        names: json['names'],
        lastNames: json['lastNames'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        kinshipId: json['kinshipId'],
        mainUserId: json['mainUserId'],
      );

  Map<String, dynamic> toJson() => {
        'packageId': packageId,
        'names': names,
        'lastNames': lastNames,
        'email': email,
        'phoneNumber': phoneNumber,
        'kinshipId': kinshipId,
        'mainUserId': mainUserId,
      };
}
