import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  final Map<String, dynamic> order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final products = order["items"] ?? [];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: toggleExpanded,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: const Icon(Icons.person_outline, size: 30, color: Colors.blueGrey),
                title: Text(
                  order["customer"],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "ID: ${order["orderId"]}",
                  style: TextStyle(fontSize: 14, color: Colors.green.shade700),
                ),
                trailing: Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                  size: 28,
                ),
              ),

              // Expandable content
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Column( //
                  children: products.map<Widget>((product) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.shopping_cart, size: 22, color: Colors.blueGrey),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "₹${product["product"]}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            "₹${product["price"]}",
                            style: const TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
