import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/tea_collections_provider.dart';

class VasRemeasuringScreen extends StatefulWidget {
  final supplierID;
  final supplierName;

  const VasRemeasuringScreen({Key key, this.supplierID, this.supplierName})
      : super(key: key);

  @override
  _VasRemeasuringScreenState createState() => _VasRemeasuringScreenState();
}

class _VasRemeasuringScreenState extends State<VasRemeasuringScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
    final provider = Provider.of<TeaCollections>(context, listen: false);
    final currentDate = provider.getCurrentDate();
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Remeasuring View'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image : VASBackgroundImage,
            gradient: kUIGradient
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
              child: const Text('Got no Remeasured Lots!', style: kEmptyViewText,),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
