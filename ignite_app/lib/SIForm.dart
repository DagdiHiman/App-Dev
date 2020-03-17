import 'package:flutter/material.dart';

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var _currency = ['Rupee', 'USD', 'GBP', 'Others'];
  var _currentItemSelected = '';
  var displayResult = '';

  //initialise the currency
  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currency[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
          title: Text('Simple Interest Calculator'),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              // margin: EdgeInsets.all(10.0),
              child: ListView(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Image(
                    
                    alignment: Alignment.center,
                    width: 500.0,
                    height: 125.0,
                    image: AssetImage('images/calculator_icon.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return ('Please enter a valid principal amount');
                      } 
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter amount invested',
                      labelText: "Principal",
                      labelStyle: textStyle,
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // controller: TextEditingController(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: rateController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return ('Please enter a valid principal amount');
                      } 
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter the return percentage',
                        labelText: 'Return Percentage',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termController,
                          autovalidate: false,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return ('Please enter a valid principal amount');
                            } 
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter time period',
                              labelText: 'Time period',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(width: 50.0),
                      Expanded(
                          child: DropdownButton<String>(
                        items: _currency.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String currencySelected) {
                          setState(() {
                            this._currentItemSelected = currencySelected;
                          });
                        },
                        value: _currentItemSelected,
                      ))
                    ],
                  ),
                ),
                Center(
                    child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColorDark,
                            elevation: 2.0,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculateReturns();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            elevation: 2.0,
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ),
                )
              ]),
            )));
  }

  String _calculateReturns() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double totalAmount = (principal * rate * term) / 100 + principal;

    String totalAmountStatement =
        'Total amount payable after $term years is $totalAmount $_currentItemSelected';
    return totalAmountStatement;
  }

  void _reset() {
    principalController.text = '';
    rateController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currency[0];
    
  }
}