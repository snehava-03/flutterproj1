class User{
  final String email;
  final String name;
  final String phoneNumber;

  User({required this.email,
  required this.name,
  required this.phoneNumber
  });
  Map<String, dynamic> toJson(){
    return{
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
  factory User.fromJson(Map<String,dynamic>json){
    return User(
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      );
  }
  
}