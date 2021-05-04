import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_starting_finishing_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasWitheringStartingScreen extends StatefulWidget {
  @override
  _VasWitheringStartingScreenState createState() => _VasWitheringStartingScreenState();
}

class _VasWitheringStartingScreenState extends State<VasWitheringStartingScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Starting View'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image : VASBackgroundImage,
            gradient: kUIGradient
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
                      'Got no Withering Starting items!',
                      style: kEmptyViewText,
                    ),
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
                                    height: _height,
                                    width: _width,
                              ),
                            ),
                ),
        ),
      ),
    );
  }
}
