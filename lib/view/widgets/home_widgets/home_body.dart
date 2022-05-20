import 'dart:math';

import 'package:assignment_universalflow/model/transaction_model.dart';
import 'package:assignment_universalflow/view/widgets/home_widgets/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeBody extends StatelessWidget {
   HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? prevDay;
    String today = DateFormat("EEE, MMM d, y").format(DateTime.now());
    String yesterday = DateFormat("EEE, MMM d, y")
        .format(DateTime.now().add(Duration(days: -1)));

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Transactions",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),
                      InkWell(onTap: () {}, child: const Icon(Icons.search))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Cashflow this week: ",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      Text(
                        "Good ",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.green),
                      ),
                      Text(
                        "-£250",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                Transaction transaction = transactions[index];
                DateTime date = DateTime.fromMillisecondsSinceEpoch(
                    transaction.createdMillis);
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
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                                left: 16, top: 12, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateString,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  NumberFormat(" £###,###,##").format(2400),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : const Offstage(),
                    TransactionDetails(transaction: transaction),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
List<Transaction> transactions = List.generate(20, (index) {
  bool isRedeem = Random().nextBool();
  String name = isRedeem ? "Redeem PS" : "Awarded Point";
  double amount = 12506;
  return Transaction(
      name: name,
      amount: amount,
      createdMillis: DateTime.now()
          .add(Duration(
            days: -Random().nextInt(7),
            hours: -Random().nextInt(23),
            minutes: -Random().nextInt(59),
          ))
          .millisecondsSinceEpoch);
})
  ..sort((v1, v2) => v2.createdMillis - v1.createdMillis);


}
