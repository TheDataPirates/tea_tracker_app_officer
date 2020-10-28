import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';
import 'list_tile_lot_screen.dart';

class LotListScreen extends StatefulWidget {
  final supplierID;
  final supplierName;

  const LotListScreen({Key key, this.supplierID, this.supplierName})
      : super(key: key);

  @override
  _LotListScreenState createState() => _LotListScreenState();
}

class _LotListScreenState extends State<LotListScreen> {
  Future<void> _showMyDialog(String id) async {
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
                      .deleteLot(id);

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
    final currentDate =
        Provider.of<TeaCollections>(context, listen: false).getCurrentDate();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'ID: ${Provider.of<TeaCollections>(context, listen: false).newSupplier.supplierId}    NAME: ${Provider.of<TeaCollections>(context, listen: false).newSupplier.supplierName}'),
        actions: [
          IconButton(
            tooltip: "printing",
            icon: const Icon(
              Icons.print,
              size: 40,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("PrintScreen");
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<TeaCollections>(context, listen: false)
            .fetchAndSetLotData(widget.supplierID,
                currentDate), //fetching lot details which is deleted 0 & supplierID & Date
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<TeaCollections>(
                child: Center(
                  child: const Text('Got no lots yet, start adding some!'),
                ),
                builder: (ctx, teaCollections, ch) => teaCollections
                            .lot_items.length <=
                        0
                    ? ch
                    : ListView.builder(
                        itemCount: teaCollections.lot_items.length,
                        itemBuilder: (ctx, i) => Card(
                          elevation: 10.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: FittedBox(
                                  child: Text(
                                    "${teaCollections.lot_items[i].leaf_grade}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "${teaCollections.lot_items[i].gross_weight} KG",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "Container type : ${teaCollections.lot_items[i].container_type} ->>",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  "  Units ${teaCollections.lot_items[i].no_of_containers}",
                                  style: Theme.of(context).textTheme.headline3,
                                )
                              ],
                            ),
                            trailing: IconButton(
                              iconSize: 50,
                              color: Colors.red,
                              // deleting displayed lot by pass lot id
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _showMyDialog(
                                    teaCollections.lot_items[i].lotId);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "InputCollectionScreen");
        },
      ),
    );
  }
}
