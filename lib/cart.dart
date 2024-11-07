import 'package:flutter/material.dart';
import 'package:flutter_application_1/order.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double total = widget.cartItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);
    double tax = total * 0.11;
    double grandTotal = total + tax;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: BackButton(),
        actions: [Icon(Icons.person)],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ...widget.cartItems.map((item) {
            return ListTile(
              leading: Image.asset('assets/burger.jpg', width: 50, height: 50),
              title: Text(item['name']),
              subtitle: Text('Rp. ${item['price']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (item['quantity'] > 1) {
                          item['quantity'] -= 1;
                        } else {
                          widget.cartItems.remove(item);
                        }
                      });
                    },
                  ),
                  Text('${item['quantity']}'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        item['quantity'] += 1;
                      });
                    },
                  ),
                ],
              ),
            );
          }).toList(),
          Divider(),
          ListTile(
            title: Text('PPN 11%'),
            trailing: Text('Rp. ${tax.toStringAsFixed(0)}'),
          ),
          ListTile(
            title: Text('Total Pembayaran'),
            trailing: Text('Rp. ${grandTotal.toStringAsFixed(0)}'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderPage(cartItems: widget.cartItems),),);
            },
            child: Text('Checkout'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}
