class User {
  final int? id;
  final String username;
  final String email;
  final String fullName;
  final String? phone;
  final String role;
  final String? token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    this.phone,
    required this.role,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Handle both direct user data and response with user nested object
    final userData = json.containsKey('user') ? json['user'] : json;
    
    return User(
      id: userData['id'],
      username: userData['username'] ?? '',
      email: userData['email'] ?? '',
      fullName: userData['full_name'] ?? userData['fullName'] ?? '',
      phone: userData['phone'],
      role: userData['role'] ?? 'customer',
      token: json['token'], // Token is at root level
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'role': role,
      'token': token,
    };
  }

  // Helper method to get display name
  String get displayName => fullName.isNotEmpty ? fullName : username;
  
  // Helper method to check if user is admin
  bool get isAdmin => role == 'admin';
  
  // Helper method to check if user is baker
  bool get isBaker => role == 'baker';
  
  // Helper method to check if user is customer
  bool get isCustomer => role == 'customer';
}