import 'package:flutter/material.dart';

class MarkerLongTapDialogVM{

  void showPupUpDialog(BuildContext context, String title){
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Street:', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' some street name'),
                            TextSpan(text: "\n")
                          ]
                      )
                  ),
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Number:', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' 17'),
                            TextSpan(text: "\n")
                          ]
                      )
                  ),
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Distance to you:', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' 44m'),
                            TextSpan(text: "\n")
                          ]
                      )
                  ),
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Öffnungszeiten:', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' 8:00 - 19:30 Uhr'),
                            TextSpan(text: "\n")
                          ]
                      )
                  ),
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Toilette:', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' Nein'),
                            TextSpan(text: "\n")
                          ]
                      )
                  ),
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black), //apply style to all
                          children: [
                            TextSpan(text: 'Parkplatz:', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' Ja'),
                            TextSpan(text: "\n")
                          ]
                      )
                  ),
                ],
              ),
            ),

            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(ctx);
                  },
                  child: const Text("Close")
              )
            ]
        )
    );
  }

}