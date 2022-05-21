import 'package:assignment_universalflow/model/transaction_model.dart';
import 'package:assignment_universalflow/provider/trans_prov.dart';
import 'package:assignment_universalflow/view/widgets/home_widgets/home_top.dart';
import 'package:assignment_universalflow/view/widgets/home_widgets/transaction_details.dart';
import 'package:assignment_universalflow/view/widgets/home_widgets/transaction_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    //We have to call it here otherwise provider gonna turn []
    getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: const [
          HomeTop(),
          TransactionList(),
        ],
      ),
    );
  }
}

Future<void> getData(BuildContext context) async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('transactions')
      .orderBy("time-stamp", descending: true)
      .get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  Provider.of<Translar>(context, listen: false).setList(allData);
}
