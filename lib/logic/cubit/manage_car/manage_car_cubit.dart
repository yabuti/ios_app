import 'dart:developer';

import 'package:blackdiamondcar/data/model/car/car_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/car/getCarEditDataModel.dart';
import '../../../presentation/errors/failure.dart';
import '../../../utils/utils.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/user_carList_repository.dart';
import 'manage_car_state.dart';

class ManageCarCubit extends Cubit<CarsStateModel> {
  final UserCarListRepository _repository;
  final LoginBloc _loginBloc;

  ManageCarCubit({
    required UserCarListRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(CarsStateModel.init());

  // CarCreateDataModel? carCreateDataModel;
  CarEditDataModel? carEditDataModel;

  TextEditingController slugController = TextEditingController();

  void titleChange(String text) {
    emit(state.copyWith(
      title: text,
    ));
  }

  void purposeChange(String text) {
    emit(state.copyWith(
      purpose: text,
    ));
  }

  void brandIdChange(String text) {
    emit(state.copyWith(
      brandId: text,
    ));
  }

  void conditionChange(String text) {
    emit(state.copyWith(
      condition: text,
    ));
  }

  void cityIdChange(String text) {
    emit(state.copyWith(
      cityId: text,
    ));
  }

  void countryIdChange(String text) {
    emit(state.copyWith(
      countryId: text,
    ));
  }

  void minBookingDateChange(String text) {
    emit(state.copyWith(
      minBookingDate: text,
    ));
  }

  void slugChange(String text) {
    emit(state.copyWith(
      slug: text,
    ));
  }


  void regularPriceChange(String text) {
    print("regular$text");
    emit(state.copyWith(
      regularPrice: text,
    ));
  }

  void offerPriceChange(String text) {
    emit(state.copyWith(
      offerPrice: text,
    ));
  }

  void bodyTypeChange(String text) {
    emit(state.copyWith(
      bodyType: text,
    ));
  }

  void engineSizeChange(String text) {
    emit(state.copyWith(
      engineSize: text,
    ));
  }

  void driveChange(String text) {
    emit(state.copyWith(
      drive: text,
    ));
  }

  void interiorColorChange(String text) {
    emit(state.copyWith(
      interiorColor: text,
    ));
  }

  void exteriorColorChange(String text) {
    emit(state.copyWith(
      exteriorColor: text,
    ));
  }

  void yearChange(String text) {
    print("year$text");
    emit(state.copyWith(
      year: text,
    ));
  }

  void mileageChange(String text) {
    print("milage$text");
    emit(state.copyWith(
      mileage: text,
    ));

  }

  void numberOfOwnerChange(String text) {
    print("number of ow$text");
    emit(state.copyWith(
      numberOfOwner: text,
    ));

  }

  void fuelTypeChange(String text) {
    emit(state.copyWith(
      fuelType: text,
    ));
  }

  void transmissionChange(String text) {
    emit(state.copyWith(
      transmission: text,
    ));
  }

  void carModelChange(String text) {
    emit(state.copyWith(
      carModel: text,
    ));
  }

  void sellerTypeChange(String text) {
    emit(state.copyWith(
      sellerType: text,
    ));
  }

  void carTypeIdChange(String text) {
    emit(state.copyWith(
      carTypeId: text,
    ));
  }

  void descriptionChange(String text) {
    print("description $text");
    emit(state.copyWith(
      description: text,
    ));
  }

  void addressChange(String text) {
    emit(state.copyWith(
      address: text,
    ));
  }

  void googleMapChange(String text) {
    emit(state.copyWith(
      googleMap: text,
    ));
  }


  void seoTitleChange(String text) {
    emit(state.copyWith(
      seoTitle: text,
    ));
  }

  void seoDescriptionChange(String text) {
    emit(state.copyWith(
      seoDescription: text,
    ));
  }

  void thumbImageChange(String text) {
    emit(state.copyWith(
      thumbImage: text,
    ));
  }

  void videoImageChange(String text) {
    emit(state.copyWith(
      videoImage: text,
    ));
  }


  void videoDescriptionChange(String text) {
    emit(state.copyWith(
      videoDescription: text,
    ));
  }

  void videoIdChange(String text) {
    emit(state.copyWith(
      videoId: text,
    ));
  }

  void duplicateBookingChange(String text) {
    emit(state.copyWith(
      allowDuplicateBooking: text,
    ));
  }

  void acTypeChange(String text) {
    emit(state.copyWith(
      acCondation: text,
    ));
  }

  void translateIdChange(String text) {
    emit(state.copyWith(
      translateId: text,
    ));
  }

  void featureIdChange(List<String> selectedFeature) {
    emit(state.copyWith(
      features: selectedFeature,
    ));
  }



  void galleryImagesChange(List<String> images) {
    emit(state.copyWith(
      galleryImages: images,
    ));
  }




  void removeGalleryImage(String image) {
    final updatedImages = List<String>.from(state.galleryImages!);
    updatedImages.remove(image);
    emit(state.copyWith(
      galleryImages: updatedImages,
    ));
  }

  Future<void> addCar() async {
    log("car body: ${state.toMap()}");
    emit(state.copyWith(manageCarState: ManageCarAddStateLoading()));
    final uri = Utils.tokenWithCode(RemoteUrls.createCar,
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode);
    final result = await _repository.addCars(state, uri);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = ManageCarAddFormValidate(failure.errors);
        emit(state.copyWith(manageCarState: errors));
      } else {
        final errors =
            ManageCarAddStateError(failure.message, failure.statusCode);
        emit(state.copyWith(manageCarState: errors));
      }
    }, (success) {
      final errors = ManageCarAddStateSuccess(success);
      emit(state.copyWith(manageCarState: errors));
    });
  }



  Future<void> updateBasicCar(String id) async {
    log("car update body: ${state.toMap()}");
    emit(state.copyWith(manageCarState: ManageCarAddStateLoading()));
    final uri = Utils.tokenWithQuery(RemoteUrls.updateBasicCar(id),
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode,
        extraParams: {'_method':'PUT'}
    );
    final result = await _repository.updateBasicCar(state, uri);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = ManageCarAddFormValidate(failure.errors);
        emit(state.copyWith(manageCarState: errors));
      } else {
        final errors =
        ManageCarAddStateError(failure.message, failure.statusCode);
        emit(state.copyWith(manageCarState: errors));
      }
    }, (success) {
      final errors = ManageCarAddStateSuccess(success);
      emit(state.copyWith(manageCarState: errors));
    });
  }

/// key Feature
  Future<void> keyFeatureUpdateCar(String id) async {
    log("car keyfeature body: ${state.toMap()}");
    emit(state.copyWith(manageCarState: ManageCarAddStateLoading()));
    final uri = Utils.tokenWithCode(RemoteUrls.keyFeatureUpdateCar(id),
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode);
    //extraParams: {'_method':'PUT'}
    print("key feature $uri");
    final result = await _repository.keyFeatureUpdateCars(state, uri);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = ManageCarAddFormValidate(failure.errors);
        emit(state.copyWith(manageCarState: errors));
      } else {
        final errors =
        ManageCarAddStateError(failure.message, failure.statusCode);
        emit(state.copyWith(manageCarState: errors));
      }
    }, (success) {
      final errors = ManageCarAddStateSuccess(success);
      emit(state.copyWith(manageCarState: errors));
    });
  }

  /// feature

  Future<void> featureUpdateCar(String id) async {
    log("car update body: ${state.toMap()}");
    emit(state.copyWith(manageCarState: ManageCarAddStateLoading()));
    final uri = Utils.tokenWithCode(RemoteUrls.featureUpdateCar(id),
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode);
    //extraParams: {'_method':'PUT'}
    print("key feature $uri");
    final result = await _repository.featureUpdateCars(state, uri);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = ManageCarAddFormValidate(failure.errors);
        emit(state.copyWith(manageCarState: errors));
      } else {
        final errors =
        ManageCarAddStateError(failure.message, failure.statusCode);
        emit(state.copyWith(manageCarState: errors));
      }
    }, (success) {
      final errors = ManageCarAddStateSuccess(success);
      emit(state.copyWith(manageCarState: errors));
    });
  }

  /// address

  Future<void> addressUpdateCar(String id) async {
    log("car update body: ${state.toMap()}");
    emit(state.copyWith(manageCarState: ManageCarAddStateLoading()));
    final uri = Utils.tokenWithCode(RemoteUrls.addressUpdateCar(id),
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode);
    //extraParams: {'_method':'PUT'}
    print("key feature $uri");
    final result = await _repository.addressUpdateCars(state, uri);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = ManageCarAddFormValidate(failure.errors);
        emit(state.copyWith(manageCarState: errors));
      } else {
        final errors =
        ManageCarAddStateError(failure.message, failure.statusCode);
        emit(state.copyWith(manageCarState: errors));
      }
    }, (success) {
      final errors = ManageCarAddStateSuccess(success);
      emit(state.copyWith(manageCarState: errors));
    });
  }

/// Gallery
  Future<void> galleryUpdateCar(String id) async {
    log("car gallery body: ${state.toMap()}");
    emit(state.copyWith(manageCarState: ManageCarAddStateLoading()));
    final uri = Utils.tokenWithCode(RemoteUrls.galleryUpdateCar(id),
        _loginBloc.userInformation!.accessToken, _loginBloc.state.languageCode);
    //extraParams: {'_method':'PUT'}
    print("Gallery  $uri");
    final result = await _repository.galleryUpdateCars(state, uri);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = ManageCarAddFormValidate(failure.errors);
        emit(state.copyWith(manageCarState: errors));
      } else {
        final errors =
        ManageCarAddStateError(failure.message, failure.statusCode);
        emit(state.copyWith(manageCarState: errors));
      }
    }, (success) {
      final errors = ManageCarAddStateSuccess(success);
      emit(state.copyWith(manageCarState: errors));
    });
  }

  /// get car create data

  // Future<void> getCarCreateData() async {
  //   print("call get create car data");
  //   emit(state.copyWith(manageCarState: GetCarCreateDataLoading()));
  //   final uri = Utils.tokenWithCode(
  //     RemoteUrls.getCarCreateData,
  //     _loginBloc.userInformation!.accessToken,
  //     _loginBloc.state.languageCode,
  //   );
  //   final result = await _repository.getCarCreateData(uri);
  //   result.fold((failure) {
  //     final errorState =
  //         GetCarCreateDataError(failure.message, failure.statusCode);
  //     emit(state.copyWith(manageCarState: errorState));
  //   }, (success) {
  //     carCreateDataModel = success;
  //     final successState = GetCarCreateDataLoaded(success);
  //
  //     emit(state.copyWith(manageCarState: successState));
  //   });
  // }

  Future<void> getCarEditData(String id) async {
    emit(state.copyWith(manageCarState: GetCarEditDataLoading()));
    final uri = Utils.tokenWithCode(
      RemoteUrls.getEditCarData(id),
      _loginBloc.userInformation!.accessToken,
      _loginBloc.state.languageCode,
    );
    print("edit car : $uri");
    final result = await _repository.getCarEditData(uri);
    result.fold((failure) {
      final errorState =
          GetCarEditDataError(failure.message, failure.statusCode);
      emit(state.copyWith(manageCarState: errorState));
    }, (success) {
      carEditDataModel = success;
      if (carEditDataModel != null) {
        emit(state.copyWith(
          title: carEditDataModel!.car!.title,
          slug: Utils.convertToSlug(carEditDataModel!.car!.slug),
          brandId: carEditDataModel!.car!.brandId.toString(),
          condition: carEditDataModel!.car!.condition.toString(),
          regularPrice: carEditDataModel!.car!.regularPrice,
          offerPrice: carEditDataModel!.car!.offerPrice,
          description: carEditDataModel!.car!.description,
          seoTitle: carEditDataModel!.car!.seoTitle,
          seoDescription: carEditDataModel!.car!.seoDescription,

          bodyType: carEditDataModel!.car!.bodyType,
          engineSize: carEditDataModel!.car!.engineSize,
          drive: carEditDataModel!.car!.drive,
          interiorColor: carEditDataModel!.car!.interiorColor,
          exteriorColor: carEditDataModel!.car!.exteriorColor,
          year: carEditDataModel!.car!.year,
          mileage: carEditDataModel!.car!.mileage,
          numberOfOwner: carEditDataModel!.car!.numberOfOwner,
          fuelType: carEditDataModel!.car!.fuelType,
          transmission: carEditDataModel!.car!.transmission,

          //features: carEditDataModel!.car!.features,

          address: carEditDataModel!.car!.address,
          cityId: carEditDataModel!.car!.cityId.toString(),
          googleMap: carEditDataModel!.car!.googleMap,


          tempImage: carEditDataModel!.car!.thumbImage,
          tempVideoImage: carEditDataModel!.car!.videoImage,
          videoDescription: carEditDataModel!.car!.videoDescription,
          videoId: carEditDataModel!.car!.videoId,
        ));
        slugController.text = Utils.convertToSlug(carEditDataModel!.car!.slug);
      }

      final successState = GetCarEditDataLoaded(success);

      emit(state.copyWith(manageCarState: successState));
    });
  }

  Future<void> clearAllField() async {
    emit(CarsStateModel.reset());
  }

  void clearStep2Fields() {
    emit(state.copyWith(
      sellerType: '',
      bodyType: '',
      engineSize: '',
      drive: '',
      interiorColor: '',
      exteriorColor: '',
      year: '',
      mileage: '',
      numberOfOwner: '',
      fuelType: '',
      transmission: '',
    ));
  }
}
