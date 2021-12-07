// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceModel _$FinanceModelFromJson(Map<String, dynamic> json) => FinanceModel(
      id: json['id'] as String?,
      amount: json['amount'] as int?,
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
