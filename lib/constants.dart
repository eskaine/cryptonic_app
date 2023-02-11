
const String APP_NAME = "Cryptonic";
const String STATUS_TEXT = " Last updated: ";
const String API_CURRENCIES = "https://api.coinbase.com/v2/exchange-rates?currency=";

const String DATETIME_FORMAT = 'dd MMM yyy hh:mm';

const int TIMER_COUNTDOWN = 59;


const Map<String, Map<String, String>> CURRENCIES_LIST= {
  "SGD": {
    "code": "SGD",
    "label": "SG Dollar",
    "symbol": "\$"
  },
  "USD": {
    "code": "USD",
    "label": "US Dollar",
    "symbol": "\$"
  },
  "BTC": {
    "code": "BTC",
    "label": "Bitcoin",
    "symbol": "₿"
  },
  "LTC": {
    "code": "LTC",
    "label": "Litecoin",
    "symbol": "Ł"
  },
  "XAU": {
    "code": "XAU",
    "label": "Gold Ounce",
    "symbol": "XAU"
  },
  "XAG": {
    "code": "XAG",
    "label": "Silver Ounce",
    "symbol": "XAG"
  },
};


