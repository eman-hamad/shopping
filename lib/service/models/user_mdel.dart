class MyUser {
  String ? id;
  String ? name;
  String  ? age;
  String ? hobby;
  String ? email;
  String ? password;
  MyUser({
    this.id,
     this.name,
     this.age,
     this.hobby,
     this.email,
     this.password
  });

 
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'age': age,
      'hobby': hobby,
      'email' : email,
      'password' :password

    };
  }


  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      hobby: map['hobby'] ?? '',
      email: map['email'] ??'',
      password: map['password']
    );
  }
}
