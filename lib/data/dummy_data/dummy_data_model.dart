import 'package:equatable/equatable.dart';

class DuplicateBooking extends Equatable{
  final String id;
  final String name;

  const DuplicateBooking(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}

final List<DuplicateBooking> duplicateBook = [
const DuplicateBooking("enable", "Enable"),
const DuplicateBooking("disable", "Disable"),
];


class AcType extends Equatable{
  final String id;
  final String name;

  const AcType(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}

final List<AcType> acType = [
  const AcType("ac", "AC"),
  const AcType("non_ac", "NON AC"),
];

class Capacity extends Equatable{
  final int id;
  final String name;

  const Capacity(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}

final List<Capacity> capacityList = [
  const Capacity(4, "1-4 Seat"),
  const Capacity(6, "1-6 Seat"),
  const Capacity(8, "1-8 Seat"),
];

class Rating extends Equatable{
  final int id;
  final int name;

  const Rating(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}

final List<Rating> ratingList = [
  const Rating(1, 1),
  const Rating(2, 2),
  const Rating(3, 3),
  const Rating(4, 4),
  const Rating(5, 5),

];

class Condition extends Equatable{
  final String id;
  final String name;

  const Condition(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}

final List<Condition> conditionList = [
  const Condition("used", "Used"),
  const Condition("new", "New"),
];

class SellerType extends Equatable{
  final String id;
  final String name;

  const SellerType(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}

final List<SellerType> sellerList = [
  const SellerType("dealer", "Dealer"),
  const SellerType("individual", "Individual"),
];