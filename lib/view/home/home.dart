// import 'package:flutter/material.dart';

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: Colors.white,
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             children: [
//               Container(
//                 color: Colors.red,
//                 height: 70,
//               ),
//               Container(
//                 color: Colors.yellow,
//                 height: 50,
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height - 144,
//                 child: getMenu(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   getMenu() {
//     var dateBefore = 1;
//     var dateAfter = 2;

//     if (dateAfter > dateBefore) {
//       return ListView.builder(
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 60,
//               color: Colors.blue,
//             ),
//           );
//         },
//       );
//     }
//   }
// }

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  String name;
  double point;
  int createdMillis;

  Transaction(
      {required this.name, required this.point, required this.createdMillis});
}

List<Transaction> transactions = List.generate(20, (index) {
  bool isRedeem = Random().nextBool();
  String name = isRedeem ? "Redeem PS" : "Awarded Point";
  double point = isRedeem ? -140000.0 : (Random().nextInt(9) + 1) * 100.0;
  return Transaction(
      name: name,
      point: point,
      createdMillis: DateTime.now()
          .add(Duration(
            days: -Random().nextInt(7),
            hours: -Random().nextInt(23),
            minutes: -Random().nextInt(59),
          ))
          .millisecondsSinceEpoch);
})
  ..sort((v1, v2) => v2.createdMillis - v1.createdMillis);

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        
      ),
      body: buildListView(),
    );
  }

   buildListView() {
    String? prevDay;
    String today = DateFormat("EEE, MMM d, y").format(DateTime.now());
    String yesterday = DateFormat("EEE, MMM d, y")
        .format(DateTime.now().add(Duration(days: -1)));

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.red,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                Transaction transaction = transactions[index];
                DateTime date =
                    DateTime.fromMillisecondsSinceEpoch(transaction.createdMillis);
                String dateString = DateFormat("EEE, MMM d, y").format(date);
          
                if (today == dateString) {
                  dateString = "Today";
                } else if (yesterday == dateString) {
                  dateString = "Yesteday";
                }
          
                bool showHeader = prevDay != dateString;
                prevDay = dateString;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    showHeader
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Text(
                              dateString,
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          )
                        : Offstage(),
                    buildItem(index, context, date, transaction),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(
      int index, BuildContext context, DateTime date, Transaction transaction) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration:  BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(0, 3),
                                blurRadius: 2,
                              )
                            ],
                              shape: BoxShape.circle,
                              image:const DecorationImage(
                                  image: NetworkImage(
                                      "https://randomuser.me/api/portraits/women/44.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                          children: [
                            Text("starbuck"),
                            Text("12:46, Feb 15 2021")
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          
                          child: Text(
                            NumberFormat(" £###,###,###")
                                .format(transaction.point),
                            style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                              color: Colors.red.shade700
                            ),
                          ),
                        ),
                        Text("**** **** **** **34", style: TextStyle(fontSize: 8),)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
