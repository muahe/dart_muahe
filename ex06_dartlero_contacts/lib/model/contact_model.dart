part of ex06_dartlero_contact;


class ContactModel extends ConceptModel {
  
  static final String contact = 'Contact';
  
  Map<String, ConceptEntities> newEntries() {
    var contacts = new Contacts();
    var map = new Map<String, ConceptEntities>();
    map[contact] = contacts;
    return map;
  }
  
  Contacts get contacts => getEntry(contact);
  
  init() {
    var contact1 = new Contact();
    contact1.idContact = 1; 
    contact1.nom = 'Tremblay';
    contact1.prenom = 'Pierre';
    contact1.courriel = 
        'p.tremblay@dart.ca';
    contact1.tel = '(418)111-1111';
    contacts.add(contact1);

    var contact2 = new Contact();
    contact2.idContact = 2; 
    contact2.nom = 'Bourassa';
    contact2.prenom = 'Adam';
    contact2.courriel = 
        'a.bourassa@dart.ca';
    contact2.tel = '(418)222-2222';
    contacts.add(contact2);
    
    var contact3 = new Contact();
    contact3.idContact = 3; 
    contact3.nom = 'Hamel';
    contact3.prenom = 'Christine';
    contact3.courriel = 
        'c.hamel@dart.ca';
    contact3.tel = '(418)333-3333';
    contacts.add(contact3);

    var contact4 = new Contact();
    contact4.idContact = 4; 
    contact4.nom = 'Boivin';
    contact4.prenom = 'Caroline';
    contact4.courriel = 
        'c.boivin@dart.ca';
    contact4.tel = '(418)444-4444';
    contacts.add(contact4);

  }

  display() {
    print('Contact Model');
    print('=============');
    contacts.display('Contacts');
    print(
      '============= ============= ============= '
      '============= ============= ============= '
    );
  }
  
  
  
}