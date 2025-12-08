// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:carsbnb/logic/cubit/kyc/kyc_info_state.dart';
import 'package:equatable/equatable.dart';

class KYCModel extends Equatable {
final Kyc? kyc;
final List<KycType>? kycType;
final KycInfoState kycInfoState;
  const KYCModel({
    this.kyc,
    this.kycType,
    this.kycInfoState = const KycInfoState(),
  });

  KYCModel copyWith({
    Kyc? kyc,
    List<KycType>? kycType,
    KycInfoState? kycInfoState,
  }) {
    return KYCModel(
      kyc: kyc ?? this.kyc,
      kycType: kycType ?? this.kycType,
      kycInfoState: kycInfoState ?? this.kycInfoState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kyc': kyc?.toMap(),
      'kycType': kycType?.map((x) => x.toMap()).toList(),
    };
  }

  factory KYCModel.fromMap(Map<String, dynamic> map) {
    return KYCModel(
      kyc: map['kyc'] != null ? Kyc.fromMap(map['kyc'] as Map<String,dynamic>) : null,
      kycType: map['kycType'] != null ? List<KycType>.from((map['kycType'] as List<dynamic>).map<KycType?>((x) => KycType.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KYCModel.fromJson(String source) => KYCModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [kyc!, kycType!,kycInfoState];
}

class Kyc extends Equatable {
  final int id;
  final int kycId;
  final int userId;
  final String file;
  final String message;
  final int status;
  final String createdAt;
  final String updatedAt;
  const Kyc({
    required this.id,
    required this.kycId,
    required this.userId,
    required this.file,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Kyc copyWith({
    int? id,
    int? kycId,
    int? userId,
    String? file,
    String? message,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return Kyc(
      id: id ?? this.id,
      kycId: kycId ?? this.kycId,
      userId: userId ?? this.userId,
      file: file ?? this.file,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'kyc_id': kycId,
      'user_id': userId,
      'file': file,
      'message': message,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Kyc.fromMap(Map<String, dynamic> map) {
    return Kyc(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id']?.toString() ?? '0') ?? 0,
      kycId: map['kyc_id'] is int ? map['kyc_id'] : int.tryParse(map['kyc_id']?.toString() ?? '0') ?? 0,
      userId: map['user_id'] is int ? map['user_id'] : int.tryParse(map['user_id']?.toString() ?? '0') ?? 0,
      file: map['file']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
      status: map['status'] is int ? map['status'] : int.tryParse(map['status']?.toString() ?? '0') ?? 0,
      createdAt: map['createdAt']?.toString() ?? map['created_at']?.toString() ?? '',
      updatedAt: map['updatedAt']?.toString() ?? map['updated_at']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Kyc.fromJson(String source) => Kyc.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      kycId,
      userId,
      file,
      message,
      status,
      createdAt,
      updatedAt,
    ];
  }
}


class KycType extends Equatable {
  final int id;
  final String name;
  final int status;
  final String createdAt;
  final String updatedAt;
  const KycType({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  KycType copyWith({
    int? id,
    String? name,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return KycType(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory KycType.fromMap(Map<String, dynamic> map) {
    return KycType(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id']?.toString() ?? '0') ?? 0,
      name: map['name']?.toString() ?? '',
      status: map['status'] is int ? map['status'] : int.tryParse(map['status']?.toString() ?? '0') ?? 0,
      createdAt: map['createdAt']?.toString() ?? map['created_at']?.toString() ?? '',
      updatedAt: map['updatedAt']?.toString() ?? map['updated_at']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory KycType.fromJson(String source) => KycType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
