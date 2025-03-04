class PaymentModel {
  final int? id;
  String namePayment;
  double value;
  String? userCpf;
  String iconCode;
  String? createdAt;

  PaymentModel({
    this.id,
    required this.namePayment,
    required this.value,
    this.userCpf,
    required this.iconCode,
    this.createdAt,
  });

  @override
  String toString() {
    return 'PaymentModel(id: $id, namePayment: $namePayment, value: $value, userCpf: $userCpf, iconCode: $iconCode, createdAt: $createdAt)';
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      namePayment: json['namePayment'],
      value: double.tryParse(json['value'].toString()) ??
          0.0, // Evita erro se valor não for numérico
      userCpf: json['userCpf'],
      iconCode: json['iconCode'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_payment': namePayment,
      'value': value.toString(),
      'userCpf': userCpf,
      'iconCode': iconCode,
      'createdAt': createdAt.toString(),
    };
  }

  Map<String, dynamic> removeNulls() {
    return {
      if (id != null) 'id': id,
      'namePayment': namePayment,
      'value': value.toString(),
      if (userCpf != null) 'userCpf': userCpf,
      'iconCode': iconCode,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }
}
