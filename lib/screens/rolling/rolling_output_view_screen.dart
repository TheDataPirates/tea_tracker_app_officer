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
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
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
            iconSize: _width * 0.04,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image : viewScreenBackgroundImage,
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
                  'Got no rolling items found yet, start adding some!'),
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
        height: _height * 0.13,
        width: _width * 0.13,
        child: FittedBox(
          child: FloatingActionButton(
            child:  Icon(Icons.add, color: Colors.white,size: _width * 0.06,),
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
