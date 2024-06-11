import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for TextInputFormatter
import 'package:food_delivery_app/Screens/Signup_Screens/payment_signup.dart';

// ignore: non_constant_identifier_names
int? cardnumber;
int? cvvNumber;

String? expiryDate;

// Controllers
final TextEditingController cardNumberController = TextEditingController();
final TextEditingController expiryDateController = TextEditingController();
final TextEditingController cvvController = TextEditingController();

// ignore: must_be_immutable
class PaymentDialog extends StatefulWidget {
  String? Cardname;

  PaymentDialog({super.key, required this.Cardname});

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  // Custom formatter to add space after every 4 digits and limit length to 19 characters (16 digits + 3 spaces)
  final cardNumberSpaceFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      if (newValue!.text.length > oldValue!.text.length) {
        if (newValue.text.length == 5 ||
            newValue.text.length == 10 ||
            newValue.text.length == 15) {
          final newText =
              '${oldValue.text} ${newValue.text.substring(newValue.text.length - 1)}';
          return TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }
      }
      return newValue;
    },
  );

  // Custom formatter to format expiry date in "MM/YY" format and limit length to 5 characters
  final expiryDateCustomFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      if (newValue!.text.length > oldValue!.text.length) {
        if (newValue.text.length == 2) {
          final newText = '${newValue.text}/'; // Add slash after 2 characters
          return TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }
      }
      return newValue;
    },
  );

  void validateCardNumber() {
    String cardNumberStr = cardNumberController.text;
    if (cardNumberStr.length != 19) {
      setState(() {
        isError = true;
      });
    } else {
      try {
        cardnumber = int.parse(cardNumberStr.split(' ').join(''));
      } catch (e) {
        setState(() {
          isError = true;
        });
      }
    }

    String cvvStr = cvvController.text;
    if (cvvStr.length > 3 || cvvStr.length < 3) {
      setState(() {
        isError = true;
      });
    } else if (cvvStr.length == 3) {
      try {
        cvvNumber = int.parse(cvvStr);
      } catch (e) {
        setState(() {
          isError = true;
        });
      }
    } else {
      try {
        cvvNumber = int.parse(cvvStr);
      } catch (e) {
        setState(() {
          isError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Enter Your ${widget.Cardname} Card Details",
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
            maxLength: 19, // Limit to 16 digits and 3 spaces
            decoration: const InputDecoration(
              hintText: "Card Number",
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  onChanged: (String value) {
                    value = expiryDate!;
                  },
                  controller: expiryDateController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [expiryDateCustomFormatter],
                  maxLength: 5, // Limit to 5 characters (MM/YY format)
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

            Navigator.of(context).pop();
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
