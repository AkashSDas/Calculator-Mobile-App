import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/shared/dialog_box.dart';
import 'package:calculator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _inputText = '';
  String _displayResult = '';

  void _updateInputText({@required BuildContext context}) {
    if (int.parse(this._inputText) >= pow(10, 16)) {
      print(this._inputText.length);
      setState(() {
        _displayResult = int.parse(this._inputText).toStringAsExponential();
      });
    } else {
      setState(() {
        _displayResult = this._inputText;
      });
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
          '${this._inputText}',
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
        onPressed: () => print('Backspace button clicked'),
        icon: FaIcon(
          FontAwesomeIcons.backspace,
          size: 30.0,
          color: ttext2,
        ),
      ),
    );
  }

  Widget _iconKeyBtn({
    @required IconData icon,
    @required Function onPressed,
    Color color = const Color(0xFF0A8449),
    Color bgColor = const Color(0xFF1B1919),
  }) {
    return Container(
      height: 70.0,
      width: 70.0,
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
      height: 70.0,
      width: 70.0,
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
            if ('${this._inputText}{text}'.length > 15 * 20) {
              numOverflowAlertDialog(context: context);
            } else {
              setState(() {
                this._inputText = this._inputText + text;
              });
              this._updateInputText(context: context);
            }
          } else if (text == 'C') {
            setState(() {
              this._inputText = '';
              this._displayResult = '';
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
          onPressed: () => print('Key Pressed'),
        ),
        this._textKeyBtn(
          text: 'C',
          color: ttext3,
        ),
        this._iconKeyBtn(
          icon: FontAwesomeIcons.percent,
          onPressed: () => print('Key Pressed'),
        ),
        this._iconKeyBtn(
          icon: FontAwesomeIcons.divide,
          onPressed: () => print('Key Pressed'),
        ),
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
        this._iconKeyBtn(
          icon: FontAwesomeIcons.times,
          onPressed: () => print('Key Pressed'),
        ),
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
        this._iconKeyBtn(
          icon: FontAwesomeIcons.plus,
          onPressed: () => print('Key Pressed'),
        ),
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
        this._iconKeyBtn(
          icon: FontAwesomeIcons.minus,
          onPressed: () => print('Key Pressed'),
        ),
      ],
    );
  }

  Widget _buildRow5InKeysGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        this._iconKeyBtn(
          icon: FontAwesomeIcons.rulerHorizontal,
          onPressed: () => print('Key Pressed'),
        ),
        this._textKeyBtn(text: '0'),
        this._textKeyBtn(text: '.'),
        this._iconKeyBtn(
          icon: FontAwesomeIcons.equals,
          color: ttext1,
          bgColor: ttext2,
          onPressed: () => print('Key Pressed'),
        ),
      ],
    );
  }

  Widget _buildKeysGrid() {
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
        this._buildRow5InKeysGrid(),
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
              Divider(height: 10.0, color: ttext1),
              this._buildKeysGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
