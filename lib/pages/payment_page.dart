import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/pages/delivery_progress.dart';
import 'package:provider/provider.dart';

enum PaymentMethod { creditCard, googlePay }

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  PaymentMethod selectedMethod = PaymentMethod.creditCard;

  void userTappedPay() {
    if (selectedMethod == PaymentMethod.creditCard) {
      if (formKey.currentState!.validate()) {
        _confirmPayment();
      }
    } else if (selectedMethod == PaymentMethod.googlePay) {
      _processGooglePay();
    }
  }

  void _confirmPayment() {
    final restaurant = Provider.of<Restaurant>(context, listen: false);
    String receipt = restaurant.generateReceipt();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Card Number: $cardNumber'),
              Text('Expiry Date: $expiryDate'),
              Text('Card Holder Name: $cardHolderName'),
              Text('CVV: $cvvCode'),
              const SizedBox(height: 20),
              const Text('Receipt:'),
              const SizedBox(height: 10),
              Text(receipt),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DeliveryProgressPage()));
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _processGooglePay() {
    // Simulated Google Pay flow
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Google Pay'),
        content: const Text('Processing Google Pay payment...'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DeliveryProgressPage()));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Check Out'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<PaymentMethod>(
                  value: PaymentMethod.creditCard,
                  groupValue: selectedMethod,
                  onChanged: (PaymentMethod? value) {
                    setState(() {
                      selectedMethod = value!;
                    });
                  },
                ),
                const Text('Credit/Debit Card'),
                Radio<PaymentMethod>(
                  value: PaymentMethod.googlePay,
                  groupValue: selectedMethod,
                  onChanged: (PaymentMethod? value) {
                    setState(() {
                      selectedMethod = value!;
                    });
                  },
                ),
                const Text('Google Pay'),
              ],
            ),
            if (selectedMethod == PaymentMethod.creditCard) ...[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (p0) {},
              ),
              const SizedBox(height: 20),
              CreditCardForm(
                formKey: formKey,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    isCvvFocused = data.isCvvFocused;
                  });
                },
                obscureCvv: true,
                obscureNumber: false,
              ),
            ] else if (selectedMethod == PaymentMethod.googlePay) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'You have selected Google Pay. Press "Pay now" to proceed.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
            const SizedBox(height: 20),
            MyButton(onTap: userTappedPay, text: 'Pay now'),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
