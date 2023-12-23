///This class is used as a response model to map the information of a [FirebaseAssetModel],
/// all the fields are requered, because population whit local data.
class FirebaseAssetModel {
  const FirebaseAssetModel({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;
}
