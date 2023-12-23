///This class is used as a response model to map the information of a
///[PaymentPlace], all the fields are required, because population with local
/// data.
class PaymentMethodUiModel {
  const PaymentMethodUiModel({required this.name, required this.asset});
  final String name;
  final String asset;
}
