import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order ID #102963",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text("Branch: Haroon Bahria Naval Colony Branch"),
                    Text("20 Feb 2025 08:08:14 PM"),
                    SizedBox(height: 8),
                    Text("Order Note:"),
                  ],
                ),
              ),
            ),

            // Item Details Section
            Card(
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    title: Text("Item Details"),
                    tileColor: Colors.grey.shade200,
                  ),
                  ListTile(
                    leading: Image.network(
                      'https://example.com/sample-image.jpg', // Replace with actual image
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text("Chicken (chest meat)"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Type: 500gm"),
                        Text("Unit: pc"),
                        Text("Unit Price: Rs400"),
                        Text("QTY: 1"),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Price: Rs400"),
                        Text("Discount: Rs4"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Price Breakdown Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _priceRow("Items Price:", "Rs400"),
                    _priceRow("Item Discount:", "-Rs4"),
                    _priceRow("Sub Total:", "Rs396"),
                    _priceRow("TAX / VAT:", "Rs0"),
                    _priceRow("Coupon Discount:", "Rs0"),
                    _priceRow("Extra Discount:", "Rs0"),
                    _priceRow("Delivery Fee:", "Rs10"),
                    Divider(),
                    _priceRow("Total:", "Rs406", isBold: true),
                  ],
                ),
              ),
            ),

            // Delivery Information Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Information",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    _infoRow("Name", "Epic Khan"),
                    _infoRow("Phone", "+9203172442810"),
                    _infoRow("Road", "#11"),
                    _infoRow("House", "#76"),
                    _infoRow("Floor", "#3"),
                    SizedBox(height: 8),
                    Text(
                      "Address: WXXP+88X, Street 11, Sector 4 Naval Colony, Karachi, Pakistan",
                    ),
                  ],
                ),
              ),
            ),

            // Deliveryman Info Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deliveryman",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://example.com/deliveryman-avatar.jpg'), // Replace with actual image
                          radius: 30,
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Abdul Ahad"),
                            Text("922 Orders delivered"),
                            Text("+92 317 2870163"),
                            Text("ahad123@daily4deal.com"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Utility for displaying price rows
  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // Utility for displaying info rows
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderDetailsScreen(),
  ));
}
