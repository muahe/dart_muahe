import 'dart:convert';
import 'package:unittest/unittest.dart';
import 'package:ex06_dartlero_contact/ex06_dartlero_contact.dart';


testContacts(Contacts contacts) {
  group("Test Contacts", () {
    setUp(() {
      var contactCount = 0;
      expect(contacts.length, equals(contactCount));

      var contact1 = new Contact();
      expect(contact1, isNotNull);
      contact1.idContact = 1; 
      contact1.nom = 'Levesque';
      contact1.prenom = 'René';
      contact1.courriel = 'weidow@gmail.com';
      contact1.tel = '37467387';
      contacts.add(contact1);
      expect(contacts.length, equals(++contactCount));

      var contact2 = new Contact();
      expect(contact2, isNotNull);
      contact2.idContact = 2; 
      contact2.nom = 'Leclerc';
      contact2.prenom = 'Felix';
      contact2.courriel = 'weidow@gmail.com';
      contact2.tel = '37467387';
      contacts.add(contact2);
      expect(contacts.length, equals(++contactCount));     

      var contact3 = new Contact();
      expect(contact3, isNotNull);
      contact3.idContact = 3; 
      contact3.nom = 'Hamel';
      contact3.prenom = 'Wilfrid';
      contact3.courriel = 'weidow@gmail.com';
      contact3.tel = '37467387';
      contacts.add(contact3);
      expect(contacts.length, equals(++contactCount));
      
      var contact4 = new Contact();
      expect(contact4, isNotNull);
      contact4.idContact = 4; 
      contact4.nom = 'Bourassa';
      contact4.prenom = 'Henri';
      contact4.courriel = 'weidow@gmail.com';
      contact4.tel = '37467387';
      contacts.add(contact4);
      expect(contacts.length, equals(++contactCount));
    });
    tearDown(() {
      contacts.clear();
      expect(contacts.isEmpty, isTrue);
    });
    test('Ajouter un Contact', () {
      var contact = new Contact();
      expect(contact, isNotNull);
      contact.idContact = 5; 
      contact.nom = 'Père';
      contact.prenom = 'Marquette';
      contact.courriel = 'weoijwo@yahoo.com';
      contact.tel = '92387927';
      var added = contacts.add(contact);
      expect(added, isTrue);
      contacts.display('Ajouter un contact');
    });
    test('Ajouter un contact sans données', () {
      var contactCount = contacts.length;
      var contact = new Contact();
      expect(contact, isNotNull);
      var added = contacts.add(contact);
      expect(added, isTrue);
      contacts.display('Ajouter un contact sans données');
    });
    test('Ajouter un contact non unique', () {
      var contactCount = contacts.length;
      var contact = new Contact();
      expect(contact, isNotNull);
      contact.idContact = 3; 
      contact.nom = 'Hamel';
      contact.prenom = 'Wilfrid';
      contact.courriel = 'weidow@gmail.com';
      contact.tel = '37467387';
      var added = contacts.add(contact);
      expect(added, isFalse);
      contacts.display('Ajouter un contact non unique');
    });
    test('Trouver un contact par identifiant', () {
      String searchCode = '1';
      var contact = contacts.find(searchCode);
      expect(contact, isNotNull);
      expect(contact.idContact.toString() , equals(searchCode));
      contacts.display('Trouver un contact par identifiant');
    });
    test('Copier les tâches', () {
      Contacts copiedContacts = contacts.copy();
      expect(copiedContacts.isEmpty, isFalse);
      expect(copiedContacts.length, equals(contacts.length));
      expect(copiedContacts, isNot(same(contacts)));
      expect(copiedContacts, isNot(equals(contacts)));
      copiedContacts.forEach((cc) =>
          expect(cc, isNot(same(contacts.find(cc.idContact.toString())))));
      copiedContacts.display('Contacts copiés');

    });
    test('Vrai pour toutes les contacts', () {
      expect(contacts.every((c) => c.code != null), isTrue);
      expect(contacts.every((c) => c.nom != null), isTrue);
    });
    test('From Contacts to JSON', () {
      var json = contacts.toJson();
      expect(json, isNotNull);
      print(json);
    });
    test('From JSON to Contact Model', () {
      List<Map<String, Object>> json = contacts.toJson();
      contacts.clear();
      expect(contacts.isEmpty, isTrue);
      contacts.fromJson(json);
      expect(contacts.isEmpty, isFalse);
      contacts.display('From JSON to Contacts');
    });
    
    test('from json to contact', () {
      Contact contact = new Contact();
      expect(contact, isNotNull);
      Map<String, Object> tests = JSON.decode('{"code": "1", "idContact": 1, "nom": "Tremblay", "prenom": "Pierre", "courriel": "p.tremblay@weid.com"}');
      contact.fromJson(tests);
      contact.display('from json to contact');
      
    });
  });
  
}


initDisplayModel() {
  ContactModel contactModel = new ContactModel();
  contactModel.init();
  contactModel.display();
}

testModel() {
  ContactModel contactModel = new ContactModel();
  Contacts contacts = contactModel.contacts;
  testContacts(contacts);
}

main() {
  testModel();
}



