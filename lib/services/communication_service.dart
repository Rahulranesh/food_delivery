import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class CommunicationService {
  static void callDriver(BuildContext context, String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch phone dialer')),
      );
    }
  }

  static void messageDriver(BuildContext context, String phone) async {
    final Uri smsUrl = Uri(scheme: 'sms', path: phone);
    if (await canLaunchUrl(smsUrl)) {
      await launchUrl(smsUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open messaging app')),
      );
    }
  }
}
