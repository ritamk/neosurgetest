// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class GoalModel extends Equatable {
  final String planName;
  final DateTime targetDate;
  final double targetAmount;
  const GoalModel({
    required this.planName,
    required this.targetDate,
    required this.targetAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planName': planName,
      'targetDate': targetDate.millisecondsSinceEpoch,
      'targetAmount': targetAmount,
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      planName: map['planName'] as String,
      targetDate: DateTime.fromMillisecondsSinceEpoch(map['targetDate'] as int),
      targetAmount: map['targetAmount'] as double,
    );
  }

  @override
  List<Object> get props => [planName, targetDate, targetAmount];
}
