// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeModel _$IncomeModelFromJson(Map<String, dynamic> json) => IncomeModel(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      name: json['name'] as String?,
      category:
          $enumDecodeNullable(_$IncomeCategoryEnumEnumMap, json['category']),
      type: $enumDecodeNullable(_$FinanceTypeEnumEnumMap, json['type']),
      date: json['date'] as int?,
    );

Map<String, dynamic> _$IncomeModelToJson(IncomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'name': instance.name,
      'category': _$IncomeCategoryEnumEnumMap[instance.category],
      'type': _$FinanceTypeEnumEnumMap[instance.type],
      'date': instance.date,
    };

const _$IncomeCategoryEnumEnumMap = {
  IncomeCategoryEnum.MAININCOME: 'MAININCOME',
  IncomeCategoryEnum.SIDEINCOME: 'SIDEINCOME',
};

const _$FinanceTypeEnumEnumMap = {
  FinanceTypeEnum.INCOME: 'INCOME',
  FinanceTypeEnum.SPENDING: 'SPENDING',
  FinanceTypeEnum.SAVING: 'SAVING',
};

ListIncome _$ListIncomeFromJson(Map<String, dynamic> json) => ListIncome(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => IncomeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListIncomeToJson(ListIncome instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
