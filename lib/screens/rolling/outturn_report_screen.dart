import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/outtturn_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class OutturnReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final out = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outturn Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
//              Navigator.of(context).pushNamed('MainMenu');
              Navigator.popUntil(context, ModalRoute.withName('MainMenu'));
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15.0),
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Day Outturn : ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Chip(
                      label: Text(
                        '${out.totalDayOutturn(DateTime.now()).toStringAsFixed(4)}' +
                            ' %',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      backgroundColor:Colors.greenAccent.shade700,
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
                outturn: out.batchOutturn(
                    out.batchItems[i].batchNumber,
                    DateTime
                        .now()), //A double value of the outturn of a given batch should be calculated and returned when the batch number and date is provided
              ),
            ))
          ],
        ),
      ),
    );
  }
}
