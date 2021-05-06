import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/fermenting_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasFermentingScreen extends StatefulWidget {
  @override
  _VasFermentingScreenState createState() => _VasFermentingScreenState();
}

class _VasFermentingScreenState extends State<VasFermentingScreen> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context, listen: false).token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fermenting View'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image : VASBackgroundImage,
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
                'Got no Fermenting items!', style: kEmptyViewText,),
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
    );
  }
}