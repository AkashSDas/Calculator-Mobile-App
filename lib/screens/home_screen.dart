import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:calculator/styles/styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _inputController = TextEditingController();
  String _inputText = '';

  void _updateInputText() {
    this._inputText = _inputController.text;
  }

  Widget _buildTextFiled() {
    return Container(
      alignment: Alignment.topRight,
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: SingleChildScrollView(
        child: AutoSizeTextField(
          keyboardType: TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          // readOnly: true,
          maxLines: 8,
          minFontSize: 26,
          controller: this._inputController,
          onChanged: (value) => this._updateInputText(),
          style: tnumTextStyle,
          textAlign: TextAlign.end,
        ),
      ),
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
              this._buildTextFiled(),
            ],
          ),
        ),
      ),
    );
  }
}
