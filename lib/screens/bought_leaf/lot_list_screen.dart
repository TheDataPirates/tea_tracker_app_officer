import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import 'list_tile_lot_screen.dart';
import 'package:teatrackerappofficer/constants.dart';

class LotListScreen extends StatefulWidget {
  final supplierID;
  final supplierName;

  const LotListScreen({Key key, this.supplierID, this.supplierName})
      : super(key: key);

  @override
  _LotListScreenState createState() => _LotListScreenState();
}

class _LotListScreenState extends State<LotListScreen> {
  Future<void> _showMyDialog(String id, String token) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Your are going to delete the lot'),
                const Text('Would you like to approve of this action?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Accept'),
              onPressed: () async {
                try {
                  await Provider.of<TeaCollections>(context, listen: false)
                      .deleteLot(id, token);

                  Navigator.of(context).pop();
                } catch (error) {
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('AlertDialog'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('An error occurred'),
                              Text('Something went wrong'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            TextButton(
              child: const Text('Decline'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
    final provider = Provider.of<TeaCollections>(context, listen: false);
    final currentDate = provider.getCurrentDate();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'ID: ${provider.newSupplier.supplierId}    NAME: ${provider.newSupplier.supplierName}'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              size: 40,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("TroughLoading");
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image : viewScreenBackgroundImage,
//          gradient: kUIGradient,
        ),
        child: FutureBuilder(
          future: Provider.of<TeaCollections>(context, listen: false)
              .fetchAndSetLotData(widget.supplierID, currentDate,
                  token), //fetching lot details which is deleted 0 & supplierID & Date
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<TeaCollections>(
                  child: Center(
                    child: const Text('Got no lots yet, start adding some!', style: kEmptyViewText,),
                  ),
                  builder: (ctx, teaCollections, ch) => teaCollections
                              .lot_items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          itemCount: teaCollections.lot_items.length,
                          itemBuilder: (ctx, i) => Card(
                            color: Colors.black54,
                            elevation: 10.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.greenAccent.shade700,
                                radius: 30.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: FittedBox(
                                    child: Text(
                                      "${teaCollections.lot_items[i].leaf_grade}",
                                      style: TextStyle(color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${teaCollections.lot_items[i].gross_weight} KG",
                                style: TextStyle(color: Colors.white, fontSize: 50),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Container type : ${teaCollections.lot_items[i].container_type} ->>",
                                    style: TextStyle(color: Colors.white, fontSize: 25),
                                  ),
                                  Text(
                                    "  Units ${teaCollections.lot_items[i].no_of_containers}",
                                    style: TextStyle(color: Colors.white, fontSize: 25),
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                iconSize: 40,
                                color: Colors.redAccent,
                                // deleting displayed lot by pass lot id
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _showMyDialog(
                                      teaCollections.lot_items[i].lotId, token);
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListTileLot(
                                      lotId: teaCollections.lot_items[i].lotId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).accentColor,
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, "InputCollectionScreen");
      //   },
      // ),
    );
  }
}
