import 'dart:convert';
import 'dart:developer'; // for log()

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/errors/exception.dart'; // contains ServerException, InvalidAuthData
import 'network_parser.dart';

import '../model/auth/login_state_model.dart';
import '../model/auth/register_state_model.dart';
import '../model/auth/user_response_model.dart';
import '../model/car/car_state_model.dart';
import '../model/kyc/kyc_submit_state_model.dart';
import '../../logic/cubit/forgot_password/forgot_password_state_model.dart';
import 'package:blackdiamondcar/data/data_provider/remote_url.dart';
import '../../presentation/errors/exception.dart' as ex;
import '../../../presentation/errors/errors_model.dart';

abstract class RemoteDataSources {
  Future getWebsiteSetup(Uri uri);

  Future getHomeData(String langCode);

  Future getAllCarsList(Uri url);

  Future getAllDealerList(Uri url);

  Future getCarsDetails(String langCode, String id);

  Future contactDealer(String langCode, String id, Map<String, dynamic> body);

  Future contactMessage(String langCode, Map<String, dynamic> body);

  Future getDealerDetails(String langCode, String userName);

  Future login(LoginStateModel body);
  Future<Map<String, dynamic>> register(RegisterStateModel body);

  Future otpVerify(RegisterStateModel body);

  Future forgotOtpVerify(PasswordStateModel body);

  Future forgotPassword(PasswordStateModel body);

  Future setResetPassword(PasswordStateModel body);

  Future updatePassword(PasswordStateModel body, Uri url);

  Future logout(Uri uri);

  Future getWishList(Uri url);

  Future addWishList(Uri url);

  Future removeWishList(Uri url);

  Future removeCompareList(Uri url);

  Future getBookingHistoryList(Uri url);

  Future getBookingHistoryDetails(Uri url, String id);

  Future getBookingHistoryCancel(Uri url, String id);

  Future startRide(Uri url, String id);

  Future getTransactionsList(Uri url);

  Future getUserDashboard(Uri url);

  Future getUserWithdraw(Uri url);

  Future getBookingRequest(Uri url);

  Future getUserCarList(Uri url);

  Future getCarCreateData(Uri url);

  Future getCarEditData(Uri url);

  Future addCar(CarsStateModel body, Uri url);

  Future updateBasicCar(CarsStateModel body, Uri url);

  Future keyFeatureUpdateCar(CarsStateModel body, Uri url);
  Future featureUpdateCar(CarsStateModel body, Uri url);
  Future addressUpdateCar(CarsStateModel body, Uri url);
  Future galleryUpdateCar(CarsStateModel body, Uri url);
  Future<String> submitPreOrder({
    int? carId,
    String? category, // optional
    int? cityId,
    int? countryId,
    required String deliveryDate,
    required String name,
    required String phone,
    String? requestedVehicle, // optional
    required String type,
    String? userMessage,
  });

  Future deleteCar(Uri url);

  Future getKycInfo(Uri url);

  Future<String> submitKycVerify(Uri url, KycSubmitStateModel data);

  Future getAllReview(Uri url);

  Future getTermsCondition(String langCode);
  Future getPrivacyPolicy(String langCode);

  Future getProfileData(Uri url);

  Future updateProfile(User body, Uri url);

  Future getSearchAttribute(Uri url);

  Future getCity(Uri url, String id);

  Future getDealerCity(Uri url);

  Future getCompareList(Uri url);

  Future subscriptionPlanList(Uri url);

  Future paymentInfo(Uri url);

  Future freePlanEnroll(String id, Uri url);

  Future storeReview(Uri url, Map<String, dynamic> body);

  Future addCompareList(Uri url, Map<String, dynamic> body);

  Future payWithStripe(Uri url, Map<String, dynamic> body);

  Future payWithBank(Uri url, Map<String, dynamic> body);
  Future<List<String>> getSparePartCategories();
  Future transactionList(Uri url);
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourcesImpl extends RemoteDataSources {
  final http.Client client;

  RemoteDataSourcesImpl({required this.client});
  Future<Map<String, String>> _authHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';

    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, String>> _authMultipartHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';

    return {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }
  // --- END PUT HERE ---

  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  final postDeleteHeader = {
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };
  @override
  Future<String> submitPreOrder({
    int? carId,
    String? category,
    int? cityId,
    int? countryId,
    required String deliveryDate,
    required String name,
    required String phone,
    String? requestedVehicle,
    required String type,
    String? userMessage,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse(RemoteUrls.preOrder);

    final body = {
      'user_name': name,
      'user_phone': phone,
      'type': type,
      if (category != null) 'category': category,
      if (requestedVehicle != null) 'requested_vehicle': requestedVehicle,
      if (countryId != null) 'country_id': countryId.toString(),
      if (cityId != null) 'city_id': cityId.toString(),
      if (carId != null) 'car_id': carId.toString(),
      'preferred_delivery_date': deliveryDate,
      if (userMessage != null) 'user_message': userMessage,
    };

    try {
      final response = await client.post(
        uri,
        headers: await _authHeaders(),
        body: jsonEncode(body),
      );

      final responseJson = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseJson['message'] ?? 'Pre-order submitted successfully!';
      } else if (response.statusCode == 422) {
        return 'Validation failed: ${responseJson.toString()}';
      } else {
        return 'Failed to submit pre-order. Status: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error submitting pre-order: $e';
    }
  }

  @override
  Future<List<String>> getSparePartCategories() async {
    final uri = Uri.parse(RemoteUrls.sparePartCategories);

    final clientMethod = client.get(uri, headers: await _authHeaders());

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    if (responseJsonBody['data'] != null) {
      final List<dynamic> categories = responseJsonBody['data'];
      return List<String>.from(categories.map((e) => e.toString()));
    } else {
      throw ServerException('Failed to load spare part categories');
    }
  }

  @override
  Future<Map<String, dynamic>> login(LoginStateModel body) async {
    try {
      final uri = Uri.parse(RemoteUrls.login)
          .replace(queryParameters: {'lang_code': body.languageCode});

      log("🔐 Login URL: $uri", name: 'RemoteDataSources');
      log("🔐 Login attempt - Phone: ${body.phone}", name: 'RemoteDataSources');

      // Add timeout to prevent infinite loading
      final response = await client
          .post(
            uri,
            body: jsonEncode({
              'phone': body.phone,
              'password': body.password,
            }),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
            },
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              log("⏱️ Login request timed out!", name: 'RemoteDataSources');
              throw ServerException("Request timed out. Please check your internet connection.", 408);
            },
          );

      log("🔐 Login HTTP status: ${response.statusCode}", name: 'RemoteDataSources');
      log("🔐 Login raw response: ${response.body}", name: 'RemoteDataSources');

      final responseJsonBody = jsonDecode(response.body);

      log("🔐 Login parsed response: $responseJsonBody", name: 'RemoteDataSources');

      // Handle HTTP errors - Laravel returns 'error' field
      if (response.statusCode == 422) {
        log("❌ Login validation errors", name: 'RemoteDataSources');
        throw InvalidInputException(Errors.fromMap(responseJsonBody['errors']));
      } else if (response.statusCode >= 400) {
        // Laravel returns 'error' instead of 'message'
        final errorMsg = responseJsonBody['error'] ?? 
                        responseJsonBody['message'] ?? 
                        'Login failed';
        log("❌ Login error: $errorMsg", name: 'RemoteDataSources');
        throw ServerException(errorMsg, response.statusCode);
      }

      // Handle backend validation errors
      if (responseJsonBody['errors'] != null) {
        throw InvalidInputException(Errors.fromMap(responseJsonBody['errors']));
      }
      
      // Handle 'error' field in response (even with 200 status)
      if (responseJsonBody['error'] != null) {
        final errorMsg = responseJsonBody['error'].toString();
        log("❌ Login error in response: $errorMsg", name: 'RemoteDataSources');
        throw ServerException(errorMsg, response.statusCode);
      }

      // Save token if login succeeded. Backend may return token under
      // different keys ('token', 'access_token') or nested under 'data'.
      final prefs = await SharedPreferences.getInstance();
      final dynamic rawToken = responseJsonBody['token'] ??
          responseJsonBody['access_token'] ??
          (responseJsonBody['data'] is Map ? responseJsonBody['data']['access_token'] : null);

      if (rawToken != null && rawToken.toString().isNotEmpty) {
        final tokenStr = rawToken.toString();
        await prefs.setString('accessToken', tokenStr);
        log("✅ Token saved: ${tokenStr.substring(0, 20)}...", name: 'RemoteDataSources');
      } else {
        log("⚠️ WARNING: No token found in response!", name: 'RemoteDataSources');
      }

      log("✅ Login successful!", name: 'RemoteDataSources');
      return responseJsonBody as Map<String, dynamic>;
    } on InvalidInputException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e, stackTrace) {
      log("❌ Login unexpected error: $e", name: 'RemoteDataSources', error: e, stackTrace: stackTrace);
      throw ServerException("Login failed: $e", 500);
    }
  }

  @override
  Future<Map<String, dynamic>> register(RegisterStateModel body) async {
    try {
      final uri = Uri.parse(RemoteUrls.register)
          .replace(queryParameters: {'lang_code': body.languageCode});

      log("📝 Registration URL: $uri", name: 'RemoteDataSources');
      log("📝 Registration data: ${body.toMap()}", name: 'RemoteDataSources');

      // Add timeout to prevent infinite loading
      final response = await client
          .post(uri, body: body.toMap(), headers: postDeleteHeader)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              log("⏱️ Registration request timed out!", name: 'RemoteDataSources');
              throw ServerException("Request timed out. Please check your internet connection.", 408);
            },
          );

      log("📝 Registration HTTP status: ${response.statusCode}", name: 'RemoteDataSources');
      log("📝 Registration raw response: ${response.body}", name: 'RemoteDataSources');

      final responseJsonBody = jsonDecode(response.body);

      log("📝 Registration parsed response: $responseJsonBody", name: 'RemoteDataSources');

      // Handle HTTP errors
      if (response.statusCode == 422) {
        log("❌ Registration validation errors: ${responseJsonBody['errors']}", name: 'RemoteDataSources');
        throw InvalidInputException(Errors.fromMap(responseJsonBody['errors']));
      } else if (response.statusCode >= 400) {
        final errorMsg = responseJsonBody['message'] ?? 'Registration failed';
        log("❌ Registration server error: $errorMsg", name: 'RemoteDataSources');
        throw ServerException(errorMsg, response.statusCode);
      }

      // Check if registration was successful
      if (responseJsonBody['success'] == true || responseJsonBody['message'] != null) {
        log("✅ Registration successful!", name: 'RemoteDataSources');
      }

      // Return success response
      return responseJsonBody as Map<String, dynamic>;
    } on InvalidInputException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      log("❌ Registration unexpected error: $e", name: 'RemoteDataSources');
      throw ServerException("Registration failed: $e", 500);
    }
  }

  @override
  Future otpVerify(RegisterStateModel body) async {
    final uri = Uri.parse(RemoteUrls.otpVerify)
        .replace(queryParameters: {'lang_code': body.languageCode});
    print("login url : $uri");
    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future forgotOtpVerify(PasswordStateModel body) async {
    final uri = Uri.parse(RemoteUrls.forgotOtpVerify)
        .replace(queryParameters: {'lang_code': body.languageCode});
    print("login url : $uri");
    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future forgotPassword(PasswordStateModel body) async {
    final uri = Uri.parse(RemoteUrls.forgotPassword)
        .replace(queryParameters: {'lang_code': body.languageCode});
    print("login url : $uri");
    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future setResetPassword(PasswordStateModel body) async {
    final uri = Uri.parse(RemoteUrls.setResetPassword)
        .replace(queryParameters: {'lang_code': body.languageCode});
    print("login url : $uri");
    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future updatePassword(PasswordStateModel body, Uri url) async {
    final clientMethod =
        client.post(url, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future logout(Uri uri) async {
    final clientMethod = client.get(uri, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getWebsiteSetup(Uri uri) async {
    final clientMethod = client.get(uri, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getHomeData(String langCode) async {
    final uri = Uri.parse(RemoteUrls.homeUrl).replace(queryParameters: {
      'lang_code': langCode,
    });
    final clientMethod = client.get(uri, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getAllCarsList(Uri url) async {
    // final uri = Uri.parse(RemoteUrls.allCarList).replace(queryParameters: {
    //   'lang_code': langCode,
    // });
    final response = await client.get(url, headers: headers);
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getAllDealerList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getCarsDetails(String langCode, String id) async {
    final uri = Uri.parse(RemoteUrls.carDetails(id)).replace(queryParameters: {
      'lang_code': langCode,
    });
    final clientMethod = client.get(uri, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getDealerDetails(String langCode, String userName) async {
    final uri =
        Uri.parse(RemoteUrls.dealerDetails(userName)).replace(queryParameters: {
      'lang_code': langCode,
    });
    final clientMethod = client.get(uri, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future contactDealer(
      String langCode, String id, Map<String, dynamic> body) async {
    final uri =
        Uri.parse(RemoteUrls.contactDealer(id)).replace(queryParameters: {
      'lang_code': langCode,
    });

    final clientMethod =
        client.post(uri, headers: await _authHeaders(), body: jsonEncode(body));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future contactMessage(String langCode, Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.contactMessage).replace(queryParameters: {
      'lang_code': langCode,
    });

    final clientMethod =
        client.post(uri, headers: await _authHeaders(), body: jsonEncode(body));
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getWishList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future addWishList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future removeWishList(Uri url) async {
    final clientMethod = client.delete(url, headers: await _authHeaders());

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future removeCompareList(Uri url) async {
    final clientMethod = client.delete(url, headers: await _authHeaders());

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getBookingHistoryList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getBookingHistoryDetails(Uri url, String id) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getBookingHistoryCancel(Uri url, String id) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future startRide(Uri url, String id) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getTransactionsList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getUserDashboard(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getUserWithdraw(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getBookingRequest(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getUserCarList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getCarCreateData(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getCarEditData(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future addCar(
    CarsStateModel body,
    Uri url,
  ) async {
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(body.toMap());

    request.headers.addAll(await _authMultipartHeaders());
    
    // Upload thumbnail image (main/first image)
    if (body.thumbImage.isNotEmpty) {
      final file =
          await http.MultipartFile.fromPath('thumb_image', body.thumbImage);
      request.files.add(file);
    }
    
    // Upload gallery images (up to 5 images)
    if (body.galleryImages != null && body.galleryImages!.isNotEmpty) {
      for (int i = 0; i < body.galleryImages!.length && i < 5; i++) {
        if (body.galleryImages![i].isNotEmpty &&
            !body.galleryImages![i].contains('https://')) {
          final galleries = await http.MultipartFile.fromPath(
              'image_galleries[$i]', body.galleryImages![i]);
          request.files.add(galleries);
        }
      }
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future updateBasicCar(
    CarsStateModel body,
    Uri url,
  ) async {
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(body.toMap());

    request.headers.addAll(await _authMultipartHeaders());
    ;

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future keyFeatureUpdateCar(
    CarsStateModel body,
    Uri url,
  ) async {
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(body.toMap());

    request.headers.addAll(await _authMultipartHeaders());
    ;

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future featureUpdateCar(
    CarsStateModel body,
    Uri url,
  ) async {
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(body.toMap());

    request.headers.addAll(await _authMultipartHeaders());
    ;

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future addressUpdateCar(
    CarsStateModel body,
    Uri url,
  ) async {
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(body.toMap());

    request.headers.addAll(await _authMultipartHeaders());
    ;

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future galleryUpdateCar(
    CarsStateModel body,
    Uri url,
  ) async {
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(body.toMap());

    request.headers.addAll(await _authMultipartHeaders());
    ;
    if (body.thumbImage.isNotEmpty) {
      final file =
          await http.MultipartFile.fromPath('thumb_image', body.thumbImage);
      request.files.add(file);
    }
    if (body.videoImage.isNotEmpty) {
      final file =
          await http.MultipartFile.fromPath('video_image', body.videoImage);
      request.files.add(file);
    }

    if (body.galleryImages!.isNotEmpty) {
      // Limit to 5 gallery images
      for (int i = 0; i < body.galleryImages!.length && i < 5; i++) {
        if (body.galleryImages![i].isNotEmpty &&
            !body.galleryImages![i].contains('https://')) {
          final galleries = await http.MultipartFile.fromPath(
              'image_galleries[$i]', body.galleryImages![i]);
          request.files.add(galleries);
        }
      }
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future deleteCar(Uri url) async {
    final clientMethod = client.delete(url, headers: await _authHeaders());

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getKycInfo(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> submitKycVerify(url, KycSubmitStateModel data) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };

    final request = http.MultipartRequest('POST', url);
    request.fields.addAll(data.toMap());
    request.headers.addAll(await _authMultipartHeaders());
    if (data.file.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('file', data.file);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getAllReview(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getTermsCondition(String langCode) async {
    final uri =
        Uri.parse(RemoteUrls.getTermsCondition).replace(queryParameters: {
      'lang_code': langCode,
    });
    final clientMethod = client.get(uri, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getPrivacyPolicy(String langCode) async {
    final uri =
        Uri.parse(RemoteUrls.getPrivacyPolicy).replace(queryParameters: {
      'lang_code': langCode,
    });
    final clientMethod = client.get(uri, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getProfileData(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> updateProfile(User body, Uri url) async {
    final request = http.MultipartRequest('POST', url);

    // Add authentication headers
    final headers = await _authHeaders();
    request.headers.addAll(headers);

    // Convert Map<String, dynamic> to Map<String, String>
    request.fields.addAll(
      body.toMap().map((key, value) => MapEntry(key, value.toString())),
    );

    // Add profile image if selected
    if (body.image.isNotEmpty && !body.image.startsWith('http')) {
      final file = await http.MultipartFile.fromPath('image', body.image);
      request.files.add(file);
    }

    // Add banner image if selected
    if (body.bannerImage.isNotEmpty && !body.bannerImage.startsWith('http')) {
      final bannerFile = await http.MultipartFile.fromPath('banner_image', body.bannerImage);
      request.files.add(bannerFile);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'] as String;
  }

  @override
  Future getSearchAttribute(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getCity(Uri url, String id) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getDealerCity(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getCompareList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future subscriptionPlanList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future paymentInfo(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future freePlanEnroll(String id, Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future storeReview(Uri url, Map<String, dynamic> body) async {
    final clientMethod =
        client.post(url, headers: await _authHeaders(), body: jsonEncode(body));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future addCompareList(Uri url, Map<String, dynamic> body) async {
    final clientMethod =
        client.post(url, headers: await _authHeaders(), body: jsonEncode(body));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future payWithStripe(Uri url, Map<String, dynamic> body) async {
    final clientMethod =
        client.post(url, headers: await _authHeaders(), body: jsonEncode(body));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future payWithBank(Uri url, Map<String, dynamic> body) async {
    final clientMethod =
        client.post(url, headers: await _authHeaders(), body: jsonEncode(body));

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future transactionList(Uri url) async {
    final clientMethod = client.get(url, headers: await _authHeaders());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }
}
