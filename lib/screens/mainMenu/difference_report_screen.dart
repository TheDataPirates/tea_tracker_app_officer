import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/difference_report_item.dart';
import 'package:teatrackerappofficer/widgets/drying_item.dart';
import 'package:teatrackerappofficer/constants.dart';

class DifferenceReportScreen extends StatefulWidget {
  @override
  _DifferenceReportScreenState createState() => _DifferenceReportScreenState();
}

class _DifferenceReportScreenState extends State<DifferenceReportScreen> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<Auth>(context, listen: false).token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Difference Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
//              Navigator.of(context).pushNamed('MainMenu');
              Navigator.of(context).pop();
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image : reportBackgroundImage,
          gradient: kUIGradient,
        ),
        child: FutureBuilder(
          future: Provider.of<WitheringLoadingUnloadingRollingProvider>(context,
                  listen: false)
              .fetchAndSetDifferenceReportItem(token),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<WitheringLoadingUnloadingRollingProvider>(
                      child: Center(
                        child: const Text('No difference report items.',style: kEmptyViewText,),
                      ),
                      builder: (ctx, WitheringLoadingUnloadingRollingProvider,
                              ch) =>
                          WitheringLoadingUnloadingRollingProvider
                                      .differenceReportItems.length <=
                                  0
                              ? ch
                              : ListView.builder(
                                  itemCount:
                                      WitheringLoadingUnloadingRollingProvider
                                          .differenceReportItems.length,
                                  itemBuilder: (ctx, i) => DifferenceReportItem(
                                    reportId:
                                        WitheringLoadingUnloadingRollingProvider
                                            .differenceReportItems[i].reportId,
                                    originalWeight:
                                        WitheringLoadingUnloadingRollingProvider
                                            .differenceReportItems[i]
                                            .originalWeight,
                                    remeasuringWeight:
                                        WitheringLoadingUnloadingRollingProvider
                                            .differenceReportItems[i]
                                            .remeasuringWeight,
                                    weightDifference:
                                        WitheringLoadingUnloadingRollingProvider
                                            .differenceReportItems[i]
                                            .weightDifference,
                                    supplierId:
                                        WitheringLoadingUnloadingRollingProvider
                                            .differenceReportItems[i]
                                            .supplierId,
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
              Navigator.of(context).pushNamed('DrierOutput');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
