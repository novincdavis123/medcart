import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcart/data/medicine_data.dart';
import 'package:medcart/utils/cart_calculator.dart';
import '../providers/cart_provider.dart';
import 'package:medcart/models/medicine.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicines = ref.watch(medicinesProvider);
    final cartState = ref.watch(cartProvider);

    final sub = CartCalculator.subtotal(cartState.items, medicines);
    final disc = CartCalculator.discount(cartState.coupon, sub);

    return Scaffold(
      appBar: _appBar(),
      body: _body(context, medicines, cartState, ref, sub, disc),
    );
  }

  //AppBar of the screen
  AppBar _appBar() => AppBar(
    title: const Text(
      'Medicine Cart',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.lightBlueAccent,
  );

  //Body of the screen
  Column _body(
    BuildContext context,
    List<MedicineModel> medicines,
    CartState cartState,
    WidgetRef ref,
    double sub,
    double disc,
  ) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: medicines.map((medicine) {
              final qty = cartState.items[medicine.id] ?? 0;
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.asset(medicine.image, width: 80, height: 80),
                  title: Text(medicine.name),
                  subtitle: Text('\$${medicine.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => ref
                            .read(cartProvider.notifier)
                            .removeItem(medicine.id),
                      ),
                      Text(qty.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => ref
                            .read(cartProvider.notifier)
                            .addItem(medicine.id),
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
                // limited length of character
                maxLength: 6,
                decoration: const InputDecoration(
                  hintText: 'Enter 6‑digit coupon code',
                  counterText: '',
                ),
                onSubmitted: (value) {
                  final success = ref
                      .read(cartProvider.notifier)
                      .applyCoupon(value, sub);
                  // if coupon not authorized
                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Invalid coupon code or minimum not met!',
                        ),
                      ),
                    );
                  }
                },
              ),
              if (cartState.coupon != null)
                TextButton(
                  onPressed: () =>
                      ref.read(cartProvider.notifier).removeCoupon(),
                  child: Text('Remove Coupon (${cartState.coupon})'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
