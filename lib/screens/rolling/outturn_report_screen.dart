import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/outtturn_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class OutturnReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final out = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outturn Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
//              Navigator.of(context).pushNamed('MainMenu');
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.popUntil(context, ModalRoute.withName('MainMenu'));
            },
            disabledColor: Colors.white,
            iconSize: _width * 0.04,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image : reportBackgroundImage,
            gradient: kUIGradient,
        ),
        child: Column(
          children: [
            Card(
              margin:  EdgeInsets.all(_width * 0.0075),
              color:  Colors.black54,
              child: Padding(
                padding:  EdgeInsets.all(_width * 0.005),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'Total Day Outturn : ',
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _width * 0.035,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width:  _width * 0.02,
                    ),
                    Chip(
                      label: Text(
                        '${out.totalDayOutturn(DateTime.now()).toStringAsFixed(4)}' +
                            ' %',
                        style: TextStyle(fontSize: _width * 0.025, color: Colors.white),
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
                height: _height,
                width: _width,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
