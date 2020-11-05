import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_starting__finishing_provider.dart';
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
              Navigator.of(context).pushNamed('MainMenu');
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<WitheringStartingFinishingProvider>(context,
                listen: false)
            .fetchAndSetWitheringStartingItem(token),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<WitheringStartingFinishingProvider>(
                child: Center(
                  child: const Text(
                      'Got no Withering starting items found yet, start adding some!'),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('WitheringStarting');
        },
        backgroundColor: Colors.green,
      ),
    );
  }
}
