import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_starting_finishing_item.dart';

class WitheringStartingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Starting View'),
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
              .fetchAndSetWitheringStartingItem(token),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<WitheringLoadingUnloadingRollingProvider>(
                  child: Center(
                    child: const Text(
                        'Got no Withering starting items found yet, start adding some!', style: kEmptyViewText,),
                  ),
                  builder: (ctx, WitheringStartingFinishingProvider, ch) =>
                      WitheringStartingFinishingProvider
                                  .witheringStartingItems.length <=
                              0
                          ? ch
                          : ListView.builder(
                              itemCount: WitheringStartingFinishingProvider
                                  .witheringStartingItems.length,
                              itemBuilder: (ctx, i) =>
                                  WitheringStartingFinishingItem(
                                id: WitheringStartingFinishingProvider
                                    .witheringStartingItems[i].id,
                                troughNumber: WitheringStartingFinishingProvider
                                    .witheringStartingItems[i].troughNumber,
                                time: WitheringStartingFinishingProvider
                                    .witheringStartingItems[i].time,
                                temperature: WitheringStartingFinishingProvider
                                    .witheringStartingItems[i].temperature,
                                humidity: WitheringStartingFinishingProvider
                                    .witheringStartingItems[i].humidity,
                              ),
                            ),
                ),
        ),
      ),
      floatingActionButton: Container(
        height: 90.0,
        width: 90.0,
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 50.0,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('WitheringStarting');
          },
        ),
      ),
    );
  }
}
