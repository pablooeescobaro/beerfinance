import 'package:beer_app/data/dto/finance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spending.g.dart';

enum SpendingCategoryEnum {
  PRODUCTS,
  ENTERTAINMENT,
  TRANSPORT,
  HOMEPRODUCTS,
  OTHER
}

final SpendingCategoryEnumMap = {
  'Продукты': SpendingCategoryEnum.PRODUCTS,
  'Развлечения': SpendingCategoryEnum.ENTERTAINMENT,
  'Транспорт': SpendingCategoryEnum.TRANSPORT,
  'Товары для дома': SpendingCategoryEnum.HOMEPRODUCTS,
  'Другое': SpendingCategoryEnum.OTHER,
};

@JsonSerializable()
class SpendingModel {
  String? id;
  int? amount;
  String? name;
  SpendingCategoryEnum? category;
  FinanceTypeEnum? type;
  int? date;

  SpendingModel(
      {this.id, this.amount, this.name, this.category, this.type, this.date});

  factory SpendingModel.fromJson(Map<String, dynamic> json) =>
      _$SpendingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpendingModelToJson(this);
}

@JsonSerializable()
class ListSpending {
  List<SpendingModel>? data;

  ListSpending({this.data});

  factory ListSpending.fromJson(Map<String, dynamic> json) =>
      _$ListSpendingFromJson(json);

  Map<String, dynamic> toJson() => _$ListSpendingToJson(this);
}
