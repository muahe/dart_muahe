library polymer_and_dart.web.models;

import 'package:polymer/polymer.dart';

/*
 * Mon model de contact utilisé.
 */
class Contact extends Observable {
  static const List<String> TYPES = const ['Personnel', 'Professionnel', 'Mixte'];

  static const MIN_NOM_LENGTH = 1;
  static const MAX_NOM_LENGTH = 40;
  static const MIN_PRENOM_LENGTH = 1;
  static const MAX_PRENOM_LENGTH = 30;
  static const MIN_COURRIEL_LENGTH = 1;
  static const MAX_COURRIEL_LENGTH = 140;
  static const MIN_TEL_LENGTH = 1;
  static const MAX_TEL_LENGTH = 30;

  @observable String nom;
  @observable String prenom;
  @observable String courriel;
  @observable String tel;
  @observable String type;

  Contact([this.type = "", this.nom = "", this.prenom = "", this.courriel = "",this.tel = "" ]);
  
 
  Map<String, Object> toJson() {
    Map<String, Object> entityMap = new Map<String, Object>();
    entityMap['type'] = type;
    entityMap['nom'] = nom;
    entityMap['prenom'] = prenom;
    entityMap['courriel'] = courriel;
    entityMap['tel'] = tel;    
    return entityMap;
  }  
  
  
  fromJson(Map<String, Object> entityMap) {
    type = entityMap['type'];
    nom = entityMap['nom'];
    prenom = entityMap['prenom'];
    courriel = entityMap['courriel'];
    tel = entityMap['tel'];    
  }
  
}