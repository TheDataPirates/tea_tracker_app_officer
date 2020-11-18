import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/rolling_item.dart';

class VasRollingScreen extends StatefulWidget {
  @override
  _VasRollingScreenState createState() => _VasRollingScreenState();
}

class _VasRollingScreenState extends State<VasRollingScreen> {
  @override
  Widget build(BuildContext context) {
    final rollingOutput = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rolling Output View'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: rollingOutput.rollingOutputItems.length,
                itemBuilder: (ctx, i) => RollingItem(
                  id: rollingOutput.rollingOutputItems[i].id,
                  batchNumber: rollingOutput.rollingOutputItems[i].batchNumber,
                  rollingTurn: rollingOutput.rollingOutputItems[i].rollingTurn,
                  time: rollingOutput.rollingOutputItems[i].time,
                  rollerNumber: rollingOutput.rollingOutputItems[i].rollerNumber,
                  weightIn: rollingOutput.rollingOutputItems[i].weightIn,
                  weightOut: rollingOutput.rollingOutputItems[i].weightOut,
                ),
              ))
        ],
      ),
    );
  }
}

