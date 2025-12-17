import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcart/data/medicine_data.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  double subtotal(Map<int, int> cart, List products) {
    double total = 0;
    for (var entry in cart.entries) {
      final product =
          products.firstWhere((p) => p.id == entry.key);
      total += product.price * entry.value;
    }
    return total;
  }

  double discount(String? coupon, double subtotal) {
    if (coupon == 'SAVE10') return subtotal * 0.10;
    if (coupon == 'SAVE20') return subtotal * 0.20;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(medicinesProvider);
    final cartState = ref.watch(cartProvider);

    final sub = subtotal(cartState.items, products);
    final disc = discount(cartState.coupon, sub);

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: products.map((product) {
                final qty = cartState.items[product.id] ?? 0;
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.asset(
                      product.image,
                      width: 80,
                      height: 80,
                    ),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => ref
                              .read(cartProvider.notifier)
                              .removeItem(product.id),
                        ),
                        Text(qty.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => ref
                              .read(cartProvider.notifier)
                              .addItem(product.id),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subtotal: \$${sub.toStringAsFixed(2)}'),
                Text('Discount: \$${disc.toStringAsFixed(2)}'),
                Text(
                  'Final: \$${(sub - disc).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                      hintText: 'Enter coupon code'),
                  onSubmitted: (value) {
                    ref
                        .read(cartProvider.notifier)
                        .applyCoupon(value, sub);
                  },
                ),
                if (cartState.coupon != null)
                  TextButton(
                    onPressed: () => ref
                        .read(cartProvider.notifier)
                        .removeCoupon(),
                    child: Text('Remove Coupon (${cartState.coupon})'),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
