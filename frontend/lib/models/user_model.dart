class UserModel {
  String name;
  String email;
  String phone;
  double sale;
  double credit;
  double creditUsed;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.sale,
    required this.credit,
    required this.creditUsed,
  });

  @override
  String toString() {
    return 'PaymentModel(NAME: $name, email: $email, phone: $phone, sale: $sale, credit: $credit, creditUsed: $creditUsed)';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        sale: json['sale'],
        credit: json['credit'],
        creditUsed: json['creditUsed']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'sale': sale,
      'credit': credit,
      'creditUsed': creditUsed,
    };
  }
}
