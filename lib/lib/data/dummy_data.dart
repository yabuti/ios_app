import 'package:equatable/equatable.dart';

class DummyCategoryModel extends Equatable {
  final String id;
  final String name;

  const DummyCategoryModel({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

final List<DummyCategoryModel> locationList = [
  const DummyCategoryModel(id: '0', name: 'Dhaka'),
  const DummyCategoryModel(id: '1', name: 'Dhaka'),
  const DummyCategoryModel(id: '2', name: 'Dhaka'),
  const DummyCategoryModel(id: '3', name: 'Dhaka'),
  const DummyCategoryModel(id: '4', name: 'Dhaka'),
  const DummyCategoryModel(id: '5', name: 'Dhaka'),
];

