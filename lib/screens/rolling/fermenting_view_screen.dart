import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/fermenting_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class FermentingViewScreen extends StatefulWidget {
  @override
  _FermentingViewScreenState createState() => _FermentingViewScreenState();
}

class _FermentingViewScreenState extends State<FermentingViewScreen> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context, listen: false).token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fermenting View'),
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
          image : viewScreenBackgroundImage,
          gradient: kUIGradient,
        ),
        child: FutureBuilder(
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
                  listen: false)
              .fetchAndSetFermentingItem(token),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<WitheringLoadingUnloadingRollingProvider>(
                  child: Center(
                    child: const Text(
                        'Got no Withering roll breaking items found yet, start adding some!', style: kEmptyViewText,),
                  ),
                  builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
                      WitheringLoadingUnloadingRollingProvider
                                  .fermentingItems.length <=
                              0
                          ? ch
                          : ListView.builder(
                              itemCount: WitheringLoadingUnloadingRollingProvider
                                  .fermentingItems.length,
                              itemBuilder: (ctx, i) => FermentingItem(
                                id: WitheringLoadingUnloadingRollingProvider
                                    .fermentingItems[i].id,
                                batchNumber:
                                    WitheringLoadingUnloadingRollingProvider
                                        .fermentingItems[i].batchNumber,
                                dhoolNumber:
                                    WitheringLoadingUnloadingRollingProvider
                                        .fermentingItems[i].dhoolNumber,
                                time: WitheringLoadingUnloadingRollingProvider
                                    .fermentingItems[i].time,
                                dhoolInWeight:
                                    WitheringLoadingUnloadingRollingProvider
                                        .fermentingItems[i].dhoolInWeight,
                                dhoolOutWeight:
                                    WitheringLoadingUnloadingRollingProvider
                                        .fermentingItems[i].dhoolOutWeight,
                              ),
                            ),
                ),
        ),
      ),
      floatingActionButton: Container(
        height: 90.0,
        width: 90.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 50.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('FermentingRoom');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
