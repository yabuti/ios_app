import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/home_repository.dart';
import '../../../presentation/errors/failure.dart';
import 'package:dartz/dartz.dart';

// --------------- STATE ----------------
class PreOrderState {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  PreOrderState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  PreOrderState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return PreOrderState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// --------------- CUBIT ----------------
class PreOrderCubit extends Cubit<PreOrderState> {
  final HomeRepository repository;

  PreOrderCubit({required this.repository}) : super(PreOrderState());

  Future<void> submit({
    required String name,
    required String phone,
    required String deliveryDate,
    required String type, // 'preOrder', 'delivery', 'sparePart'
  }) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: ''));

    try {
      final Either<Failure, String> response = await repository.submitPreOrder(
        name: name,
        phone: phone,
        deliveryDate: deliveryDate,
        type: type,
      );

      response.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Error submitting request'));
    }
  }
}
