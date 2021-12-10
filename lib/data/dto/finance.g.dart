// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceModel _$FinanceModelFromJson(Map<String, dynamic> json) => FinanceModel(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      name: json['name'] as String?,
      type: $enumDecodeNullable(_$FinanceTypeEnumEnumMap, json['type']),
      date: json['date'] as int?,
    );

Map<String, dynamic> _$FinanceModelToJson(FinanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'name': instance.name,
      'type': _$FinanceTypeEnumEnumMap[instance.type],
      'date': instance.date,
    };

const _$FinanceTypeEnumEnumMap = {
  FinanceTypeEnum.INCOME: 'INCOME',
  FinanceTypeEnum.SPENDING: 'SPENDING',
  FinanceTypeEnum.SAVING: 'SAVING',
};

ListFinance _$ListFinanceFromJson(Map<String, dynamic> json) => ListFinance(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FinanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListFinanceToJson(ListFinance instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AllFinanceModel _$AllFinanceModelFromJson(Map<String, dynamic> json) =>
    AllFinanceModel(
      allIncome: (json['allIncome'] as num?)?.toDouble() ?? 0,
      allSpending: (json['allSpending'] as num?)?.toDouble() ?? 0,
      allSavings: (json['allSavings'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AllFinanceModelToJson(AllFinanceModel instance) =>
    <String, dynamic>{
      'allIncome': instance.allIncome,
      'allSpending': instance.allSpending,
      'allSavings': instance.allSavings,
    };
