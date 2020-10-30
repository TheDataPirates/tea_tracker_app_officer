import 'package:flutter/material.dart';
import 'package:teatrackerappofficer/widgets/main_menu_button_container.dart';

class BoughtLeafScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bought Leaf'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: MainMenuFlatButtonContainer(//This button is used because this page should be shown after okaying the receipt. This page should be here as we need to track the supplier id when the lots are put into the troughs and boxes. Because this page is placed here in the begining we select the supp;ier therefore from there we can track the supplier number when lots are put into troughs and boxes.
            height: _height,
            width: _width,
            name: 'Trough Loading',
            destination: 'TroughLoading',
          ),
        ),
      ),
    );
  }
}
