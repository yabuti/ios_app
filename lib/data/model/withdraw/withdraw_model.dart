// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WithdrawModel extends Equatable {
  final int id;
  final int supplierId;
  final String method;
  final String totalAmount;
  final String withdrawAmount;
  final String withdrawCharge;
  final String accountInfo;
  final int status;
  final String approvedDate;
  final String createdAt;
  final String updatedAt;

  const WithdrawModel({
    required this.id,
    required this.supplierId,
    required this.method,
    required this.totalAmount,
    required this.withdrawAmount,
    required this.withdrawCharge,
    required this.accountInfo,
    required this.status,
    required this.approvedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  WithdrawModel copyWith({
    int? id,
    int? supplierId,
    String? method,
    String? totalAmount,
    String? withdrawAmount,
    String? withdrawCharge,
    String? accountInfo,
    int? status,
    String? approvedDate,
    String? createdAt,
    String? updatedAt,
  }) {
    return WithdrawModel(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      method: method ?? this.method,
      totalAmount: totalAmount ?? this.totalAmount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      withdrawCharge: withdrawCharge ?? this.withdrawCharge,
      accountInfo: accountInfo ?? this.accountInfo,
      status: status ?? this.status,
      approvedDate: approvedDate ?? this.approvedDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'supplier_id': supplierId,
      'method': method,
      'total_amount': totalAmount,
      'withdraw_amount': withdrawAmount,
      'withdraw_charge': withdrawCharge,
      'account_info': accountInfo,
      'status': status,
      'approved_date': approvedDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory WithdrawModel.fromMap(Map<String, dynamic> map) {
    return WithdrawModel(
      id: map['id'] ?? 0,
      supplierId: map['supplier_id'] ?? 0,
      method: map['method'] ?? '',
      totalAmount: map['total_amount'] ?? '',
      withdrawAmount: map['withdraw_amount'] ?? '',
      withdrawCharge: map['withdraw_charge'] ?? '',
      accountInfo: map['account_info'] ?? '',
      status: map['status'] ?? 0,
      approvedDate: map['approved_date'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawModel.fromJson(String source) =>
      WithdrawModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      supplierId,
      method,
      totalAmount,
      withdrawAmount,
      withdrawCharge,
      accountInfo,
      status,
      approvedDate,
      createdAt,
      updatedAt,
    ];
  }
}
