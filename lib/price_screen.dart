import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';

import 'coin_data.dart';

//API key ECF5ED55-E077-4F21-B1C1-327946F6F36C
const String apikey = 'ECF5ED55-E077-4F21-B1C1-327946F6F36C';

String selectedCurrency = currenciesList[0].toString();
const String url = 'https://rest.coinapi.io/v1/exchangerate/';
double bitcoinCurrentRate;
double ethereumCurrentRate;
double litecoinCurrentRate;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getPickerCurrencyOptions();
    getDropDownMenuCurrencyOptions();
    assignValues();
  }

  List<Widget> pickerItems = [];
  List<DropdownMenuItem<String>> dropdownMenuItems = [];

  resetCoins() {
    setState(() {
      bitcoinCurrentRate = null;
      ethereumCurrentRate = null;
      litecoinCurrentRate = null;
    });
  }

  Future<dynamic> getCurrencyValue(String cryptoCurrency) async {
    http.Response response = await http.get(
      Uri.parse('$url$cryptoCurrency/$selectedCurrency?apikey=$apikey'),
    );

    if (response.statusCode == 200) {
      dynamic decodedBody = jsonDecode(response.body);

      return decodedBody['rate'];
    } else {
      return null;
    }
  }

  assignValues() async {
    double newBitcoinCurrentRate = await getCurrencyValue('BTC');
    double newEthereumCurrentRate = await getCurrencyValue('ETH');
    double newLitecoinCurrentRate = await getCurrencyValue('LTC');
    setState(() {
      bitcoinCurrentRate = newBitcoinCurrentRate;
      ethereumCurrentRate = newEthereumCurrentRate;
      litecoinCurrentRate = newLitecoinCurrentRate;
    });
  }

  Widget getItemPicker() {
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = currenciesList[selectedIndex].toString();
            resetCoins();
          });
        },
        children: pickerItems);
  }

  Widget getDropDownMenu() {
    return DropdownButton(
      value: selectedCurrency,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          resetCoins();
        });
      },
      items: dropdownMenuItems,
    );
  }

  void getPickerCurrencyOptions() {
    for (var i = 0; i < currenciesList.length; i++) {
      pickerItems.add(
        Text(currenciesList[i]),
      );
    }
  }

  void getDropDownMenuCurrencyOptions() {
    for (var i = 0; i < currenciesList.length; i++) {
      dropdownMenuItems.add(
        DropdownMenuItem<String>(
          child: Text(currenciesList[i]),
          value: currenciesList[i],
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = ${bitcoinCurrentRate == null ? '-' : '${bitcoinCurrentRate.toStringAsFixed(2)} $selectedCurrency'} ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH = ${ethereumCurrentRate == null ? '-' : '${ethereumCurrentRate.toStringAsFixed(2)} $selectedCurrency'} ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTH = ${litecoinCurrentRate == null ? '-' : '${litecoinCurrentRate.toStringAsFixed(2)} $selectedCurrency'} ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            color: Colors.lightBlue,
            child: Column(
              children: [
                Platform.isIOS ? getItemPicker() : getDropDownMenu(),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      assignValues();
                    },
                    child: Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
