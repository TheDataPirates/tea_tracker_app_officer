import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/fermenting_item.dart';

class FermentingViewScreen extends StatelessWidget {
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
      body: FutureBuilder(
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
                      'Got no Withering roll breaking items found yet, start adding some!'),
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
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('FermentingRoom');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
