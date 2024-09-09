import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiscountPage(),
    );
  }
}

class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  final double originalPrice = 1000;
  final Map<String, double> coupons = {
    'CouponOne': 100,
    'CouponTwo': 200,
    'CouponThree': 300,
  };

  final TextEditingController _couponController = TextEditingController();
  double _finalPrice = 1000;

  void _applyCoupon() {
    final couponCode = _couponController.text;
    if (coupons.containsKey(couponCode)) {
      setState(() {
        _finalPrice = originalPrice - coupons[couponCode]!;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid coupon code.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _finalPrice = originalPrice; // Reset to original price if coupon is invalid
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Coupon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _couponController,
              decoration: InputDecoration(
                labelText: 'Enter Coupon Code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _applyCoupon,
              child: Text('Apply Coupon'),
            ),
            SizedBox(height: 20),
            Text(
              'Original Price: \$${originalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Final Price: \$${_finalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
