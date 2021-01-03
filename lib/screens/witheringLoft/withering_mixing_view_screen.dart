import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_mixing_item.dart';

class WitheringMixingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Mixing View'),
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
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context, listen: false)
              .fetchAndSetWitheringMixingItem(token),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<WitheringLoadingUnloadingRollingProvider>(
                      child: Center(
                        child: const Text(
                            'Got no Withering mixing items found yet, start adding some!', style: kEmptyViewText,),
                      ),
                      builder: (ctx, WitheringMixingProvider, ch) =>
                          WitheringMixingProvider.witheringMixingItems.length <= 0
                              ? ch
                              : ListView.builder(
                                  itemCount: WitheringMixingProvider
                                      .witheringMixingItems.length,
                                  itemBuilder: (ctx, i) => WitheringMixingItem(
                                    id: WitheringMixingProvider
                                        .witheringMixingItems[i].id,
                                    troughNumber: WitheringMixingProvider
                                        .witheringMixingItems[i].troughNumber,
                                    turn: WitheringMixingProvider
                                        .witheringMixingItems[i].turn,
                                    time: WitheringMixingProvider
                                        .witheringMixingItems[i].time,
                                    temperature: WitheringMixingProvider
                                        .witheringMixingItems[i].temperature,
                                    humidity: WitheringMixingProvider
                                        .witheringMixingItems[i].humidity,
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
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('WitheringMixing');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
