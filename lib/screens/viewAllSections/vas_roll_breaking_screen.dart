import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/roll_breaking_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasRollBreakingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rollBreaking = Provider.of<WitheringLoadingUnloadingRollingProvider>(
        context,
        listen: false);
    final token = Provider.of<Auth>(context, listen: false).token;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roll Breaking View'),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: kUIGradient),
        child: FutureBuilder(
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
                  listen: false)
              .fetchAndSetWitheringRollBreakingItem(token),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<WitheringLoadingUnloadingRollingProvider>(
                      child: Center(
                        child: const Text(
                          'Got no roll breaking items!',
                          style: kEmptyViewText,
                        ),
                      ),
                      builder:
                          (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
                              WitheringLoadingUnloadingRollingProvider
                                          .rollBreakingItems.length <=
                                      0
                                  ? ch
                                  : ListView.builder(
                                      itemCount:
                                          WitheringLoadingUnloadingRollingProvider
                                              .rollBreakingItems.length,
                                      itemBuilder: (ctx, i) => RollBreakingItem(
                                        id: WitheringLoadingUnloadingRollingProvider
                                            .rollBreakingItems[i].id,
                                        batchNumber:
                                            WitheringLoadingUnloadingRollingProvider
                                                .rollBreakingItems[i]
                                                .batchNumber,
                                        rollBreakingTurn:
                                            WitheringLoadingUnloadingRollingProvider
                                                .rollBreakingItems[i]
                                                .rollBreakingTurn,
                                        time:
                                            WitheringLoadingUnloadingRollingProvider
                                                .rollBreakingItems[i].time,
                                        rollBreakerNumber:
                                            WitheringLoadingUnloadingRollingProvider
                                                .rollBreakingItems[i]
                                                .rollBreakerNumber,
                                        weight:
                                            WitheringLoadingUnloadingRollingProvider
                                                .rollBreakingItems[i].weight,
                                      ),
                                    ),
                    ),
        ),
      ),
    );
  }
}
