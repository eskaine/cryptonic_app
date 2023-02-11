import 'package:cryptonic/utilities/crypto.service.dart';
import 'package:flutter/material.dart';
import '../models/lastUpdatedPanel.model.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import 'dart:async';
import './handler/panelHandler.dart';

class CurrencyScreen extends StatefulWidget {
  final CryptoService cryptoService = new CryptoService();
  final double commission;
  final bool isSelling;

  CurrencyScreen(this.commission, this.isSelling);

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String date = DateFormat(DATETIME_FORMAT).format(DateTime.now());
  int apiTimer = 0;
  String inputCurrency = "SGD";
  Map<String, dynamic> _cryptoData = {};
  double inputPrice = 10000;

  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState() {
    repeatUpdate();
  }

  void repeatUpdate() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (apiTimer == 0) {
        fetchData(inputCurrency);
        date = DateFormat(DATETIME_FORMAT).format(DateTime.now());
        apiTimer = 60;
      }
      runTimer();
    });
  }

  void setInputPrice(String value) {
    setState(() {
      inputPrice = double.parse(value == '' ? '0' : value);
    });
  }

  void setInputCurrency(String value) {
    setState(() {
      inputCurrency = value;
    });
    fetchData(inputCurrency);
  }

  void runTimer() {
    setState(() {
      apiTimer--;
    });
  }

  void fetchData(String currency) {
    widget.cryptoService.fetchCurrencies(currency).then((data) {
      setState(() {
        _cryptoData = data;
      });
    });
  }

  MaterialColor getModeColor() {
    return widget.isSelling ? Colors.green : Colors.red;
  }

  Widget setPanelHandler(String code, String name, String symbol, int decimalPlace, int inputDecimalPlace) {
    double rawPrice =
        _cryptoData[code] == null ? 0 : double.parse(_cryptoData[code]);
    double calPrice = unitPrice(code, rawPrice, widget.commission);
    return PanelHandler(code, name, symbol, inputCurrency, calPrice, inputPrice,
        setInputCurrency, setInputPrice, getModeColor(), decimalPlace, inputDecimalPlace);
  }

  double unitPrice(String displayCurrency, double price, double rates) {
    if (
        (inputCurrency != displayCurrency && inputCurrency != "SGD" && inputCurrency != "USD") ||
        (inputCurrency == "SGD" && displayCurrency != "SGD" && displayCurrency != "USD") 
      ) {
      if (widget.isSelling) {
        price -= ((price / 100) * rates);
      } else {
        price += ((price / 100) * rates);
      }
    }
    else if  (inputCurrency == "USD" && displayCurrency == "SGD") {
      if (widget.isSelling) {
        price += ((price / 100) * rates);
      } else {
        price -= ((price / 100) * rates);
      }
    }

    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 120,
      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                flex: 10, // 20%
                child: Column(
                  children: <Widget>[
                    LastUpdatedPanel(apiTimer.toString(), date),
                    SizedBox(height: 20),
                    setPanelHandler("SGD", "SG Dollar", "\$", 0, 0),
                    SizedBox(height: 20),
                    setPanelHandler("USD", "US Dollar", "\$", 0, 0),
                    SizedBox(height: 20),
                    setPanelHandler("BTC", "Bitcoin", "₿", 4, 5),
                    SizedBox(height: 20),
                    setPanelHandler("LTC", "Litecoin", "Ł", 4, 3),
                    SizedBox(height: 20),
                    setPanelHandler("XAU", "Gold Ounce", "XAU", 4, 0),
                    SizedBox(height: 20),
                    setPanelHandler("XAG", "Silver Ounce", "XAG", 4, 0),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
