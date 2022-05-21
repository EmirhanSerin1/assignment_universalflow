import 'package:assignment_universalflow/provider/trans_prov.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List list = Provider.of<TransactionProvider>(context, listen: false).list;
    List datas = Provider.of<TransactionProvider>(context, listen: false).datas;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: const Icon(Icons.arrow_back),
                    onTap: () => Navigator.pop(context),
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      height: 40,
                      width: 250,
                      child: TextFormField(
                        controller: textEditingController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        style: const TextStyle(fontSize: 20),
                        onChanged: (e) {
                          final List<dynamic> lale = list.where((e) {
                            final String name =
                                e["name"].toString().toLowerCase();
                            final String input =
                                textEditingController.text.toLowerCase();
                            return name.contains(input);
                          }).toList();

                          setState(() {
                            Provider.of<TransactionProvider>(context, listen: false).setdata(lale);
                          });
                        },
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                  ),
                  InkWell(
                    child: const Icon(Icons.close),
                    onTap: () {
                      textEditingController.text = "";
                      setState(() {
                        Provider.of<TransactionProvider>(context, listen: false).setdata(list);
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 74,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("transactions")
                    .snapshots()
                    .asBroadcastStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                            datas[index]["image"],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(datas[index]["name"]),
                          subtitle: Text((-double.parse(datas[index]["amount"]))
                              .toString()),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}
