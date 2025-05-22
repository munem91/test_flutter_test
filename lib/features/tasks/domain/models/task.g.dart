// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String,
      type: $enumDecode(_$TaskTypeEnumMap, json['type']),
      level: (json['level'] as num).toInt(),
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'type': _$TaskTypeEnumMap[instance.type]!,
      'level': instance.level,
      'explanation': instance.explanation,
    };

const _$TaskTypeEnumMap = {
  TaskType.timeCalculation: 'timeCalculation',
  TaskType.directionAngle: 'directionAngle',
  TaskType.fuelConsumption: 'fuelConsumption',
  TaskType.cargoBalance: 'cargoBalance',
};
