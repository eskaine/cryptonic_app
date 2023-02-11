import 'package:flutter/material.dart';
import '../../models/displayPanel.model.dart';
import '../../models/inputPanel.model.dart';

class PanelHandler extends StatefulWidget {
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final String inputCurrency;
  final double unitPrice;
  final double amount;
  final void Function(String) inputCurrencyCB;
  final void Function(String) inputPriceCB;
  final MaterialColor textColor;
  final int decimalPlace;
  final int inputDecimalPlace;

  PanelHandler(
      this.currencyCode,
      this.currencyName,
      this.currencySymbol,
      this.inputCurrency,
      this.unitPrice,
      this.amount,
      this.inputCurrencyCB,
      this.inputPriceCB,
      this.textColor,
      this.decimalPlace,
      this.inputDecimalPlace);

  @override
  _PanelHandlerState createState() => _PanelHandlerState();
}

class _PanelHandlerState extends State<PanelHandler> {
  bool isInput = false;
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.requestFocus();
    myFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!myFocusNode.hasFocus) {
      disableInput();
    }
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  void disableInput() {
    setState(() {
      isInput = false;
    });
  }

  void enableInput() {
    myFocusNode.requestFocus();
    widget.inputCurrencyCB(widget.currencyCode);
    setState(() {
      isInput = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          enableInput();
        },
        child: isInput
            ? InputPanel(widget.currencyCode, myFocusNode, widget.inputDecimalPlace, widget.inputPriceCB)
            : DisplayPanel(
                widget.currencyCode,
                widget.currencyName,
                widget.currencySymbol,
                widget.inputCurrency,
                widget.unitPrice,
                widget.amount,
                widget.textColor,
                widget.decimalPlace));
  }
}
