import 'package:polymer/polymer.dart';
import 'model.dart' show Contact;
import 'dart:html' show Event, Node, CustomEvent, window;
import 'dart:convert';

@CustomTag('contact-element')
class ContactElement extends PolymerElement {
  @published Contact contact;
  @observable bool editing = false;
  
  
  Contact _cachedContact;

  ContactElement.created(): super.created() {}

  /*
   * mettre à jour un contact existant.
   */
  updateContact(Event e, var detail, Node sender) {
    e.preventDefault();
    if (_cachedContact.type != contact.type) {
      dispatchEvent(new CustomEvent('typechanged'));
    }
    Contact ct = detail['contact'] as Contact;    
    window.localStorage[getKey().toString()] = JSON.encode(ct.toJson());
    editing = false;
  }
  
  /*
   * récuperer la clé d'un contact avec laquelle il est enregistré dans 
   * le localStorage.
   */  
  int getKey(){
    int myKey = 0;

    String myString = JSON.encode(_cachedContact.toJson());
    
    window.localStorage.forEach((k,v){
      if (v.compareTo(myString) == 0){
        myKey = int.parse(k);
        return myKey;
      }
        
    });

    return myKey;
  }
  
  /*
   * Annuler la modification d'un contact existant et restaure les anciennes valeurs
   * du contact.
   */
  cancelEditing(Event e, var detail, Node sender) {
    e.preventDefault();
    copyContact(contact, _cachedContact);
    editing = false;
  }

  /*
   * déclenche le début de la mise à jour d'un contact.
   */
  startEditing(Event e, var detail, Node sender) {
    e.preventDefault();
    _cachedContact = new Contact();
    copyContact(_cachedContact, contact);
    editing = true;
  }

  /*
   * Supprimer un contact existant.
   */
  deleteContact(Event e, var detail, Node sender) {
    e.preventDefault();
    dispatchEvent(new CustomEvent('deletecontact',
        detail: {'contact': contact}));

  }

  /*
   * Copier un contact source dans un contact cible.
   */
  copyContact(source, destination) {
    source.nom = destination.nom;
    source.prenom = destination.prenom;    
    source.courriel = destination.courriel;
    source.tel = destination.tel;
    source.type = destination.type;
  }
}