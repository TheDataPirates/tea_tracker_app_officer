import 'package:flutter/material.dart';

class TroughLoadingItemAgent extends StatelessWidget {
  final String id;
  final int troughNumber;
  final int boxNumber;
  final String gradeGL;
  final double netWeight;
  final double recentWeight;
  final double _height;
  final double _width;

  TroughLoadingItemAgent(
      {Key key,
      this.id,
      @required double height,
      @required double width,
      this.troughNumber,
      this.boxNumber,
      this.gradeGL,
      this.netWeight,
      this.recentWeight})
      : _height = height,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
//    final _height =
//        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//
//    final _width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: _width * 0.01,
        vertical: _height * 0.01,
      ),
      color: Color(0xff1b5e20).withOpacity(0.7),
      child: Padding(
        padding: EdgeInsets.all(_width * 0.005),
        child: ListTile(
            leading: CircleAvatar(
              child: Text(
                gradeGL,
                style: TextStyle(fontSize: _width * 0.05, color: Colors.white),
              ),
              radius: _width * 0.05,
              backgroundColor: Colors.greenAccent.shade700,
            ),
            title: Text(
              'Trough Number : ' + '$troughNumber',
              style: TextStyle(
                  fontSize: _width * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            subtitle: Text(
              'Box Number : ' + '$boxNumber',
              style: TextStyle(
                  fontSize: _width * 0.0275,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            trailing: Column(
              children: [
                Text(
                  'Recently added : ' + '$recentWeight' + ' Kg',
                  style: TextStyle(
                      fontSize: _width * 0.023,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Total Box Weight : ' + '$netWeight' + ' Kg',
                  style: TextStyle(
                      fontSize: _width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }
}
