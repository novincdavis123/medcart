import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// --------------------
/// Cart State
/// --------------------
class CartState {
  final Map<int, int> items;
  final String? coupon;

  const CartState({
    required this.items,
    this.coupon,
  });

  CartState copyWith({
    Map<int, int>? items,
    String? coupon,
    bool clearCoupon = false,
  }) {
    return CartState(
      items: items ?? this.items,
      coupon: clearCoupon ? null : coupon ?? this.coupon,
    );
  }
}

/// --------------------
/// Provider
/// --------------------
final cartProvider =
    NotifierProvider<CartNotifier, CartState>(CartNotifier.new);

/// --------------------
/// Notifier
/// --------------------
class CartNotifier extends Notifier<CartState> {
  @override
  CartState build() {
    _loadCart();
    return const CartState(items: {});
  }

  /// --------------------
  /// Persistence
  /// --------------------
  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    final coupon = prefs.getString('coupon');

    if (cartData != null) {
      state = state.copyWith(
        items: Map<int, int>.from(jsonDecode(cartData)),
        coupon: (coupon == null || coupon.isEmpty) ? null : coupon,
      );
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', jsonEncode(state.items));
    await prefs.setString('coupon', state.coupon ?? '');
  }

  /// --------------------
  /// Cart Actions
  /// --------------------
  void addItem(int productId) {
    final updated = {...state.items};
    updated[productId] = (updated[productId] ?? 0) + 1;

    state = state.copyWith(items: updated);
    _saveCart();
  }

  void removeItem(int productId) {
    final updated = {...state.items};
    if (!updated.containsKey(productId)) return;

    if (updated[productId] == 1) {
      updated.remove(productId);
    } else {
      updated[productId] = updated[productId]! - 1;
    }

    state = state.copyWith(items: updated);
    _saveCart();
  }

  /// --------------------
  /// Coupons
  /// --------------------
  void applyCoupon(String code, double subtotal) {
    if (state.coupon != null) return;

    final c = code.toUpperCase();

    final isValid =
        (c == 'SAVE10' && subtotal >= 500) ||
        (c == 'SAVE20' && subtotal >= 1000);

    if (isValid) {
      state = state.copyWith(coupon: c);
      _saveCart();
    }
  }

  void removeCoupon() {
    state = state.copyWith(clearCoupon: true);
    _saveCart();
  }
}
