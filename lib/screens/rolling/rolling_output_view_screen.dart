import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/rolling_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class RollingOutputViewScreen extends StatefulWidget {
  @override
  _RollingOutputViewScreenState createState() => _RollingOutputViewScreenState();
}

class _RollingOutputViewScreenState extends State<RollingOutputViewScreen> {
  @override
  Widget build(BuildContext context) {
//    final rollingOutput = Provider.of<WitheringLoadingUnloadingRollingProvider>(context,listen: false);
    final token = Provider.of<Auth>(context, listen: false).token;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rolling Output View'),
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
                  'Got no rolling items found yet, start adding some!', style: kEmptyViewText,),
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
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white,size: 40.0,),
            onPressed: (){
              Navigator.of(context).pushNamed('RollingRoom');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
