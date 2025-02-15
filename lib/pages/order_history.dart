import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  Future<QuerySnapshot> _fetchOrders() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('date', descending: true)
        .get();
  }

  Widget _buildOrderItem(Map<String, dynamic> orderItem) {
    return ListTile(
      leading: Image.network(orderItem['imageUrl'] ?? '', width: 50, height: 50, fit: BoxFit.cover),
      title: Text(orderItem['foodName'] ?? ''),
      subtitle: Text('Qty: ${orderItem['quantity']}   Price: \$${orderItem['price']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: FutureBuilder<QuerySnapshot>(
        future: _fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              DateTime date = (data['date'] as Timestamp).toDate();
              String status = data['status'] ?? 'Unknown';
              List<dynamic> orderItems = data['orderItems'] ?? [];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text('Order on ${date.toLocal()}'),
                  subtitle: Text('Status: $status'),
                  children: orderItems.map((item) => _buildOrderItem(item as Map<String, dynamic>)).toList(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
