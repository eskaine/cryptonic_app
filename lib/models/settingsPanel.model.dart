import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPanel extends StatefulWidget {
  final void Function(double) setCommissionCB;
  final void Function(bool) setModeCB;
  final bool isSelling;

  SettingsPanel(this.isSelling, this.setCommissionCB, this.setModeCB);

  @override
  _SettingsPanelState createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _getCommissionState().then((value) {
      controller.value = TextEditingValue(text: value.toString());
    });
    controller.addListener(() {
      double value = double.parse(controller.text);
      if (value > 100) {
        controller.value = TextEditingValue(text: (100).toString());
      }

      _setCommissionState(double.parse(controller.text));
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<double> _getCommissionState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('commission') ?? 5;
  }

  _setCommissionState(double commission) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('commission', commission);
    widget.setCommissionCB(commission);
  }

  MaterialColor getModeColor() {
    return widget.isSelling ? Colors.green : Colors.red;
  }

  Widget modeButton(String label) {
    return ElevatedButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(1, 50)),
          backgroundColor: MaterialStateProperty.all(
              label == "Sell" ? Colors.green : Colors.red),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))),
      onPressed: () {
        setState(() {
          widget.setModeCB(label == "Sell");
        });
      },
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(30.0),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterText: "",
                labelText: 'Commission',
                border: OutlineInputBorder(),
              ),
              controller: controller,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: modeButton("Sell"),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 5,
                  child: modeButton("Buy"),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
