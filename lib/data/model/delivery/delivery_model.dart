class DeliveryRequest {
  final String? id;
  final String userName;
  final String? userEmail;
  final String userPhone;
  final String requestedVehicle;
  final String preferredDeliveryDate;
  final String? userMessage;

  DeliveryRequest({
    this.id,
    required this.userName,
    this.userEmail,
    required this.userPhone,
    required this.requestedVehicle,
    required this.preferredDeliveryDate,
    this.userMessage,
  });

  Map<String, dynamic> toJson() => {
        'user_name': userName,
        'user_email': userEmail,
        'user_phone': userPhone,
        'requested_vehicle': requestedVehicle,
        'preferred_delivery_date': preferredDeliveryDate,
        'user_message': userMessage,
      };

  factory DeliveryRequest.fromJson(Map<String, dynamic> json) {
    return DeliveryRequest(
      id: json['id']?.toString(),
      userName: json['user_name'],
      userEmail: json['user_email'],
      userPhone: json['user_phone'],
      requestedVehicle: json['requested_vehicle'],
      preferredDeliveryDate: json['preferred_delivery_date'],
      userMessage: json['user_message'],
    );
  }
}
