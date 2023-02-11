import 'package:flutter/material.dart';
import "package:flutter/services.dart";

class InputPanel extends StatefulWidget {
  final void Function(String) callback;
  final FocusNode myFocusNode;
  final String currencyCode;
  final int inputDecimalPlace;
  final TextStyle inputStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 21);

  InputPanel(this.currencyCode, this.myFocusNode, this.inputDecimalPlace, this.callback);

  @override
  _InputPanelState createState() => _InputPanelState();
}

class _InputPanelState extends State<InputPanel> {
  int inputLength = 10;


  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
   
    controller.addListener(() {
      if(widget.currencyCode == 'BTC') {
        inputLength = 8;
      }

      widget.callback(controller.text);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TextInputFormatter getInputFormatters(int decimalPlace) {
    return decimalPlace > 0 ? FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,' + decimalPlace.toString() + '}')) : FilteringTextInputFormatter.digitsOnly;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2.5),
            borderRadius: BorderRadius.circular(5)),
        child: TextField(
          maxLength: inputLength,
          style: widget.inputStyle,
          focusNode: widget.myFocusNode,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.numberWithOptions(decimal: (widget.inputDecimalPlace > 0 ? true : false)),
          inputFormatters: [getInputFormatters(widget.inputDecimalPlace)],
          decoration: InputDecoration(
            counterText: "",
            prefixText: widget.currencyCode,
            prefixStyle: widget.inputStyle,
            border: InputBorder.none,
          ),
          controller: controller,
        ));      
  }
}
