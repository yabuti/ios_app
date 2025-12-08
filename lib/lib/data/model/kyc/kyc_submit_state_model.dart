import 'dart:convert';
import 'package:carsbnb/logic/cubit/kyc/kyc_info_state.dart';
import 'package:equatable/equatable.dart';

class KycSubmitStateModel extends Equatable {
  final String id;
  final String file;
  final String tempFile;
  final String message;
  final KycInfoState kycInfoState;

  const KycSubmitStateModel({
    this.id = '',
    this.file = '',
    this.tempFile = '',
    this.message = '',
    this.kycInfoState = const KycInfoInitial(),
  });

  KycSubmitStateModel copyWith({
    String? id,
    String? file,
    String? tempFile,
    String? message,
    KycInfoState? kycInfoState,
  }) {
    return KycSubmitStateModel(
      id: id ?? this.id,
      file: file ?? this.file,
      tempFile: tempFile ?? this.tempFile,
      message: message ?? this.message,
      kycInfoState: kycInfoState ?? this.kycInfoState,
    );
  }

  Map<String, String> toMap() {
    final result = <String, String>{};
    result.addAll({'kyc_id': id});
    result.addAll({'file': file});
    result.addAll({'message': message});
    return result;
  }

  factory KycSubmitStateModel.fromMap(Map<String, dynamic> map) {
    return KycSubmitStateModel(
      id: map['kyc_id'] ?? 0,
      file: map['file'] ?? '',
      message: map['message'] ?? '',
    );
  }

  static KycSubmitStateModel init() {
    return const KycSubmitStateModel(
      id: '',
      file: '',
      message: '',
      kycInfoState: KycInfoInitial(),
    );
  }

  static KycSubmitStateModel reset() {
    return const KycSubmitStateModel(
      id: '',
      file: '',
      message: '',
      kycInfoState: KycInfoInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory KycSubmitStateModel.fromJson(String source) =>
      KycSubmitStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, file, message,tempFile,kycInfoState];
}
