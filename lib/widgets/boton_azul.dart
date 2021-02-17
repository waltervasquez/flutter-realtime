import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String Texto;
  final Color colors;
  final Function onPress;

  const BotonAzul({   Key key,
    @required this.Texto,
    @required this.colors,
    @required this.onPress
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
            elevation: 2,
            highlightElevation: 5,
            color: this.colors,
            shape: StadiumBorder(),
            child: Container(
              width: double.infinity,
              height: 55,
              child: Center(
                child: Text(this.Texto, style: TextStyle(color: Colors.white, fontSize: 17,)),
              ),
            ),
        onPressed: this.onPress
    );
  }
}
