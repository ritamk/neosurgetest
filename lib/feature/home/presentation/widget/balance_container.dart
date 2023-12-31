import 'package:flutter/material.dart';

class MyBalanceContainer extends StatelessWidget {
  const MyBalanceContainer({super.key, required this.net});
  final double net;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: net <= 0
                ? [
                    Colors.red.shade400,
                    Colors.red.shade600,
                  ]
                : [
                    Colors.green.shade400,
                    Colors.green.shade600,
                  ],
          )),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your balance',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  '₹ $net',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Icon(
            net <= 0
                ? Icons.thumb_down_alt_rounded
                : Icons.thumb_up_alt_rounded,
            color: net <= 0 ? Colors.red.shade300 : Colors.green.shade300,
            size: 48,
          ),
        ],
      ),
    );
  }
}
