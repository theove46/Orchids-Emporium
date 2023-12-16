class VendorUserModel {
  VendorUserModel({
    required this.approved,
    required this.vendorId,
    required this.companyName,
    required this.email,
    required this.phone,
    required this.storeImage,
    required this.taxNumber,
    required this.taxRegistered,
  });
  final bool? approved;
  final String? vendorId;
  final String? companyName;

  final String? email;
  final String? phone;
  final String? storeImage;
  final String? taxNumber;
  final String? taxRegistered;

  VendorUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          vendorId: json['vendorId']! as String,
          companyName: json['companyName']! as String,
          email: json['email']! as String,
          phone: json['phone']! as String,
          storeImage: json['storeImage']! as String,
          taxNumber: json['taxNumber']! as String,
          taxRegistered: json['taxRegistered']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'vendorId': vendorId,
      'companyName': companyName,
      'email': email,
      'phone': phone,
      'storeImage': storeImage,
      'taxNumber': taxNumber,
      'taxRegistered': taxRegistered,
    };
  }
}
