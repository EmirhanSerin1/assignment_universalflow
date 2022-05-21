import 'package:assignment_universalflow/provider/trans_prov.dart';
import 'package:assignment_universalflow/view/widgets/home_widgets/transaction_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("transactions")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      bool showHeader;
                      double totalExc = 0;

                      List allData =
                          Provider.of<TransactionProvider>(context, listen: false).list;

                      if (index == 0) {
                        totalExc = double.parse(allData[0]["amount"]) +
                            double.parse(allData[1]["amount"]);
                        showHeader = true;
                      } else if (index + 1 < snapshot.data!.docs.length &&
                          index != 0) {
                        if (DateFormat("d").format(
                                DateTime.parse(allData[index]["time-stamp"])) ==
                            DateFormat("d").format(DateTime.parse(
                                allData[index - 1]["time-stamp"]))) {
                          showHeader = false;
                        } else {
                          totalExc = double.parse(allData[2]["amount"]) +
                              double.parse(allData[3]["amount"]) +
                              double.parse(allData[4]["amount"]) +
                              double.parse(allData[5]["amount"]);
                          showHeader = true;
                        }
                      } else {
                        showHeader = false;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          showHeader
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 12, right: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('d.MM.yyyy').format(
                                            DateTime.parse(
                                                allData[index]["time-stamp"])),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        (-totalExc).toString(),
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
                          TransactionDetails(
                            amount: (-double.parse(allData[index]["amount"])),
                            cart: allData[index]["cartNumber"],
                            date: DateTime.parse(allData[index]["time-stamp"]),
                            imageUrl: allData[index]["image"],
                            name: allData[index]["name"],
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          );
  }
}