import 'package:beer_app/data/dto/finance.dart';
import 'package:beer_app/styles.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spending.g.dart';

enum SpendingCategoryEnum {
  PRODUCTS,
  ENTERTAINMENT,
  TRANSPORT,
  HOMEPRODUCTS,
  OTHER
}

List spendingNames = [
  'Продукты',
  'Развлечения',
  'Транспорт',
  'Товары для дома',
  'Другое',
];

List spendingColors = [
  BC.spending1,
  BC.spending2,
  BC.spending3,
  BC.spending4,
  BC.spending5,
];

final SpendingCategoryEnumMap = {
  'Продукты': SpendingCategoryEnum.PRODUCTS,
  'Развлечения': SpendingCategoryEnum.ENTERTAINMENT,
  'Транспорт': SpendingCategoryEnum.TRANSPORT,
  'Товары для дома': SpendingCategoryEnum.HOMEPRODUCTS,
  'Другое': SpendingCategoryEnum.OTHER,
};

final SpendingCategoryEnumReverse = {
  SpendingCategoryEnum.PRODUCTS: 'Продукты',
  SpendingCategoryEnum.ENTERTAINMENT: 'Развлечения',
  SpendingCategoryEnum.TRANSPORT: 'Транспорт',
  SpendingCategoryEnum.HOMEPRODUCTS: 'Товары для дома',
  SpendingCategoryEnum.OTHER: 'Другое',
};

@JsonSerializable()
class SpendingModel {
  String? id;
  double? amount;
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

  ListFinance toFinanceList(ListSpending? listSpending) {
    final list = <FinanceModel>[];
    if (listSpending != null && listSpending.data != null) {
      for (var e in listSpending.data ?? []) {
        list.add(FinanceModel(
            id: e.id,
            name: e.name,
            type: e.type,
            amount: e.amount,
            date: e.date));
      }
      return ListFinance(data: list);
    } else {
      return ListFinance();
    }
  }
}
