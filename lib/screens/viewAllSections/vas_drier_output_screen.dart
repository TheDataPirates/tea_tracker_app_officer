import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/drying_item.dart';

class VasDrierOutputScreen extends StatefulWidget {
  @override
  _VasDrierOutputScreenState createState() => _VasDrierOutputScreenState();
}

class _VasDrierOutputScreenState extends State<VasDrierOutputScreen> {
  @override
  Widget build(BuildContext context) {
    final drying =
    Provider.of<WitheringLoadingUnloadingRollingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drier Output View'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: drying.dryingItems.length,
                itemBuilder: (ctx, i) => DryingItem(
                  id: drying.dryingItems[i].id,
                  batchNumber: drying.dryingItems[i].batchNumber,
                  dhoolNumber: drying.dryingItems[i].dhoolNumber,
                  time: drying.dryingItems[i].time,
                  drierInWeight: drying.dryingItems[i].drierInWeight,
                  drierOutWeight: drying.dryingItems[i].drierOutWeight,
                ),
              ))
        ],
      ),
    );
  }
}


