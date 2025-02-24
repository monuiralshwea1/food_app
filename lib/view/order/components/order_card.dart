import 'package:flutter/material.dart';
import 'package:foodly_ui/constants.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final int orderId;
  final String status;
  final double totalPrice;
  final String dateTime;

  const OrderCard({
    Key? key,
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OrderNumber".tr+"#${orderId}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status:".tr +"{$status}".tr,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: status == "pending"
                            ? Colors.orange
                            : Colors.green)),
                Text("\YER$totalPrice",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor)),
              ],
            ),
            const SizedBox(height: 8),
            Text("Date:".tr+ "$dateTime", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}