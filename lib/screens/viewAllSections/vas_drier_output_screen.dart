import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/drying_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasDrierOutputScreen extends StatefulWidget {
  @override
  _VasDrierOutputScreenState createState() => _VasDrierOutputScreenState();
}

class _VasDrierOutputScreenState extends State<VasDrierOutputScreen> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context, listen: false).token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drier Output View'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image : VASBackgroundImage,
          gradient: kUIGradient,
        ),
        child: FutureBuilder(
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
              .fetchAndSetDryingItem(token),
          builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Consumer<WitheringLoadingUnloadingRollingProvider>(
            child: Center(
              child: const Text(
                  'Got no Drying items!', style: kEmptyViewText,),
            ),
            builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
            WitheringLoadingUnloadingRollingProvider
                .dryingItems.length <=
                0
                ? ch
                : ListView.builder(
              itemCount: WitheringLoadingUnloadingRollingProvider
                  .dryingItems.length,
              itemBuilder: (ctx, i) => DryingItem(
                id: WitheringLoadingUnloadingRollingProvider
                    .dryingItems[i].id,
                batchNumber:
                WitheringLoadingUnloadingRollingProvider
                    .dryingItems[i].batchNumber,
                dhoolNumber:
                WitheringLoadingUnloadingRollingProvider
                    .dryingItems[i].dhoolNumber,
                time: WitheringLoadingUnloadingRollingProvider
                    .dryingItems[i].time,
                drierInWeight:
                WitheringLoadingUnloadingRollingProvider
                    .dryingItems[i].drierInWeight,
                drierOutWeight:
                WitheringLoadingUnloadingRollingProvider
                    .dryingItems[i].drierOutWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
