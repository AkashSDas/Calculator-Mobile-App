import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/screens/helper.dart';
import 'package:calculator/shared/dialog_box.dart';
import 'package:calculator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:function_tree/function_tree.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _displayInputText = ''; // Display operation on screen
  String _displayResult = ''; // Display result on screen

  // Operator functional
  List<String> _operators = [
    'add',
    'subtract',
    'multiply',
    'divide',
    '+',
    '-',
    '\u{00D7}',
    '\u{00F7}',
  ];

  // List of operations
  List<String> _operations = [
    'add',
    'subtract',
    'multiply',
    'divide',
    'equal',
    'none',
  ];

  // All numbers & operators
  List<String> _calculation = [];

  // Evaluate the mathematical operation
  void _evaluate(BuildContext context, String inputString) {
    try {
      num result = inputString.interpret();

      if (result >= pow(10, 16)) {
        setState(() {
          _displayResult = result.toStringAsExponential();
        });
      } else {
        setState(() {
          _displayResult = result.toString();
        });
      }
    } catch (e) {
      print(e);
      alertDialog(
        context: context,
        text: '❌ Invalid operation',
      );
    }
  }

  Widget _buildInputField({@required BuildContext context}) {
    return Container(
      alignment: Alignment.topRight,
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.9,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: AutoSizeText(
          '${this._displayInputText}',
          maxLines: 5,
          minFontSize: 26,
          style: tnumTextStyle,
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return AutoSizeText(
      this._displayResult,
      style: TextStyle(
        fontFamily: ttextFamily,
        fontSize: 28.0,
        color: Colors.white54,
      ),
      textAlign: TextAlign.end,
      maxLines: 1,
      minFontSize: 22,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildBackspaceContainer() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: IconButton(
        onPressed: () {
          if (this._displayInputText.length == 0) {
            print('Backspace clicked: Nothing on screen');
          } else {
            if (this._operators.contains(
                this._displayInputText[this._displayInputText.length - 1])) {
              setState(() {
                this._displayInputText = this
                    ._displayInputText
                    .substring(0, this._displayInputText.length - 1);
              });
              this._calculation.removeLast();
            } else {
              setState(() {
                this._displayInputText = this
                    ._displayInputText
                    .substring(0, this._displayInputText.length - 1);
              });
            }
            print(this._calculation);
          }
        },
        icon: FaIcon(
          FontAwesomeIcons.backspace,
          size: 30.0,
          color: ttext2,
        ),
      ),
    );
  }

  Widget _iconKeyBtn({
    BuildContext context,
    @required IconData icon,
    @required String operation,
    Color color = const Color(0xFF0A8449),
    Color bgColor = const Color(0xFF1B1919),
  }) {
    Function onPressed;

    if (this._operations.contains(operation)) {
      if (operation == 'none') {
        onPressed = () {};
      } else if (this._operators.contains(operation)) {
        onPressed = () {
          if (operation != 'equal') {
            if (this._calculation.isEmpty) {
              this._calculation.add(this._displayInputText);
              this._calculation.add(getOperationSign(operation));
            } else {
              String pattern = this._calculation.join('');
              pattern = pattern.replaceAll('*', '\u{00D7}');
              pattern = pattern.replaceAll('/', '\u{00F7}');
              print('********* $pattern ${this._displayInputText}');
              print('${this._displayInputText.split(pattern)}');
              String nextNumber = this._displayInputText.split(pattern)[1];
              this._calculation.add(nextNumber);
              this._calculation.add(getOperationSign(operation));
            }
            setState(() {
              this._displayInputText =
                  this._displayInputText + getOperationDisplaySign(operation);
            });
          }
        };
      } else if (operation == 'equal') {
        String inputString = this._displayInputText;
        inputString = inputString.replaceAll('\u{00D7}', '*');
        inputString = inputString.replaceAll('\u{00F7}', '/');
        onPressed = () => this._evaluate(context, inputString);
      } else {
        onPressed = () {};
      }
    }

    return Container(
      height: 65.0,
      width: 65.0,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: IconButton(
        icon: FaIcon(icon, size: 40.0, color: color),
        onPressed: onPressed,
      ),
    );
  }

  Widget _textKeyBtn({
    @required String text,
    Color color = const Color(0xFFF4F0F0),
  }) {
    return Container(
      height: 65.0,
      width: 65.0,
      decoration: BoxDecoration(
        color: tbgSecondary,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontFamily: ttextFamily,
            fontWeight: FontWeight.w400,
            fontSize: 40.0,
          ),
        ),
        onPressed: () {
          if (text != 'C') {
            if (this._calculation.isNotEmpty) {
              try {
                String pattern = this._calculation.join('');
                pattern = pattern.replaceAll('*', '\u{00D7}');
                pattern = pattern.replaceAll('/', '\u{00F7}');
                print(pattern);
                String lastNumberEntered =
                    this._displayInputText.split(pattern)[1];
                if ('$lastNumberEntered$text'.length > 15) {
                  alertDialog(
                    context: context,
                    text: 'Cannot enter more than 15 digits',
                  );
                } else {
                  setState(() {
                    this._displayInputText = this._displayInputText + text;
                  });
                }
              } catch (e) {
                print(e);
              }
            } else {
              if (this._displayInputText.length > 15) {
                alertDialog(
                  context: context,
                  text: 'Cannot enter more than 15 digits',
                );
              } else {
                setState(() {
                  this._displayInputText = this._displayInputText + text;
                });
              }
            }
          } else if (text == 'C') {
            setState(() {
              this._displayInputText = '';
              this._displayResult = '';
              this._calculation = [];
            });
          }
        },
      ),
    );
  }

  Widget _buildRow1InKeysGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        this._iconKeyBtn(
          icon: FontAwesomeIcons.clock,
          operation: 'none',
        ),
        this._textKeyBtn(
          text: 'C',
          color: ttext3,
        ),
        this._iconKeyBtn(
          icon: FontAwesomeIcons.percent,
          operation: 'none',
        ),
        this._iconKeyBtn(icon: FontAwesomeIcons.divide, operation: 'divide'),
      ],
    );
  }

  Widget _buildRow2InKeysGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        this._textKeyBtn(text: '7'),
        this._textKeyBtn(text: '8'),
        this._textKeyBtn(text: '9'),
        this._iconKeyBtn(icon: FontAwesomeIcons.times, operation: 'multiply'),
      ],
    );
  }

  Widget _buildRow3InKeysGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        this._textKeyBtn(text: '4'),
        this._textKeyBtn(text: '5'),
        this._textKeyBtn(text: '6'),
        this._iconKeyBtn(icon: FontAwesomeIcons.plus, operation: 'add'),
      ],
    );
  }

  Widget _buildRow4InKeysGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        this._textKeyBtn(text: '1'),
        this._textKeyBtn(text: '2'),
        this._textKeyBtn(text: '3'),
        this._iconKeyBtn(icon: FontAwesomeIcons.minus, operation: 'subtract'),
      ],
    );
  }

  Widget _buildRow5InKeysGrid({BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        this._iconKeyBtn(
          icon: FontAwesomeIcons.rulerHorizontal,
          operation: 'none',
        ),
        this._textKeyBtn(text: '0'),
        this._textKeyBtn(text: '.'),
        this._iconKeyBtn(
          context: context,
          icon: FontAwesomeIcons.equals,
          operation: 'equal',
          color: ttext1,
          bgColor: ttext2,
        ),
      ],
    );
  }

  Widget _buildKeysGrid({BuildContext context}) {
    return Column(
      children: <Widget>[
        this._buildRow1InKeysGrid(),
        SizedBox(height: 18),
        this._buildRow2InKeysGrid(),
        SizedBox(height: 18),
        this._buildRow3InKeysGrid(),
        SizedBox(height: 18),
        this._buildRow4InKeysGrid(),
        SizedBox(height: 18),
        this._buildRow5InKeysGrid(context: context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tbgPrimary,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              this._buildInputField(context: context),
              this._buildTextField(),
              this._buildBackspaceContainer(),
              Divider(height: 20.0, color: ttext1),
              this._buildKeysGrid(context: context),
            ],
          ),
        ),
      ),
    );
  }
}
