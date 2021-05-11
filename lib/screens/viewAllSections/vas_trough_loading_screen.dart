import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/ended_loading_trough_box.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/trough_loading_item.dart';
import 'package:teatrackerappofficer/constants.dart';
import 'package:teatrackerappofficer/widgets/trough_loading_item_agent.dart';

class VasTroughLoadingScreen extends StatefulWidget {
  @override
  _VasBoughtLeafScreenState createState() =>
      _VasBoughtLeafScreenState();
}

class _VasBoughtLeafScreenState extends State<VasTroughLoadingScreen> {
  var _endedLoadingTroughBox = EndedLoadingTroughBox(
    id: null,
    troughNumber: null,
    boxNumber: null,
    date: null,
  );

  void _saveEndedLoadingTroughBoxDetails() {
    Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
        listen: false)
        .addEndedLoadingTroughBoxItem(_endedLoadingTroughBox);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trough Loading View'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image : VASBackgroundImage,
          gradient: kUIGradient,
        ),
        child: FutureBuilder(
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
              listen: false)
              .fetchAndSetTroughLoadingItem(token),
          builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Consumer<WitheringLoadingUnloadingRollingProvider>(
            child: Center(
              child: const Text(
                'Got no Trough Loading items!', style: kEmptyViewText,),
            ),
            builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
            WitheringLoadingUnloadingRollingProvider
                .troughLoadingItems.length <=
                0
                ? ch
                : ListView.builder(
              itemCount: WitheringLoadingUnloadingRollingProvider
                  .troughLoadingItems.length,
              itemBuilder: (ctx, i) => WitheringLoadingUnloadingRollingProvider
                  .troughLoadingItems[i].troughNumber==0 ?
              TroughLoadingItemAgent(
                id: WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].id,
                troughNumber:
                WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].troughNumber,
                boxNumber:
                WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].boxNumber,
                gradeGL: WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].gradeOfGL,
                recentWeight:
                WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].netWeight,
//                              netWeight: 10.0,
                netWeight: WitheringLoadingUnloadingRollingProvider
                    .totalTroughBoxWeight(
                    WitheringLoadingUnloadingRollingProvider
                        .troughLoadingItems[i].troughNumber,
                    WitheringLoadingUnloadingRollingProvider
                        .troughLoadingItems[i].boxNumber,
                    DateTime
                        .now()), //A function should be written to todays whole weight of trough number box number
              ):
              TroughLoadingItem(
                id: WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].id,
                troughNumber:
                WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].troughNumber,
                boxNumber:
                WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].boxNumber,
                gradeGL: WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].gradeOfGL,
                recentWeight:
                WitheringLoadingUnloadingRollingProvider
                    .troughLoadingItems[i].netWeight,
                netWeight: WitheringLoadingUnloadingRollingProvider
                    .totalTroughBoxWeight(
                    WitheringLoadingUnloadingRollingProvider
                        .troughLoadingItems[i].troughNumber,
                    WitheringLoadingUnloadingRollingProvider
                        .troughLoadingItems[i].boxNumber,
                    DateTime
                        .now()), //A function should be written to todays whole weight of trough number box number
              ),
            ),
          ),
        ),
      ),
    );
  }
}
