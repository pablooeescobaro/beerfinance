// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpendingModel _$SpendingModelFromJson(Map<String, dynamic> json) =>
    SpendingModel(
      id: json['id'] as String?,
      amount: json['amount'] as int?,
      name: json['name'] as String?,
      category:
          $enumDecodeNullable(_$SpendingCategoryEnumEnumMap, json['category']),
      type: $enumDecodeNullable(_$FinanceTypeEnumEnumMap, json['type']),
      date: json['date'] as int?,
    );

Map<String, dynamic> _$SpendingModelToJson(SpendingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'name': instance.name,
      'category': _$SpendingCategoryEnumEnumMap[instance.category],
      'type': _$FinanceTypeEnumEnumMap[instance.type],
      'date': instance.date,
    };

const _$SpendingCategoryEnumEnumMap = {
  SpendingCategoryEnum.PRODUCTS: 'PRODUCTS',
  SpendingCategoryEnum.ENTERTAINMENT: 'ENTERTAINMENT',
  SpendingCategoryEnum.TRANSPORT: 'TRANSPORT',
  SpendingCategoryEnum.HOMEPRODUCTS: 'HOMEPRODUCTS',
  SpendingCategoryEnum.OTHER: 'OTHER',
};

const _$FinanceTypeEnumEnumMap = {
  FinanceTypeEnum.INCOME: 'INCOME',
  FinanceTypeEnum.SPENDING: 'SPENDING',
  FinanceTypeEnum.SAVING: 'SAVING',
};

ListSpending _$ListSpendingFromJson(Map<String, dynamic> json) => ListSpending(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SpendingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListSpendingToJson(ListSpending instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
