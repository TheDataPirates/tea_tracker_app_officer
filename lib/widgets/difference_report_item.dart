import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';

class DifferenceReportItem extends StatelessWidget {
  final String reportId;
  final double originalWeight;
  final double remeasuringWeight;
  final double weightDifference;
  final String supplierId;
  final double _height;
  final double _width;

  const DifferenceReportItem(
      {Key key,
        @required double height,
        @required double width,
      this.reportId,
      this.originalWeight,
      this.remeasuringWeight,
      this.weightDifference,
      this.supplierId})
      : _height = height,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
//    var timeNow = time.format('H:i,  d/m/Y');

    return Card(
      margin:  EdgeInsets.symmetric(
        horizontal: _width * 0.01,
        vertical: _height * 0.01,
      ),
      color: Colors.black54,
      child: Padding(
        padding: EdgeInsets.all(_width * 0.005),
        child: ListTile(
          leading: Text(
            "Supplier ID : " + supplierId.toString(),
            style: TextStyle(fontSize: _width * 0.025, color: Colors.green),
          ),
          title: Text(
            'Original Weight : ' + '$originalWeight',
            style: TextStyle(
                fontSize: _width * 0.025,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          subtitle: Text(
            'Remeasuring Weight : ' + '$remeasuringWeight',
            style: TextStyle(
                fontSize: _width * 0.025,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          trailing: Column(
            children: [
              Text(
                'Weight Difference : ' + '$weightDifference',
                style: TextStyle(
                    fontSize: _width * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
