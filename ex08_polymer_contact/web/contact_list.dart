import 'package:polymer/polymer.dart';
import 'model.dart' show Contact;
import 'dart:html' show Event, Node, window;
import 'dart:convert';

/*
 * Classe representant une collection d'objets contacts
 */

@CustomTag('contact-list')
class ContactList extends PolymerElement {
  static const ALL = "all";
  /*
   * champ pour un nouveau objet contact.
   */
  @observable Contact newContact = new Contact();

  /*
   * Collection de contacts. la source contenant tous les contacts de l'application.
   */
  @observable List<Contact> contacts = toObservable([]);

  /*
   * choix du type de contact par défaut à afficher 
   */
  String get defaultType => Contact.TYPES[1];

  /*
   * la liste de tout les types possible des contacts en plus d'une valeur ALL
   * pour afficher tous les contacts
   */
  final List<String> types = [ALL]..addAll(Contact.TYPES);


  @observable String typeValue = ALL;

  /*
   * la liste filtrée des contacts.
   */
  @observable List<Contact> typedContacts = toObservable([]);
  
  

  List<Contact> init(){
    
    List<Contact> contList = new List<Contact>();
    
    for (int i=1; i < 4; i++){
      Contact tempContact = new Contact();
      if (i<2){
        tempContact.type = "Personnel";
      }else if (i<3){
        tempContact.type = "Professionnel";
      }else{
        tempContact.type = "Mixte";
      }
      tempContact.nom = "Nom_contact${i}";
      tempContact.prenom = "Prénom_contact${i}";
      tempContact.courriel = "contact${i}@dart.ca";
      tempContact.tel = "(418)${i}${i}${i}-${i}${i}${i}${i}";
      contList.add(tempContact);
    }
    return contList; 
  }
  

  /*
   * Constructeur, initialise et enregistre quelques exemples en localStorage
   * s'il ne contient déjà des enregistrements sinon se contente de les afficher.
   * il initialise aussi le type de contact par défaut.
   */
  ContactList.created() : super.created() {
    
    if (window.localStorage.isEmpty){
      int j=1;
      init().forEach((e) {
        window.localStorage[j.toString()] = JSON.encode(e.toJson());
        j++;
      }); 
    }
     
    window.localStorage.forEach((k,v){
      Contact tempCont = new Contact();
      tempCont.fromJson(JSON.decode(v));  
      contacts.add(tempCont);
    });        
    
    typedContacts = contacts;
    newContact.type = defaultType;
  }

  /*
   * vide le formulaire 
   */
  resetForm() {
    newContact = new Contact();
    newContact.type = defaultType;
  }

  /*
   * ajoute un contact à la liste et vide le formulaire
   */
  addContact(Event e, var detail, Node sender) {
    e.preventDefault();
    contacts.add(detail['contact']);
    Contact ct = detail['contact'] as Contact;    
    window.localStorage[getLastFreeKey().toString()] = JSON.encode(ct.toJson());

    resetForm();
  }

  /*
   * récuperer la clé à utiliser pour enregistrer le contact dans le localStorage 
   */
  int getLastFreeKey(){
    int myKey = 0;
    if (window.localStorage.keys.isNotEmpty){
      List<String> myList = window.localStorage.keys.toList();
      myList.sort((x, y) => int.parse(x).compareTo(int.parse(y)));
      myKey = int.parse(myList.last);
    }
    myKey = myKey + 1;
    return myKey;
  }

  /*
   * Supprimer un contact de la liste des contacts et du localStorage.
   */
  deleteContact(Event e, var detail, Node sender) {
    var contact = detail['contact'];
    contacts.remove(contact);  
    window.localStorage.remove(getKey(contact).toString());    
  }
  
  /*
   * récuperer la clé d'un contact avec laquelle il est enregistré dans 
   * le localStorage.
   */
  int getKey(Contact ct){
    int myKey = 0;

    String myString = JSON.encode(ct.toJson());
    
    window.localStorage.forEach((k,v){
      if (v.compareTo(myString) == 0){
        myKey = int.parse(k);
        return myKey;
      }
        
    });

    return myKey;
  }  
  
  /*
   * recalcule la liste des contacts selon le filtre choisi.
   */
  type() {
    if (typeValue == ALL) {
      typedContacts = contacts;
      return;
    }
    typedContacts = contacts.where((contact) {
      return contact.type == typeValue;
    }).toList();
  }

  /*
   * faire un refresh de la liste à chaque fois que le filtre est modifié.
   */
  contactsChanged() {
    type();
  }
}
