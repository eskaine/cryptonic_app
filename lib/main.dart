import 'package:flutter/material.dart';
import '../screens/currency.dart';
import '../constants.dart';
import './models/settingsPanel.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: APP_NAME),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double commission = 0;
  bool isSelling = true;

  @override
  void initState() {
    _getCommissionState().then((value) {
      setCommission(value);
    });
  }

  void setCommission(double newCommission) {
    setState(() {
      print('comission');
      print(newCommission);
      commission = newCommission;
    });
  }

  void setCalcMode(bool mode) {
    setState(() {
      isSelling = mode;
    });
  }

  Future<double> _getCommissionState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('commission') ?? 5;
  }

  createSettingsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SettingsPanel(isSelling, setCommission, setCalcMode);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Color(0xFF0061FF),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              createSettingsDialog(context);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[CurrencyScreen(commission, isSelling)],
        ),
      ),
    );
  }
}
