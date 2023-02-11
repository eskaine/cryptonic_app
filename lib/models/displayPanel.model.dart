import 'package:flutter/material.dart';

class DisplayPanel extends StatefulWidget {
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final double unitPrice;
  final double amount;
  final String inputCurrency;
  final MaterialColor textColor;
  final int decimalPlace;

  DisplayPanel(this.currencyCode, this.currencyName, this.currencySymbol,
      this.inputCurrency, this.unitPrice, this.amount, this.textColor, this.decimalPlace);

  @override
  _DisplayPanelState createState() => _DisplayPanelState();
}

class _DisplayPanelState extends State<DisplayPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(5)),
        child: Table(
          children: [
            TableRow(children: [
              TableCell(
                  child: Text(widget.currencyCode,
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold))),
              TableCell(
                  child: Text(
                      widget.currencySymbol +
                          ' ' +
                          (widget.amount * widget.unitPrice).toStringAsFixed(widget.decimalPlace),
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: widget.textColor,
                          fontWeight: FontWeight.bold)))
            ]),
            TableRow(children: [
              TableCell(child: Text(widget.currencyName)),
              TableCell(
                  child: Text(
                '1 ' +
                    widget.inputCurrency +
                    ' = ' +
                    widget.unitPrice.toStringAsFixed(6),
                textAlign: TextAlign.right,
              ))
            ])
          ],
        ));
  }
}
