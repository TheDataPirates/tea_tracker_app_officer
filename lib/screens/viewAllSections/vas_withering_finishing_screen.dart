import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_starting_finishing_item.dart';

class VasWitheringFinishingScreen extends StatefulWidget {
  @override
  _VasWitheringFinishingScreenState createState() => _VasWitheringFinishingScreenState();
}

class _VasWitheringFinishingScreenState extends State<VasWitheringFinishingScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Finishing View'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image : VASBackgroundImage,
            gradient: kUIGradient
        ),
        child: FutureBuilder(
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
                  listen: false)
              .fetchAndSetWitheringFinishingItem(token),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<WitheringLoadingUnloadingRollingProvider>(
                  child: Center(
                    child: const Text(
                      'Got no Withering finishing items!',
                      style: kEmptyViewText,
                    ),
                  ),
                  builder: (ctx, WitheringStartingFinishingProvider, ch) =>
                      WitheringStartingFinishingProvider
                                  .witheringFinishingItems.length <=
                              0
                          ? ch
                          : ListView.builder(
                              itemCount: WitheringStartingFinishingProvider
                                  .witheringFinishingItems.length,
                              itemBuilder: (ctx, i) =>
                                  WitheringStartingFinishingItem(
                                id: WitheringStartingFinishingProvider
                                    .witheringFinishingItems[i].id,
                                troughNumber: WitheringStartingFinishingProvider
                                    .witheringFinishingItems[i].troughNumber,
                                time: WitheringStartingFinishingProvider
                                    .witheringFinishingItems[i].time,
                                temperature: WitheringStartingFinishingProvider
                                    .witheringFinishingItems[i].temperature,
                                humidity: WitheringStartingFinishingProvider
                                    .witheringFinishingItems[i].humidity,
                              ),
                            ),
                ),
        ),
      ),
    );
  }
}
