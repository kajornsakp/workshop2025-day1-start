import 'package:chopee/model/product.dart';
import 'package:chopee/network/fake_api.dart';
import 'package:chopee/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({
    super.key, 
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLoading = true;
  String? errorMessage;
  Product? product;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
      // TODO: networking: use real network service
      final fetchedProduct = await FakeApi.getProductById(widget.productId);
      
      setState(() {
        product = fetchedProduct;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load product details: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.navigateToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleBack(context),
        ),
        title: const Text('Product Details'),
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchProductDetails,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : _buildProductDetails(),
    );
  }

  Widget _buildProductDetails() {
    if (product == null) {
      return const Center(child: Text('Product not found'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: product!.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product!.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Center(
                    child: Icon(Icons.image, size: 100, color: Colors.grey),
                  ),
            ),
            const SizedBox(height: 24),
            
            // Product Title
            Text(
              product!.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Price
            Text(
              '\$${product!.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Description
            const Text(
              'Product Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product!.description ?? 'No description available',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            
            // Stock information
            if (product!.stock != null) ...[
              Text(
                'In Stock: ${product!.stock}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Action buttons
            Row(
              children: [
                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.chat),
                  tooltip: 'Chat with seller',
                ),
                IconButton(
                  onPressed: () async {
                    // Add to cart functionality
                    if (product!.id != null) {
                      try {
                        await FakeApi.addToCart(product!.id!, 1);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart')),
                        );
                      } catch (e) {
                        print(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to add to cart')),
                        );
                      }
                    }
                  }, 
                  icon: const Icon(Icons.add_shopping_cart),
                  tooltip: 'Add to cart',
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      // Purchase functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Purchase initiated')),
                      );
                    }, 
                    child: const Text("Purchase")
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


