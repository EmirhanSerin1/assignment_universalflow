class Transaction {
  String name;
  double amount;
  int createdMillis;

  Transaction(
      {required this.name, required this.amount, required this.createdMillis});
  

}

class Trans{
  List<String> names=[
    "Starbucks",
    "Asda",
    "Sold GBP to Bitcoin",
    "Netflix",
    "Bank transfer",
    "Zara",
  ];
  List<double> amounts =[
    5.49,
    18.51,
    149.99,
    9.99,
    -120.00,
    250.00
  ];
  List<DateTime> dates=[
    DateTime.parse('2021-02-15 12:46:00.858895'),
    DateTime.parse('2021-02-15 09:15:04.858895'),
    DateTime.parse('2021-02-14 18:11:04.858895'),
    DateTime.parse('2021-02-14 16:59:04.858895'),
    DateTime.parse('2021-02-14 12:01:04.858895'),
    DateTime.parse('2021-02-14 09:35:04.858895'),
  ];


  List<String> carts = [
    "**************34",
    "**************68",
    "**************68",
    "**************34",
    "**************58",
    "**************68",
  ];

  List<String> images = [
    "assets/starbucks.png",
    "assets/ASDA.png",
    "assets/exh.jpg",
    "assets/netflix.jpg",
    "assets/w.jpg",
    "assets/zara.png",
  ];



}