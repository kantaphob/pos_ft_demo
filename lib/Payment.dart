// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:pos_ft_demo/ShoppingCart.dart';

// void main() {
//   runApp(const Payment());
// }

// class Payment extends StatefulWidget {
//   const Payment({Key? key}) : super(key: key);

//   @override
//   State<Payment> createState() => _PaymentState();
// }

// class _PaymentState extends State<Payment> {
//   List<String> items = ['Item 1', 'Item 2', 'Item 3']; // Your order items
//   List<double> prices = [10, 15, 20]; // Prices corresponding to each item

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Invoice',
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.brown,
//         ),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Invoice',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 25,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.white,

//         // Body of the invoice
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(color: Colors.grey.shade300),
//                 height: 150,
//                 child: ListView.builder(
//                   itemCount: items.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       title: Text(items[index]),
//                       trailing: Text('\$${prices[index]}'), // Display item price
//                     );
//                   },
//                 ),
//               ),
//             ),

//             // Payment button
//             AnimatedButton(
//               text: "Pay",
//               color: Colors.green,
//               pressEvent: () {
//                 AwesomeDialog(
//                   context: context,
//                   dialogType: DialogType.success,
//                   animType: AnimType.bottomSlide,
//                   title: "Success",
//                   desc: "Thank you",
//                   btnOkOnPress: () {
//                     Navigator.pop(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ShoppingCart(),
//                       ),
//                     );
//                   },
//                 ).show();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
