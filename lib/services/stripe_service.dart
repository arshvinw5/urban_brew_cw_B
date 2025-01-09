import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:urban_brew/services/stripe_keys.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<bool> makePayment(double totalAmount) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        totalAmount,
        "lkr",
      );
      if (paymentIntentClientSecret == null) return false;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Urban Brew",
        ),
      );

      await _processPayment();

      return true;
    } catch (e) {
      print("1 Payment Error: $e");
      return false;
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    print(amount);
    print(currency);
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print("Error creating PaymentIntent: $e");
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      // Confirm the Payment
      // await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      print("Error processing payment: $e");
      throw Exception("Payment failed");
    }
  }

  String _calculateAmount(double amount) {
    final calculatedAmount = (amount * 100).toInt();
    return calculatedAmount.toString();
  }
}
