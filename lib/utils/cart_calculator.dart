import '../models/medicine.dart';

class CartCalculator {
  // sub total claculation
  static double subtotal(
    Map<int, int> cartItems,
    List<MedicineModel> medicines,
  ) {
    double total = 0;
    for (var entry in cartItems.entries) {
      final medicine = medicines.firstWhere(
        (medicnes) => medicnes.id == entry.key,
        orElse: () => throw 'Medicne not found',
      );
      total += medicine.price * entry.value;
    }
    return total;
  }

  // coupon code handling
  static double discount(String? coupon, double subtotal) {
    switch (coupon) {
      case 'SAVE10':
        return subtotal * 0.10;
      case 'SAVE20':
        return subtotal * 0.20;
      default:
        return 0;
    }
  }
}
