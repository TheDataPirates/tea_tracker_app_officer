import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_loading_unloading_rolling_provider.dart';
import 'package:teatrackerappofficer/widgets/trough_loading_item.dart';

class TroughLoadingViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final troughLoading = Provider.of<WitheringLoadingUnloadingRollingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Trough Loading View'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pushNamed('MainMenu');
            },
            disabledColor: Colors.white,
            iconSize: 35.0,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: troughLoading.troughLoadingItems.length,
            itemBuilder: (ctx, i) => TroughLoadingItem(
              id: troughLoading.troughLoadingItems[i].id,
              troughNumber: troughLoading.troughLoadingItems[i].troughNumber,
              boxNumber: troughLoading.troughLoadingItems[i].boxNumber,
              gradeGL: troughLoading.troughLoadingItems[i].gradeOfGL,
              netWeight: troughLoading.troughLoadingItems[i].netWeight,
            ),
          ))
        ],
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white, size: 40.0,),
            onPressed: (){
              Navigator.of(context).pushNamed('TroughLoading');
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
