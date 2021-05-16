import 'package:hive/hive.dart';
part 'detailed_product.g.dart';

@HiveType(typeId: 1)
class DetailedProduct {
  @HiveField(0)
  final id;
  @HiveField(1)
  final productImage;
  @HiveField(2)
  final model;
  @HiveField(3)
  final description;
  @HiveField(4)
  final reviews;
  @HiveField(5)
  final price;
  @HiveField(6)
  final dimensions;
  @HiveField(7)
  final rating;

  DetailedProduct(
      {this.id,
      this.description,
      this.productImage,
      this.model,
      this.price,
      this.reviews,
      this.dimensions,
      this.rating});
}
