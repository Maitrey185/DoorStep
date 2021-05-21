// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailedProductAdapter extends TypeAdapter<DetailedProduct> {
  @override
  final int typeId = 1;

  @override
  DetailedProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailedProduct(
      id: fields[0] as dynamic,
      description: fields[3] as dynamic,
      productImage: fields[1] as dynamic,
      model: fields[2] as dynamic,
      price: fields[5] as dynamic,
      reviews: fields[4] as dynamic,
      dimensions: fields[6] as dynamic,
      rating: fields[7] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, DetailedProduct obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productImage)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.reviews)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.dimensions)
      ..writeByte(7)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailedProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
