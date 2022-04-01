import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  int exchangeRate = 0;
  List<dynamic> exchange = [0, 0, 0];

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) async {
        exchange.clear();
        for (String crypto in cryptoList) {
          selectedCurrency = value;
          var coin = await coinData.getCoinData(
              currencyType: selectedCurrency, cryptoType: crypto);
          var rate = coin['rate'];
          exchangeRate = rate.toInt();
          exchange.add(exchangeRate);
        }
        setState(() {});
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> cupertinoItems = [];

    for (String currency in currenciesList) {
      cupertinoItems.add(
        Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return CupertinoPicker(
      itemExtent: 20.0,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
        exchange.clear();
        for (String crypto in cryptoList) {
          var coin = await coinData.getCoinData(
              currencyType: selectedCurrency, cryptoType: crypto);
          var rate = coin['rate'];
          exchangeRate = rate.toInt();
          exchange.add(exchangeRate);
        }
        print(exchange);
        setState(() {});
      },
      children: cupertinoItems,
      squeeze: 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CurrencyButton(
                  cryptoList: cryptoList[0],
                  exchangeRate: exchange[0],
                  selectedCurrency: selectedCurrency),
              CurrencyButton(
                  cryptoList: cryptoList[1],
                  exchangeRate: exchange[1],
                  selectedCurrency: selectedCurrency),
              CurrencyButton(
                  cryptoList: cryptoList[2],
                  exchangeRate: exchange[2],
                  selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.black87,
            child: Platform.isIOS ? iOSPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }
}

class CurrencyButton extends StatelessWidget {
  const CurrencyButton({
    Key key,
    @required this.exchangeRate,
    @required this.selectedCurrency,
    @required this.cryptoList,
  }) : super(key: key);

  final int exchangeRate;
  final String selectedCurrency;
  final String cryptoList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.teal,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: FlatButton(
          child: Text(
            '$cryptoList = $exchangeRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
