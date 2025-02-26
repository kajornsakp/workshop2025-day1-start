import 'package:chopee/buyer/components/product_card.dart';
import 'package:chopee/model/category.dart';
import 'package:chopee/model/product.dart';
import 'package:chopee/network/fake_api.dart';
import 'package:chopee/router.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Category> allCategories = [];
  List<Product> allProducts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.wait([_fetchProducts(), _fetchCategories()]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchProducts() async {
    try {
      // TODO: networking: use real network service
      final products = FakeApi.getAllProducts();

      if (products.isNotEmpty) {
        setState(() {
          allProducts = products;
        });
      }
    } catch (e) {
      throw Exception('Failed to load products: ${e.toString()}');
    }
  }

  Future<void> _fetchCategories() async {
    // TODO: networking: use real network service
    final categories = FakeApi.getAllCategories();
    setState(() {
      allCategories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 220,
              child:
                  allCategories.isEmpty
                      ? const Center(child: Text("No categories available"))
                      : CarouselView(
                        itemExtent: 300,
                        itemSnapping: true,
                        onTap: (index) {
                          context.pushCategory(allCategories[index].name);
                        },
                        children:
                            allCategories
                                .map(
                                  (category) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(category.name),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  category.name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
            ),
            const Text(
              "Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            allProducts.isEmpty
                ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("No products available"),
                  ),
                )
                : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: allProducts.length,
                  itemBuilder: (context, index) {
                    final product = allProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        context.pushProduct(product.id ?? '1');
                      },
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
