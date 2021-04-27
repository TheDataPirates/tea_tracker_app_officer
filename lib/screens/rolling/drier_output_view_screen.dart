import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/drying_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class DrierOutputViewScreen extends StatefulWidget {
  @override
  _DrierOutputViewScreenState createState() => _DrierOutputViewScreenState();
}

class _DrierOutputViewScreenState extends State<DrierOutputViewScreen> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context, listen: false).token;
//    final drying =
//        Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drier Output View'),
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
              .fetchAndSetDryingItem(token),
          builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Consumer<WitheringLoadingUnloadingRollingProvider>(
            child: Center(
              child: const Text(
                  'Got no drying items found yet, start adding some!'),
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
      floatingActionButton: Container(
        height: _height * 0.13,
        width: _width * 0.13,
        child: FittedBox(
          child: FloatingActionButton(
            child:  Icon(
              Icons.add,
              color: Colors.white,
              size: _width * 0.06,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('DrierOutput');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
