//VasBoughtLeafScreen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/ended_loading_trough_box.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/trough_loading_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasBoughtLeafScreen extends StatefulWidget {
  @override
  _VasBoughtLeafScreenState createState() =>
      _VasBoughtLeafScreenState();
}

class _VasBoughtLeafScreenState extends State<VasBoughtLeafScreen> {
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
//
//    final troughLoading = Provider.of<WitheringLoadingUnloadingRollingProvider>(
//        context,
//        listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trough Loading View'),
      ),
      body: Container(
        decoration: BoxDecoration(
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
                'Got no Trough Loading items found yet, start adding some!', style: kEmptyViewText,),
            ),
            builder: (ctx, WitheringLoadingUnloadingRollingProvider, ch) =>
            WitheringLoadingUnloadingRollingProvider
                .troughLoadingItems.length <=
                0
                ? ch
                : ListView.builder(
              itemCount: WitheringLoadingUnloadingRollingProvider
                  .troughLoadingItems.length,
              itemBuilder: (ctx, i) => TroughLoadingItem(
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
              ),
            ),
          ),
        ),
      ),

//      Column(
//        children: [
//          Expanded(
//              child: ListView.builder(
//            itemCount: troughLoading.troughLoadingItems.length,
//            itemBuilder: (ctx, i) => TroughLoadingItem(
//              id: troughLoading.troughLoadingItems[i].id,
//              troughNumber: troughLoading.troughLoadingItems[i].troughNumber,
//              boxNumber: troughLoading.troughLoadingItems[i].boxNumber,
//              gradeGL: troughLoading.troughLoadingItems[i].gradeOfGL,
//              recentWeight: troughLoading.troughLoadingItems[i].netWeight,
//              netWeight: troughLoading.totalTroughBoxWeight(
//                  troughLoading.troughLoadingItems[i].troughNumber,
//                  troughLoading.troughLoadingItems[i].boxNumber,
//                  DateTime
//                      .now()), //A function should be written to todays whole weight of trough number box number
//            ),
//          ))
//        ],
//      ),

    );
  }
}
