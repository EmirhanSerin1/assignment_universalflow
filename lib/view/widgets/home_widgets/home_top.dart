import 'package:assignment_universalflow/model/transaction_model.dart';
import 'package:assignment_universalflow/view/search/search_view.dart';
import 'package:flutter/material.dart';

class HomeTop extends StatelessWidget {
  const HomeTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Trans trans = Trans();
    return Padding(
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
                InkWell(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage()));}, child: const Icon(Icons.search))
              ],
            ),
            Row(
              children: [
                Text(
                  "Cashflow this week: ",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
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
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                )
              ],
            )
          ],
        ),
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
