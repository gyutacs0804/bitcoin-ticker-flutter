import 'package:bitcoin_ticker/services/networking.dart';

const apiKey = '6462B352-AC7F-415C-8CC5-9B75AAF7CE4C';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'HUF',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getCoinData({String currencyType}) async {
    NetworkHelper networkHelper =
        NetworkHelper('$coinAPIURL/BTC/$currencyType?apikey=$apiKey');

    var coinBitcoin = await networkHelper.getData();

    return coinBitcoin;
  }
}
