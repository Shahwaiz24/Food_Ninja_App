import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for TextInputFormatter

// Variables to store card details
String? cardNumber;
String? cvvNumber;
String? expiryDate;

// Controllers
final TextEditingController cardNumberController = TextEditingController();
final TextEditingController expiryDateController = TextEditingController();
final TextEditingController cvvController = TextEditingController();

class PaymentDialog extends StatefulWidget {
  final String? cardName;

  PaymentDialog({super.key, required this.cardName});

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  bool isError = false;

  // Custom formatter for card number with spaces after every 4 digits
  final cardNumberSpaceFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      final text = newValue.text.replaceAll(' ', '');
      final buffer = StringBuffer();
      for (int i = 0; i < text.length; i++) {
        if (i % 4 == 0 && i != 0) buffer.write(' ');
        buffer.write(text[i]);
      }
      return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.length),
      );
    },
  );

  // Custom formatter for expiry date in MM/YY format
  final expiryDateCustomFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      final text = newValue.text;
      if (text.length == 2 && oldValue.text.length == 1) {
        return TextEditingValue(
          text: '$text/',
          selection: TextSelection.collapsed(offset: 3),
        );
      }
      return newValue;
    },
  );

  void validateAndSaveCardDetails() {
    setState(() {
      isError = false;
    });

    final cardNumberStr = cardNumberController.text;
    if (cardNumberStr.replaceAll(' ', '').length != 16) {
      setState(() {
        isError = true;
      });
      return;
    }

    cardNumber = cardNumberStr;

    final cvvStr = cvvController.text;
    if (cvvStr.length != 3) {
      setState(() {
        isError = true;
      });
      return;
    }

    cvvNumber = cvvStr;

    final expiryDateStr = expiryDateController.text;
    if (expiryDateStr.length != 5 || !expiryDateStr.contains('/')) {
      setState(() {
        isError = true;
      });
      return;
    }

    expiryDate = expiryDateStr;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Enter Your ${widget.cardName} Card Details",
        style: const TextStyle(
          fontFamily: 'Poppins_SemiBold',
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                cardNumber = cardNumberController.text;
              });
            },
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [cardNumberSpaceFormatter],
            maxLength: 19,
            decoration: const InputDecoration(
              hintText: "Card Number",
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      expiryDate = expiryDateController.text;
                    });
                  },
                  controller: expiryDateController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [expiryDateCustomFormatter],
                  maxLength: 5,
                  decoration: const InputDecoration(
                    hintText: "(MM/YY)",
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      cvvNumber = cvvController.text;
                    });
                  },
                  maxLength: 3,
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "CVV",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "Submit",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins_Regular',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            validateAndSaveCardDetails();
            if (!isError) {
              Navigator.of(context).pop();
              // Handle successful validation
              print("Card Number: $cardNumber");
              print("CVV Number: $cvvNumber");
              print("Expiry Date: $expiryDate");
            } else {
              // Handle validation error
              print("Validation Error");
            }
          },
        ),
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins_Regular',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
