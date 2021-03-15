import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/rolling_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasRollingScreen extends StatefulWidget {
  @override
  _VasRollingScreenState createState() => _VasRollingScreenState();
}

class _VasRollingScreenState extends State<VasRollingScreen> {
  @override
  Widget build(BuildContext context) {
//    final rollingOutput = Provider.of<WitheringLoadingUnloadingRollingProvider>(context,listen: false);
    final token = Provider.of<Auth>(context, listen: false).token;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rolling Output View'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image : VASBackgroundImage,
          gradient: kUIGradient,
        ),
        child: FutureBuilder(
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
              .fetchAndSetRollingOutputItem(token),
          builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Consumer<WitheringLoadingUnloadingRollingProvider>(
            child: Center(
              child: const Text(
                  'Got no Rolling items!', style: kEmptyViewText,),
            ),
            builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
            WitheringLoadingUnloadingRollingProvider
                .rollingOutputItems.length <=
                0
                ? ch
                : ListView.builder(
              itemCount: WitheringLoadingUnloadingRollingProvider
                  .rollingOutputItems.length,
              itemBuilder: (ctx, i) => RollingItem(
                id: WitheringLoadingUnloadingRollingProvider
                    .rollingOutputItems[i].id,
                batchNumber:
                WitheringLoadingUnloadingRollingProvider
                    .rollingOutputItems[i].batchNumber,
                rollingTurn:
                WitheringLoadingUnloadingRollingProvider
                    .rollingOutputItems[i].rollingTurn,
                time: WitheringLoadingUnloadingRollingProvider
                    .rollingOutputItems[i].time,
                rollerNumber:
                WitheringLoadingUnloadingRollingProvider
                    .rollingOutputItems[i].rollerNumber,
                weightIn: WitheringLoadingUnloadingRollingProvider
                    .rollingOutputItems[i].weightIn,
                weightOut: WitheringLoadingUnloadingRollingProvider
                    .rollingOutputItems[i].weightOut,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
