// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavingModel _$SavingModelFromJson(Map<String, dynamic> json) => SavingModel(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      name: json['name'] as String?,
      type: $enumDecodeNullable(_$FinanceTypeEnumEnumMap, json['type']),
      date: json['date'] as int?,
    );

Map<String, dynamic> _$SavingModelToJson(SavingModel instance) =>
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

ListSaving _$ListSavingFromJson(Map<String, dynamic> json) => ListSaving(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SavingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListSavingToJson(ListSaving instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
