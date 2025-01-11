import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioService {
  final TwilioFlutter smsTwilioFlutter;
  final TwilioFlutter whatsappTwilioFlutter;

  TwilioService({
    required String accountSID,
    required String authToken,
    required String smsTwilioNumber,
    required String whatsappTwilioNumber,
  })  : smsTwilioFlutter = TwilioFlutter(
    accountSid: accountSID,
    authToken: authToken,
    twilioNumber: smsTwilioNumber,
  ),
        whatsappTwilioFlutter = TwilioFlutter(
          accountSid: accountSID,
          authToken: authToken,
          twilioNumber: whatsappTwilioNumber,
        );

  Future<void> sendSms({
    required String toNumber,
    required String name,
    required String date,
    required String timeSlot,
    required BuildContext context,
  }) async {
    try {
      if (toNumber.isNotEmpty && name.isNotEmpty) {
        await smsTwilioFlutter.sendSMS(
          toNumber: toNumber.trim(),
          messageBody:
          '$name, Your appointment is scheduled successfully on $date at $timeSlot. Thank you!',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SMS sent successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid contact number or name.')),
        );
      }
    } catch (e) {
      handleTwilioError(e, context);
    }
  }

  Future<void> sendWhatsappMsg({
    required String toNumber,
    required String name,
    required String date,
    required String timeSlot,
    required BuildContext context,
  }) async {
    try {
      if (toNumber.isNotEmpty && name.isNotEmpty) {
        await whatsappTwilioFlutter.sendWhatsApp(
          toNumber: toNumber.trim(),
          messageBody:
          '$name, Your appointment is scheduled successfully on $date at $timeSlot. Thank you!',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('WhatsApp message sent successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid WhatsApp number or name.')),
        );
      }
    } catch (e) {
      handleTwilioError(e, context);
    }
  }

  void handleTwilioError(dynamic error, BuildContext context) {
    if (error.toString().contains("unverified")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Message failed: Number is not verified. Please verify the number in Twilio.',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $error')),
      );
    }
  }
}
