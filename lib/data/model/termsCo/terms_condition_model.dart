// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TermsModel extends Equatable {
  final int id;
  final String langCode;
  final String description;
  final String createdAt;
  final String updatedAt;
  const TermsModel({
    required this.id,
    required this.langCode,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  TermsModel copyWith({
    int? id,
    String? langCode,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return TermsModel(
      id: id ?? this.id,
      langCode: langCode ?? this.langCode,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lang_code': langCode,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory TermsModel.fromMap(Map<String, dynamic> map) {
    return TermsModel(
      id: map['id'] ?? 0,
      langCode: map['lang_code'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TermsModel.fromJson(String source) => TermsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      langCode,
      description,
      createdAt,
      updatedAt,
    ];
  }
}
