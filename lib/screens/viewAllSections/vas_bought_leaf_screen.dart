import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/trough_loading_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class VasBoughtLeafScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final troughLoading =
        Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trough Loading View'),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: kUIGradient),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: troughLoading.troughLoadingItems.length,
              itemBuilder: (ctx, i) => TroughLoadingItem(
                id: troughLoading.troughLoadingItems[i].id,
                troughNumber: troughLoading.troughLoadingItems[i].troughNumber,
                boxNumber: troughLoading.troughLoadingItems[i].boxNumber,
                gradeGL: troughLoading.troughLoadingItems[i].gradeOfGL,
                recentWeight: troughLoading.troughLoadingItems[i].netWeight,
                netWeight: troughLoading.totalTroughBoxWeight(
                    troughLoading.troughLoadingItems[i].troughNumber,
                    troughLoading.troughLoadingItems[i].boxNumber,
                    DateTime.now()),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
