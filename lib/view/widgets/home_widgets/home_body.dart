import 'package:assignment_universalflow/model/transaction_model.dart';
import 'package:assignment_universalflow/view/widgets/home_widgets/transaction_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeBody extends StatelessWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Trans trans = Trans();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: SizedBox(
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
                        "-" + getAllSum(trans).toString(),
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("transactions")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: trans.names.length,
                    itemBuilder: (context, index) {
                      bool showHeader;
                      double totalExc = 0;

                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      


                      if (index == 0) {
                        totalExc = trans.amounts[0] + trans.amounts[1];
                        showHeader = true;
                      } else if (index + 1 < trans.dates.length && index != 0) {
                        if (DateFormat("d").format(trans.dates[index]) ==
                            DateFormat("d").format(trans.dates[index - 1])) {
                          showHeader = false;
                        } else {
                          totalExc = trans.amounts[2] +
                              trans.amounts[3] +
                              trans.amounts[4] +
                              trans.amounts[5];
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
                                        DateFormat('d.MM.yyyy')
                                            .format(trans.dates[index]),
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
                            amount: (-trans.amounts[index]),
                            cart: trans.carts[index],
                            date: trans.dates[index],
                            imageUrl: trans.images[index],
                            name: trans.names[index],
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  getAllSum(Trans trans) {
    var sum = 0.0;
    for (double n in trans.amounts) {
      sum += n;
    }

    return sum;
  }
}


// List lale = trans.dates;
//     lale.sort((a, b) {
//       return a.compareTo(b);
//     });