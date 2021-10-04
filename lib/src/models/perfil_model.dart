class PerfilModel {
  int? id;
  String? avatar;
  String? nombre;
  String? aPaterno;
  String? aMaterno;
  String? telefono;
  String? email;

  //genera un objeto de PerfilModel
  PerfilModel(
      {this.id,
      this.avatar,
      this.nombre,
      this.aPaterno,
      this.aMaterno,
      this.telefono,
      this.email});

  // Mapa ---> Objeto

  //constructor nombrado
  factory PerfilModel.fromMap(Map<String, dynamic> map) {
    return PerfilModel(
        id: map['id'],
        avatar: map['avatar'],
        nombre: map['nombre'],
        aPaterno: map['aPaterno'],
        aMaterno: map['aMaterno'],
        telefono: map['telefono'],
        email: map['email']);
  }

  //Objeto ---> Mapa

  //Se maneja como un metodo
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatar': avatar,
      'nombre': nombre,
      'aPaterno': aPaterno,
      'aMaterno': aMaterno,
      'telefono': telefono,
      'email': email
    };
  }
}








// Modelo para hacer uso de la BD
// Contiene las caracteristicas del perfil de un alumno
// Avatar del usuario
// Nombre
// Apellido Paterno
// Apellido Materno
// Número de teléfono
// Correo Electrónico