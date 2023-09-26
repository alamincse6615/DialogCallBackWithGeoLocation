import 'dart:ui';
import 'package:dialog_callback_demo/detect_location/location_determine.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class BlurryDialog extends StatefulWidget {
  String title;
  String content;
  Function(Position) position;
  BlurryDialog(this.title, this.content, this.position, {super.key});

  @override
  State<BlurryDialog> createState() => _BlurryDialogState();
}

class _BlurryDialogState extends State<BlurryDialog> {
  TextStyle textStyle = const TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    String dialogTxt = "";
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title: Text(
            dialogTxt.isNotEmpty?dialogTxt:widget.title,
            style: textStyle,),
          content: Text(widget.content, style: textStyle,),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Continue"),
              onPressed: () async{
                dialogTxt = "Location Fixing.....\nPlease Wait";
                setState(() {

                });
                Position pos = await GetLocationData().determinePosition();
                dialogTxt = "";
                widget.position(pos);
                setState(() {

                });
              },
            ),
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
