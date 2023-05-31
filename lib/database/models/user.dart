class User {
  static String collectionName = "user";
  String? name;
  String? id;
  String? email;

  User({required this.name,required this.email,required this.id});

  User.FromFireStore(Map<String, dynamic>? date)
      : this(name: date?['name'], id: date?['id'], email: date?['email']);

   Map<String,dynamic>toFireStore(){
    return {
      'id':id,
      'name':name,
      'email':email
    };
  }
}
