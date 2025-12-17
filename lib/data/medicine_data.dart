
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcart/models/medicine.dart';

final medicinesProvider = Provider<List<MedicineModel>>((ref) {
  return [
    MedicineModel(
      id: 1,
      name: 'Paracetamol 500mg',
      price: 50,
      image: 'assets/images/med.jpg',
    ),
    MedicineModel(
      id: 2,
      name: 'Vitamin C Tablets',
      price: 120,
      image: 'assets/images/med.jpg',
    ),
    MedicineModel(
      id: 3,
      name: 'Blood Pressure Monitor',
      price: 1800,
      image: 'assets/images/med.jpg',
    ),
    MedicineModel(
      id: 4,
      name: 'Thermometer',
      price: 300,
      image: 'assets/images/med.jpg',
    ),
  ];
});
