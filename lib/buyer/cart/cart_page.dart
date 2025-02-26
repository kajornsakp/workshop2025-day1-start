import 'package:chopee/model/cart.dart';
import 'package:chopee/network/fake_api.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = true;
  Cart cart = Cart.empty();

  @override
  void initState() {
    super.initState();
      _fetchCart();
    }

  Future<void> _fetchCart() async {
    final cart = FakeApi.getCart();
    setState(() {
      this.cart = cart;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: SafeArea(
        child: isLoading 
          ? const Center(child: CircularProgressIndicator())
          : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          item.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.image, size: 60),
                        ),
                        title: Text(item.name),
                        subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: () async {
                              await FakeApi.updateCartItem(item.productId, item.quantity - 1); 
                              await _fetchCart();
                            }, icon: Icon(Icons.remove)),
                            Text('${item.quantity}'),
                            IconButton(onPressed: () async {
                              await FakeApi.updateCartItem(item.productId, item.quantity + 1);
                              await _fetchCart();
                            }, icon: Icon(Icons.add)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text('Total items: ${cart.totalItems}'),
              Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}'),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle payment options
                      },
                      child: const Text('Payment Options'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Handle delivery options
                      },
                      child: const Text('Delivery Options'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        // TODO: Handle payment
                      },
                      child: const Text(
                        'Proceed to Payment',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
