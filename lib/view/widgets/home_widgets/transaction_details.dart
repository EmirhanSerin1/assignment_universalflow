
import 'package:assignment_universalflow/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 20),
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.8),
                                  offset: const Offset(0, 3),
                                  blurRadius: 2,
                                )
                              ],
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://randomuser.me/api/portraits/women/44.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Starbucks",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontWeight:
                                          FontWeight.w600),
                            ),
                            Text(
                              "12:46, Feb 15 2021",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 10),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      children: [
                        Text(
                          NumberFormat(" £###,###,##")
                              .format(transaction.amount),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Colors.red.shade700),
                        ),
                        const Text(
                          "**** **** **** **34",
                          style: TextStyle(fontSize: 8),
                        )
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
