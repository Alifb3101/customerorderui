import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uiordertask/responsive.dart';
import 'package:uiordertask/logic/alllogics.dart';

import '../data/ orders_sample.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  final Map<String, int> highestsellingproduct = Logic().higestpurchaseproduct();
  final List<String> uniqueitem = Logic().alluniqueite();
  final List<String> orderid = Logic().above2000();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      height: getHeight(context) * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildInsightCard(
              icon: CupertinoIcons.cart,
              title: "Total Orders",
              subtitle: "Orders: ${orders.length}",
              gradientStart: Colors.orangeAccent,
              gradientEnd: Colors.deepOrange,
              onTap: () {
                _showTotalOrdersDetailSheet(context);
              },
            ),
            _buildInsightCard(
              icon: CupertinoIcons.cube_box_fill,
              title: "Top Product",
              subtitle:
              "${highestsellingproduct.keys.first}: ${highestsellingproduct.values.first} sold",
              gradientStart: Colors.lightBlue,
              gradientEnd: Colors.blueAccent,
              onTap: () {
                final key = highestsellingproduct.keys.first;
                final value = highestsellingproduct[key];
                _showBottomDetailSheet(
                  context,
                  "Top Selling Product",
                  ["Product: $key", "Units Sold: $value"],
                );
              },
            ),
            _buildInsightCard(
              icon: CupertinoIcons.list_bullet_indent,
              title: "Unique Items",
              subtitle: "Items: ${uniqueitem.length}",
              gradientStart: Colors.green,
              gradientEnd: Colors.teal,
              onTap: () {
                _showBottomDetailSheet(context, "Unique Items", uniqueitem);
              },
            ),
            _buildInsightCard(
              icon: CupertinoIcons.money_dollar_circle,
              title: "₹2000+ Orders",
              subtitle: "Count: ${orderid.length}",
              gradientStart: Colors.purple,
              gradientEnd: Colors.deepPurple,
              onTap: () {
                _showBottomDetailSheet(
                  context,
                  "Orders Above ₹2000",
                  orderid.map((id) => "Order ID: $id").toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color gradientStart,
    required Color gradientEnd,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 200,
      child: Material(
        color: Colors.transparent,
        elevation: 6,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: gradientEnd.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomDetailSheet(
      BuildContext context,
      String title,
      List<String> items,
      ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const Divider(height: 24, thickness: 1),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: Colors.indigo.shade50,
                      leading: const Icon(Icons.label_important, color: Colors.indigo),
                      title: Text(
                        items[index],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTotalOrdersDetailSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                children: [
                  const Text(
                    'All Orders Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const Divider(height: 24, thickness: 1),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: orders.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final orderId = order['orderId'] ?? 'Unknown';
                        final customerName = order['customer'] ?? 'No Name';
                        final items = (order['items'] ?? []) as List;
                        final totalItems = items.length;
                        final totalAmount = items.fold<double>(
                          0,
                              (sum, item) =>
                          sum +
                              ((item['price'] ?? 0) as num) *
                                  ((item['quantity'] ?? 1) as int),
                        );

                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.receipt_long_rounded,
                                        color: Colors.indigo),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Order ID: $orderId",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.person_outline,
                                        size: 20, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text("Customer: $customerName"),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.shopping_bag_outlined,
                                        size: 20, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text("Items Purchased: $totalItems"),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money_rounded,
                                        size: 20, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Total Amount: ₹${totalAmount.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
