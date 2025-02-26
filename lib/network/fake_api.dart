
import 'package:chopee/model/cart.dart';
import 'package:chopee/model/category.dart';
import 'package:chopee/model/order.dart';
import 'package:chopee/model/product.dart';
import 'package:chopee/model/review.dart';
import 'package:chopee/model/shipping_address.dart';
import 'package:chopee/model/user.dart';

/// A utility class that provides mock data for the app
class MockData {
  // Mock data collections
  static final List<Product> products = [
    Product(
      id: 'prod1',
      name: 'Smartphone X',
      description: 'Latest smartphone with advanced features',
      category: 'Electronics',
      price: 699.99,
      stock: 50,
      isActive: true,
      imageUrl: 'https://picsum.photos/id/1/200',
      sellerId: 'seller1',
    ),
    Product(
      id: 'prod2',
      name: 'Laptop Pro',
      description: 'High-performance laptop for professionals',
      category: 'Electronics',
      price: 1299.99,
      stock: 25,
      isActive: true,
      imageUrl: 'https://picsum.photos/id/2/200',
      sellerId: 'seller1',
    ),
    Product(
      id: 'prod3',
      name: 'Casual T-Shirt',
      description: 'Comfortable cotton t-shirt',
      category: 'Clothing',
      price: 19.99,
      stock: 100,
      isActive: true,
      imageUrl: 'https://picsum.photos/id/3/200',
      sellerId: 'seller2',
    ),
    Product(
      id: 'prod4',
      name: 'Denim Jeans',
      description: 'Classic denim jeans for everyday wear',
      category: 'Clothing',
      price: 49.99,
      stock: 75,
      isActive: true,
      imageUrl: 'https://picsum.photos/id/4/200',
      sellerId: 'seller2',
    ),
    Product(
      id: 'prod5',
      name: 'Coffee Table',
      description: 'Modern coffee table for your living room',
      category: 'Home',
      price: 149.99,
      stock: 15,
      isActive: true,
      imageUrl: 'https://picsum.photos/id/5/200',
      sellerId: 'seller3',
    ),
    Product(
      id: 'prod6',
      name: 'Moisturizing Cream',
      description: 'Hydrating face cream for all skin types',
      category: 'Beauty',
      price: 24.99,
      stock: 60,
      isActive: true,
      imageUrl: 'https://picsum.photos/id/6/200',
      sellerId: 'seller4',
    ),
    Product(
      id: 'prod7',
      name: 'Yoga Mat',
      description: 'Non-slip yoga mat for your practice',
      category: 'Sports',
      price: 29.99,
      stock: 40,
      isActive: true,
      imageUrl: 'https://picsum.photos/id/7/200',
      sellerId: 'seller5',
    ),
    Product(
      id: 'prod8',
      name: 'Wireless Earbuds',
      description: 'True wireless earbuds with noise cancellation',
      category: 'Electronics',
      price: 129.99,
      stock: 35,
      isActive: true,
      imageUrl: 'https://picsum.photos/id/8/200',
      sellerId: 'seller1',
    ),
  ];
  
  static final List<Category> categories = [
    Category(id: 'cat1', name: 'Electronics', description: 'Electronic devices and gadgets'),
    Category(id: 'cat2', name: 'Clothing', description: 'Fashion and apparel'),
    Category(id: 'cat3', name: 'Home', description: 'Home goods and furniture'),
    Category(id: 'cat4', name: 'Beauty', description: 'Beauty and personal care products'),
    Category(id: 'cat5', name: 'Sports', description: 'Sports equipment and accessories'),
  ];
  
  static final Cart cart = Cart(
    id: 'cart123',
    items: [
      CartDetailItem(
        productId: 'prod1',
        name: 'Smartphone X',
        price: 699.99,
        quantity: 1,
        imageUrl: 'https://picsum.photos/id/1/200',
      ),
      CartDetailItem(
        productId: 'prod3',
        name: 'Casual T-Shirt',
        price: 19.99,
        quantity: 2,
        imageUrl: 'https://picsum.photos/id/3/200',
      ),
    ],
    totalItems: 3,
    totalPrice: 739.97,
  );
  
  static final List<Order> orders = [
    Order(
      id: 'order1',
      userId: 'user123',
      status: 'Delivered',
      shippingAddress: ShippingAddress(
        street: '123 Main St',
        city: 'Anytown',
        state: 'CA',
        zipCode: '12345',
        country: 'USA',
      ),
      paymentMethod: 'Credit Card',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Order(
      id: 'order2',
      userId: 'user123',
      status: 'Processing',
      shippingAddress: ShippingAddress(
        street: '123 Main St',
        city: 'Anytown',
        state: 'CA',
        zipCode: '12345',
        country: 'USA',
      ),
      paymentMethod: 'PayPal',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];
  
  static final List<Review> reviews = [
    Review(
      id: 'review1',
      userId: 'user123',
      productId: 'prod1',
      rating: 4.5,
      comment: 'Great product, very satisfied!',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Review(
      id: 'review2',
      userId: 'user456',
      productId: 'prod1',
      rating: 5.0,
      comment: 'Excellent smartphone, highly recommend!',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Review(
      id: 'review3',
      userId: 'user789',
      productId: 'prod2',
      rating: 4.0,
      comment: 'Good laptop, but battery life could be better.',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ];
  
  static final User currentUser = User(
    id: 'user123',
    email: 'user@example.com',
    firstName: 'John',
    lastName: 'Doe',
    displayName: 'John Doe',
    role: 'buyer',
  );
}

/// Simple utility functions to get mock data
class FakeApi {
  // Product functions
  static List<Product> getAllProducts() {
    return MockData.products;
  }
  
  static Product getProductById(String id) {
    return MockData.products.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Product not found'),
    );
  }
  
  static List<Product> getProductsByCategory(String category) {
    return MockData.products.where((p) => p.category == category).toList();
  }
  
  static List<Product> searchProducts(String query) {
    final searchLower = query.toLowerCase();
    return MockData.products.where((p) => 
      p.name.toLowerCase().contains(searchLower) || 
      (p.description?.toLowerCase().contains(searchLower) ?? false)
    ).toList();
  }
  
  // Category functions
  static List<Category> getAllCategories() {
    return MockData.categories;
  }
  
  // Cart functions
  static Cart getCart() {
    return MockData.cart;
  }
  
  static Cart addToCart(String productId, int quantity) {
    final product = getProductById(productId);
    
    // Create a copy of the current cart items
    final updatedItems = List<CartDetailItem>.from(MockData.cart.items);
    
    // Check if the product is already in the cart
    final existingItemIndex = updatedItems.indexWhere((item) => item.productId == productId);
    
    if (existingItemIndex >= 0) {
      // Update quantity of existing item
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = CartDetailItem(
        productId: existingItem.productId,
        name: existingItem.name,
        price: existingItem.price,
        quantity: existingItem.quantity + quantity,
        imageUrl: existingItem.imageUrl,
      );
    } else {
      // Add new item
      updatedItems.add(CartDetailItem(
        productId: product.id!,
        name: product.name,
        price: product.price,
        quantity: quantity,
        imageUrl: product.imageUrl ?? 'https://picsum.photos/200',
      ));
    }
    
    // Calculate totals
    final totalItems = updatedItems.fold(0, (sum, item) => sum + item.quantity);
    final totalPrice = updatedItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    
    // Return updated cart (without modifying the original)
    return Cart(
      id: MockData.cart.id,
      items: updatedItems,
      totalItems: totalItems,
      totalPrice: totalPrice,
    );
  }
  
  static Cart updateCartItem(String productId, int quantity) {
    // Create a copy of the current cart items
    final updatedItems = List<CartDetailItem>.from(MockData.cart.items);
    
    // Find the item
    final itemIndex = updatedItems.indexWhere((item) => item.productId == productId);
    if (itemIndex == -1) {
      throw Exception('Item not found in cart');
    }
    
    if (quantity <= 0) {
      // Remove item if quantity is 0 or negative
      updatedItems.removeAt(itemIndex);
    } else {
      // Update quantity
      final item = updatedItems[itemIndex];
      updatedItems[itemIndex] = CartDetailItem(
        productId: item.productId,
        name: item.name,
        price: item.price,
        quantity: quantity,
        imageUrl: item.imageUrl,
      );
    }
    
    // Calculate totals
    final totalItems = updatedItems.fold(0, (sum, item) => sum + item.quantity);
    final totalPrice = updatedItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    
    // Return updated cart (without modifying the original)
    return Cart(
      id: MockData.cart.id,
      items: updatedItems,
      totalItems: totalItems,
      totalPrice: totalPrice,
    );
  }
  
  static Cart removeFromCart(String productId) {
    // Create a copy with the item removed
    final updatedItems = MockData.cart.items.where((item) => item.productId != productId).toList();
    
    // Calculate totals
    final totalItems = updatedItems.fold(0, (sum, item) => sum + item.quantity);
    final totalPrice = updatedItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    
    // Return updated cart (without modifying the original)
    return Cart(
      id: MockData.cart.id,
      items: updatedItems,
      totalItems: totalItems,
      totalPrice: totalPrice,
    );
  }
  
  // Order functions
  static List<Order> getOrders() {
    return MockData.orders;
  }
  
  static Order getOrderById(String id) {
    return MockData.orders.firstWhere(
      (o) => o.id == id,
      orElse: () => throw Exception('Order not found'),
    );
  }
  
  static Order createOrder(ShippingAddress shippingAddress, String paymentMethod) {
    if (MockData.cart.items.isEmpty) {
      throw Exception('Cart is empty');
    }
    
    // Create a new order
    return Order(
      id: 'order${MockData.orders.length + 1}',
      userId: 'user123',
      status: 'Pending',
      shippingAddress: shippingAddress,
      paymentMethod: paymentMethod,
      createdAt: DateTime.now(),
    );
  }
  
  // Review functions
  static List<Review> getProductReviews(String productId) {
    return MockData.reviews.where((r) => r.productId == productId).toList();
  }
  
  // User functions
  static User getCurrentUser() {
    return MockData.currentUser;
  }
  
  static Map<String, dynamic> login(String email, String password) {
    // Simple mock login
    if (email == 'user@example.com' && password == 'password') {
      return {
        'token': 'fake_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': MockData.currentUser,
      };
    }
    throw Exception('Invalid credentials');
  }
  
  // Payment functions
  static Map<String, dynamic> processPayment(double amount, String currency) {
    return {
      'success': true,
      'transactionId': 'txn_${DateTime.now().millisecondsSinceEpoch}',
      'amount': amount,
      'currency': currency,
    };
  }
}