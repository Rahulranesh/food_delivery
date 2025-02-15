import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/components/my_receipt.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/pages/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({Key? key}) : super(key: key);
  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  // Assigned driver details
  String driverName = "Not Assigned";
  String driverPhone = "";
  String driverId = "";
  bool isDriverAssigned = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _assignDriver();
    _saveOrder();
  }

  Future<void> _assignDriver() async {
    final restaurant = Provider.of<Restaurant>(context, listen: false);
    if (restaurant.deliveryCoordinates == null) return;
    GeoPoint userLocation = restaurant.deliveryCoordinates!;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('drivers')
        .where('status', isEqualTo: 'available')
        .get();

    double minDistance = double.infinity;
    String selectedDriverId = "";
    String selectedDriverName = "";
    String selectedDriverPhone = "";
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      GeoPoint driverLocation = data['location'];
      double distance = Geolocator.distanceBetween(
          userLocation.latitude,
          userLocation.longitude,
          driverLocation.latitude,
          driverLocation.longitude);
      if (distance < minDistance) {
        minDistance = distance;
        selectedDriverId = doc.id;
        selectedDriverName = data['name'] ?? 'Driver';
        selectedDriverPhone = data['phone'] ?? '';
      }
    }
    if (selectedDriverId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(selectedDriverId)
          .update({'status': 'busy'});
      setState(() {
        driverId = selectedDriverId;
        driverName = selectedDriverName;
        driverPhone = selectedDriverPhone;
        isDriverAssigned = true;
      });
    }
  }

  void _saveOrder() async {
    final restaurant = Provider.of<Restaurant>(context, listen: false);
    String receipt = restaurant.generateReceipt();
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'date': DateTime.now(),
        'order': receipt,
        'driverId': driverId,
      });
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save order: $error')));
    }
  }

  void _showDriverDetails() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Driver Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Name: $driverName', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Phone: $driverPhone', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _callDriver() async {
    final Uri url = Uri(scheme: 'tel', path: driverPhone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Could not launch phone dialer')));
    }
  }

  void _messageDriver() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(driverName: driverName, driverId: driverId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final receipt = Provider.of<Restaurant>(context).generateReceipt();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Delivery in Progress'),
        centerTitle: true,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      body: Column(
        children: [
          MyReceipt(receipt: receipt),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showDriverDetails,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  onPressed: _showDriverDetails,
                  icon: const Icon(Icons.person)),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(driverName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary)),
              const Text('Driver'),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _messageDriver,
                  icon: Icon(Icons.message, color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _callDriver,
                  icon: const Icon(Icons.call, color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
