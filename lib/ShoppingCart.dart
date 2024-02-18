import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final Map<String, double> coffeePrices = {
    'Espresso': 55,
    'Cappuccino': 55,
    'Latte': 55,
    'Americano': 60,
    'Macchiato': 65,
    'Mocha': 55,
    'Flat White': 55,
  };

  List<String> cart = [];

  void addToCart(String coffeeItem) {
    setState(() {
      cart.add(coffeeItem);
    });
  }

  void removeFromCart(String coffeeItem) {
    setState(() {
      cart.remove(coffeeItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
        ),
        backgroundColor: Colors.brown,
        //Navigation --------------------------------------------
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AccountPage(), // Navigate to AccountPage
                ),
              );
            },
            icon: Icon(Icons.account_circle), // Add icon for AccountPage
          ),
        ],

        //Navigation --------------------------------------------
      ),
      body: ListView.builder(
        itemCount: coffeePrices.length,
        itemBuilder: (BuildContext context, int index) {
          final coffeeItem = coffeePrices.keys.toList()[index];
          final price = coffeePrices.values.toList()[index];
          return ListTile(
            title: Text('$coffeeItem - ${price.toStringAsFixed(2)} ฿'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => addToCart(coffeeItem),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutPage(
                  cart: cart,
                  coffeePrices: coffeePrices,
                  removeFromCart: removeFromCart),
            ),
          );
        },
        label: Text('Checkout (${cart.length} Items)'),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

//accout page
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add logic to update user information
                String name = _nameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;
                // Call API or perform any other action to update user information
                // Display success or failure message accordingly
                // You can also navigate back to the previous page upon successful update
                // Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  final List<String> cart;
  final Map<String, double> coffeePrices;
  final Function(String) removeFromCart;

  const CheckoutPage(
      {Key? key,
      required this.cart,
      required this.coffeePrices,
      required this.removeFromCart})
      : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.cart.fold(
        0,
        (previousValue, element) =>
            previousValue + widget.coffeePrices[element]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        backgroundColor: Colors.brown,
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Text(
                'Empty items',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.cart[index];
                final price = widget.coffeePrices[item];
                return ListTile(
                  title: Text('$item - ${price?.toStringAsFixed(2)} ฿'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        widget.removeFromCart(item);
                        totalPrice = widget.cart.fold(
                          0,
                          (previousValue, element) =>
                              previousValue + widget.coffeePrices[element]!,
                        );
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: widget.cart.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Payment(totalPrice: totalPrice)),
                );
              },
              label: Text('Proceed to Payment ($totalPrice ฿)'),
              icon: const Icon(Icons.payment),
            ),
    );
  }
}

class Payment extends StatefulWidget {
  final double totalPrice;

  const Payment({Key? key, required this.totalPrice}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Invoice',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        backgroundColor: Colors.white,

        // Body of the invoice
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade300),
                height: 150,
                child: ListTile(
                  title: const Text('Total Price'),
                  trailing: Text(
                    '${widget.totalPrice.toString()} ฿', // Use widget.totalPrice to access the passed value
                    style:
                        const TextStyle(fontSize: 18), // Add style to the text
                  ),
                ),
              ),
            ),

            // Payment button

            AnimatedButton(
              text: "Pay",
              color: Colors.green,
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.bottomSlide,
                  title: "Success",
                  desc: "Thank you",
                  btnOkOnPress: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                ).show();
              },
            ),
          ],
        ),
      ),
    );
  }
}
