import 'package:flutter/material.dart';

import '../styles/styles.dart';

void alertDialog({@required BuildContext context, @required String text}) {
  Dialog alertDialog = Dialog(
    backgroundColor: tbgSecondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      height: 200.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              text,
              style: tnumTextStyle,
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (_) => alertDialog);
}
