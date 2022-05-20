class Transaction {
  String name;
  double amount;
  int createdMillis;

  Transaction(
      {required this.name, required this.amount, required this.createdMillis});
}