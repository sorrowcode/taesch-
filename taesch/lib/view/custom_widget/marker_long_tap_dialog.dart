import 'package:flutter/material.dart';
import 'package:taesch/model/shop.dart';

class MarkerLongTapDialog {
  void showPupUpDialog(BuildContext context, Shop shop) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: Text(shop.spot.name),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              //apply style to all
                              children: [
                            const TextSpan(
                                text: 'Street:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: shop.spot.street),
                            const TextSpan(text: "\n")
                          ])),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              //apply style to all
                              children: [
                            const TextSpan(
                                text: 'Number:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: shop.spot.houseNumber),
                            const TextSpan(text: "\n")
                          ])),
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(color: Colors.black),
                              //apply style to all
                              children: [
                            TextSpan(
                                text: 'Distance to you:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' distance in m'),
                            TextSpan(text: "\n")
                          ])),
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(color: Colors.black),
                              //apply style to all
                              children: [
                            TextSpan(
                                text: 'Öffnungszeiten:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' 8:00 - 19:30 Uhr'),
                            TextSpan(text: "\n")
                          ])),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Close"))
                ]));
  }
}
