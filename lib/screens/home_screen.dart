import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:calculator/shared/dialog_box.dart';
import 'package:calculator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _inputController = TextEditingController();
  String _inputText = '';
  String _displayResult = '';

  void _updateInputText({@required BuildContext context}) {
    if (_inputController.text.length > 15) {
      numOverflowAlertDialog(context: context);
    } else {
      this._inputText = _inputController.text;
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
  }

  Widget _buildInputField({@required BuildContext context}) {
    return Container(
      alignment: Alignment.topRight,
      height: MediaQuery.of(context).size.height * 0.24,
      width: double.infinity,
      child: SingleChildScrollView(
        child: AutoSizeTextField(
          keyboardType: TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          // readOnly: true,
          maxLines: 5,
          minFontSize: 26,
          controller: this._inputController,
          onChanged: (value) => this._updateInputText(context: context),
          style: tnumTextStyle,
          textAlign: TextAlign.end,
          decoration: InputDecoration(border: InputBorder.none),
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
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: IconButton(
                  onPressed: () => print('Backspace button clicked'),
                  icon: FaIcon(
                    FontAwesomeIcons.backspace,
                    size: 30.0,
                    color: ttext2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
