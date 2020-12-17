import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer(
      {Key key,
      @required this.mediaQuery,
      @required this.lotData,
      @required this.labelText})
      : super(key: key);

  final Size mediaQuery;
  final lotData;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQuery.width * 0.2,
      height: mediaQuery.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.greenAccent.shade700,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.greenAccent.shade700,
        // Theme.of(context).accentColor,
        child: Column(
//          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: TextStyle(color: Colors.white, fontSize: 25),
              // Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              lotData != null ? '$lotData' : "Empty",
              style: TextStyle(color: Colors.white, fontSize: 28),
              // Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
