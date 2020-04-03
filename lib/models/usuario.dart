import 'package:carros/utils/prefs.dart';
import 'dart:convert' as convert;

class Usuario {
  String id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  Usuario(
      {this.id,
      this.login,
      this.nome,
      this.email,
      this.urlFoto,
      this.token,
      this.roles});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    //roles = json['roles'].cast<String>();
    roles = json["roles"] != null ? json["roles"].map<String>((role) => role.toString()).toList() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  void save() {
    String json = convert.json.encode(this.toJson());
    Prefs.setString("user.prefs", json);
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  static Future<Usuario> get() async {
    String json = await Prefs.getString("user.prefs");
    
    if(json.isEmpty) {
      return null;
    }
    
    Map map = convert.json.decode(json);
    Usuario user = Usuario.fromJson(map);

    return user;
  }

  @override
  String toString() {
    return "Usuario(login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles)";
  }

}