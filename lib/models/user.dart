class User {
  String nombre;
    String correo;
    String telefono;
    int rol;
    int uid;

    User({
        required this.nombre,
        required this.correo,
        required this.telefono,
        required this.rol,
        required this.uid,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        nombre: json["nombre"],
        correo: json["correo"],
        telefono: json["telefono"],
        rol: json["rol"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "correo": correo,
        "telefono": telefono,
        "rol": rol,
        "uid": uid,
    };
}