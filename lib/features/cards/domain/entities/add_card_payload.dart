class AddCardPayload {
  final String id;
  final String name;
  final String cardholder;
  final int balance;
  final String color;
  final String owner;

  const AddCardPayload({
    required this.id,
    required this.name,
    required this.cardholder,
    required this.balance,
    required this.color,
    required this.owner,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cardholder': cardholder,
        'balance': balance,
        'color': color,
        'owner': owner,
      };
}
