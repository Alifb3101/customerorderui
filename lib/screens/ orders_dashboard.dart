import 'package:flutter/material.dart';// Make sure this file exists
import '../data/ orders_sample.dart';
import '../widgets/insights_panel.dart'; // Optional widget, safe to remove if not used
import '../widgets/order_card.dart'; // Our custom card

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final List<Map<String, dynamic>> customerOrders = orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 2,
        title: const Text(
          "Order Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Insights(), // remove if you don't use this
            const SizedBox(height: 20),


            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Customer Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),


            ListView.builder(
              shrinkWrap: true,
              physics:  NeverScrollableScrollPhysics(),
              itemCount: customerOrders.length,
              itemBuilder: (context, index) {
                return OrderCard(order: customerOrders[index]);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
