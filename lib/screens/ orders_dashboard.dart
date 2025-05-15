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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: AppBar(
            backgroundColor: Colors.blueAccent.withOpacity(0.9),
            elevation: 6,
            centerTitle: true,
            title: const Text(
              "Customer Dashboard",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
                shadows: [Shadow(color: Colors.black26, blurRadius: 3)],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {

                },
              ),

              const CircleAvatar(
                backgroundImage: AssetImage('assets/egle.jpg'),
                radius: 16,
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

             Insights(),
             SizedBox(height: 20),


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
