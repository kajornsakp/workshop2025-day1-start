import 'package:chopee/buyer/components/product_card.dart';
import 'package:chopee/model/product.dart';
import 'package:chopee/network/fake_api.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final IconData categoryIcon;

  const CategoryPage({
    super.key,
    this.categoryName = "Electronics",
    this.categoryIcon = Icons.devices,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductsByCategory();
  }

  Future<void> _loadProductsByCategory() async {
    setState(() {
      isLoading = true;
    });
    
    try {
        // TODO: networking: use real network service
        products = FakeApi.getProductsByCategory(widget.categoryName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: RefreshIndicator(
        onRefresh: _loadProductsByCategory,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : products.isEmpty 
                ? Center(child: Text('No products found in ${widget.categoryName}'))
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search in ${widget.categoryName}',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            // TODO: Implement search functionality
                          },
                        ),
                      ),

                      // Filter and Sort Row
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.filter_list),
                                label: const Text("Filter"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.sort),
                                label: const Text("Sort"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Product Grid
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              onTap: () {
                                // TODO: push to product page
                              },
                              product: products[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
