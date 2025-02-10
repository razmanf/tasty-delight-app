import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.receipt, color: Colors.blue),
            title: Text('Order #${index + 1}'),
            subtitle: Text('December ${index + 1}, 2023'),
            trailing: const Text('\$45.99', style: TextStyle(fontSize: 16)),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}