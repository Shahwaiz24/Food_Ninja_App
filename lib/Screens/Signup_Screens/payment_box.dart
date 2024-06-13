import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for TextInputFormatter
import 'package:food_delivery_app/Screens/Signup_Screens/payment_signup.dart';

int? cardnumber;
int? cvvNumber;
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

  void validateCardNumber() {
    final cardNumberStr = cardNumberController.text.replaceAll(' ', '');
    if (cardNumberStr.length != 16) {
      setState(() {
        isError = true;
      });
      return;
    }

    try {
      cardnumber = int.parse(cardNumberStr);
    } catch (e) {
      setState(() {
        isError = true;
      });
      return;
    }

    final cvvStr = cvvController.text;
    if (cvvStr.length != 3) {
      setState(() {
        isError = true;
      });
      return;
    }

    try {
      cvvNumber = int.parse(cvvStr);
    } catch (e) {
      setState(() {
        isError = true;
      });
    }
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
            setState(() {
              isError = false;
            });
            validateCardNumber();

            if (!isError) {
              Navigator.of(context).pop();
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
