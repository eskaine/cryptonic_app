import 'dart:convert';

class CurrencyRatesResponse {
  final String currency;
  Map<String, String> rates ;

  CurrencyRatesResponse({
    required this.currency,
    required this.rates,
  });  

  factory CurrencyRatesResponse.fromRawJson(String str) => CurrencyRatesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrencyRatesResponse.fromJson(Map<String, dynamic> json) => CurrencyRatesResponse(
    currency: json["currency"],
    rates: json["rates"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "rates": rates,
  };
}