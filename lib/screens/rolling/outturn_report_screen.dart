import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/outtturn_item.dart';

class OutturnReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final out = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Outturn Report'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: (){
              Navigator.of(context).pushNamed('MainMenu');
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Day Outturn : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Chip(
                    label: Text(
                      '${out.totalDayOutturn(DateTime.now())}' +
                          ' %', style: TextStyle(fontSize: 20.0, color: Colors.white),),

                    backgroundColor: Theme.of(context).primaryColor,

                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: out.batchItems.length,
                itemBuilder: (ctx, i) => OutturnItem(
                  batchNumber: out.batchItems[i].batchNumber,
                  outturn: out.batchOutturn(out.batchItems[i].batchNumber, DateTime.now()),//A double value of the outturn of a given batch should be calculated and returned when the batch number and date is provided
                ),
              ))
        ],
      ),
    );
  }
}
