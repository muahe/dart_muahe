part of ex06_dartlero_contact;


class Contact extends ConceptEntity<Contact> {
  
  int _idContact;
  String nom;
  String prenom;
  String courriel;
  String tel;
  
  
  int get idContact => _idContact;
  set idContact(int idContact){
    _idContact = idContact;
    if (code == null) {
      code = idContact.toString();
    }
  }
  
  
  Contact newEntity() => new Contact();
  
  Contact copy() {
    var contact = super.copy();

    contact.idContact = idContact;
    contact.nom = nom;
    contact.prenom = prenom;
    contact.courriel = courriel;
    contact.tel = tel;
    return contact;
  }


  String toString() {
    return '  {\n '
           '    ${super.toString()}, \n '
           '    Identifiant contact : ${idContact}, \n '
           '    Nom du contact : ${nom}\n'
           '    Prénom du contact : ${prenom}, \n '
           '    Courriel du contact : ${courriel}, \n '
           '    Téléphone du contact : ${tel}, \n '           
           '  }';
  }
  
  Map<String, Object> toJson() {
    Map<String, Object> entityMap = super.toJson();
    entityMap['idContact'] = idContact;
    entityMap['nom'] = nom;
    entityMap['prenom'] = prenom;
    entityMap['courriel'] = courriel;
    entityMap['tel'] = tel;    
    return entityMap;
  }
  
  fromJson(Map<String, Object> entityMap) {
    super.fromJson(entityMap);
    idContact = entityMap['idContact'];
    nom = entityMap['nom'];
    prenom = entityMap['prenom'];
    courriel = entityMap['courriel'];
    tel = entityMap['tel'];    
  }
  
  
}


class Contacts extends ConceptEntities<Contact> {

  Contacts newEntities() => new Contacts();
  Contact newEntity() => new Contact();

}