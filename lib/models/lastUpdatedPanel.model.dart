import 'package:flutter/material.dart';
import '../constants.dart';

class LastUpdatedPanel extends StatelessWidget {
  final String timerText;
  final String dateText;

  LastUpdatedPanel(this.timerText, this.dateText);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text(this.timerText + '     ' + STATUS_TEXT + this.dateText),
          ],
        ));
  }
}
