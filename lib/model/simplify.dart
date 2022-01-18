import 'package:flutter/material.dart';

class Simplyfy{
  static void showCustomDialog(BuildContext context,
      {@required String? title, 
      String cancelBtnText = "Close",
     }) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title.toString()),
            // content: ,
            actions: <Widget>[
              MaterialButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

   // showGeneralDialog(
  //   context: context,
  //   barrierLabel: "Barrier",
  //   barrierDismissible: true,
  //   barrierColor: Colors.black.withOpacity(0.5),
  //   transitionDuration: Duration(milliseconds: 500),
  //   pageBuilder: (_, __, ___) {
  //     return Material(
  //       color: Colors.transparent,
  //       child: Center(
  //         child: Card(
  //           child:Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text('Error'),
  //           ) ,
  //           margin: EdgeInsets.symmetric(horizontal: 20),
  //         ),
  //       ),
  //     );
  //   },
  //   transitionBuilder: (_, anim, __, child) {
  //     Tween<Offset> tween;
  //     if (anim.status == AnimationStatus.reverse) {
  //       tween = Tween(
  //           begin: Offset(-1, 0), end: Offset.zero);
  //     } else {
  //       tween = Tween(
  //           begin: Offset(1, 0), end: Offset.zero);
  //     }

  //     return FadeTransition(
  //         opacity: anim,
  //         child: child,
  //       );
  //   },
  // );
}