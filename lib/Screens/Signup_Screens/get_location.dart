import 'package:flutter/material.dart';

String? city;
String? street;

class LocationInputDialog extends StatefulWidget {
  @override
  _LocationInputDialogState createState() => _LocationInputDialogState();
}

TextEditingController cityController = TextEditingController();
TextEditingController streetController = TextEditingController();

class _LocationInputDialogState extends State<LocationInputDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Your Location',
          style: TextStyle(
              fontFamily: 'Poppins_SemiBold',
              fontWeight: FontWeight.bold,
              fontSize: 18)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: cityController,
            decoration: const InputDecoration(
                labelText: 'City',
                labelStyle: TextStyle(
                    fontFamily: 'Poppins_Regular',
                    fontWeight: FontWeight.w600)),
          ),
          TextField(
            controller: streetController,
            decoration: const InputDecoration(
              labelText: 'Street Address',
              labelStyle: TextStyle(
                  fontFamily: 'Poppins_Regular', fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins_Regular',
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
        ),
        TextButton(
          onPressed: () {
            city = cityController.text;
            street = streetController.text;

            Navigator.of(context).pop();
          },
          child: const Text('Save',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins_Regular',
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
        ),
      ],
    );
  }
}
