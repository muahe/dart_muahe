import 'dart:html';
import 'dart:convert';
import 'package:ex06_dartlero_contact/ex06_dartlero_contact.dart';


InputElement inputNom, inputPrenom, InputCourriel, inputTel, inputIdContact, inputSubmit, 
        inputReset, inputSupp, inputClearLocStorage, inputOui, inputNon, inputClickedItem;
DivElement  messageConfirmation, list;
UListElement uListErrors;
SpanElement spnMsgConfirm;
InputElement btnSubmit, btnReset, btnSupp, btnOui, btnNon, btnClearLocStorage;
FormElement formSubmit;

ContactModel contactModel = new ContactModel();



main() {
  bind_elements();
  attach_event_handlers();
  initListContact();
}

bind_elements(){
  inputNom = querySelector('#nom');
  inputPrenom = querySelector('#prenom');
  InputCourriel = querySelector('#courriel');
  inputTel = querySelector('#tel');
  inputIdContact = querySelector('#idContact');
  inputClickedItem = querySelector('#clickedItem');
  
  formSubmit = querySelector('#contact');

  btnSubmit = querySelector('#submitButton');
  btnReset = querySelector('#resetButton');
  btnSupp = querySelector('#suppButton');
  btnClearLocStorage = querySelector('#clearLocalStorage');
  btnOui = querySelector('#oui');
  btnNon = querySelector('#non');
  
  messageConfirmation = querySelector('#confirm');
  
  list = querySelector('#listeContact');  
  
  uListErrors = querySelector('#errors');
  
  spnMsgConfirm = querySelector('#msgConfirm');   
}

attach_event_handlers() {

  btnOui.onClick.listen(confirmMessage);
  btnNon.onClick.listen(confirmMessage);
  btnReset.onClick.listen(clearHidden);
  btnSubmit.onClick.listen(addOrUpdate);
  btnSupp.onClick.listen(deleteContact);
  btnClearLocStorage.onClick.listen(clearLocStorage);
  
}


void deleteContact(e){

  window.localStorage.remove(inputIdContact.value);
  list.children.removeWhere((e)=> e.id==inputIdContact.value);
  btnReset.click();
  
}


void clearLocStorage(e){
  
  window.localStorage.clear();
  list.children.clear();

}



void addOrUpdate(e){

  if (formSubmit.checkValidity()) {
    InputElement inel = e.currentTarget as InputElement;
    String input = inel.value;
    Contact contact = new Contact();
    switch (input){
      case ("Ajouter"):
        try {
          int lastID = 0;
  
           List myList = window.localStorage.keys.toList();
           if (myList.isNotEmpty){
            myList.sort((x,y) => int.parse(x).compareTo(int.parse(y)));                
            lastID = int.parse(myList.last);           
           } 
          contact.idContact = lastID + 1;
          contact.nom = inputNom.value;
          contact.prenom = inputPrenom.value;
          contact.courriel = InputCourriel.value;
          contact.tel = inputTel.value;
          window.localStorage["${contact.idContact}"] = JSON.encode(contact.toJson());
          printContactFromLocalStorage(contact);
          btnReset.click();
          e.preventDefault();
        } on Exception catch (ex) {
              //window.alert("Le stockage local est vide ou a été désactivé !");
              printErrorMessage("Le stockage local est vide ou a été désactivé !");
        } 
        break;
      case ("Modifier"):
        contact.idContact = int.parse(inputIdContact.value);
        contact.nom = inputNom.value;
        contact.prenom = inputPrenom.value;
        contact.courriel = InputCourriel.value;
        contact.tel = inputTel.value;
      
        window.localStorage.remove(inputIdContact.value);
        list.children.removeWhere((e)=> e.id==inputIdContact.value);
        window.localStorage["${contact.idContact}"] = JSON.encode(contact.toJson());
        printContactFromLocalStorage(contact);
        btnReset.click();
        e.preventDefault();
        break;
        
    }
  }
}


void clearHidden(e){

  inputIdContact.value = "";
  btnSubmit.value = "Ajouter";
  btnSupp.classes.removeWhere((each) => each=="visible");
  messageConfirmation.classes.removeWhere((each) => each=="visible");
  uListErrors.classes.removeWhere((each) => each=="visible");
  confirmMessage(e);
 

}

void permuteColorLine(String oldLine, String newLine, String contexte){

  DivElement firstDiv, secondDiv;  
  firstDiv = window.document.getElementById(oldLine) as DivElement;
  secondDiv = window.document.getElementById(newLine) as DivElement;
  if ((firstDiv != null) && (secondDiv != null)) {
    switch (contexte.toUpperCase()){
    case 'PERMUTE' :
      firstDiv.classes.removeWhere((each) => each=="DivList");
      firstDiv.classes.add("DivListContact");
      secondDiv.classes.removeWhere((each) => each=="DivListContact");
      secondDiv.classes.add("DivList");    
      break;
    case 'DONTPERMUTE' :
      secondDiv.classes.removeWhere((each) => each=="DivList");
      secondDiv.classes.add("DivListContact");
      break;
    case 'ALL' :
      firstDiv.classes.removeWhere((each) => each=="DivList");
      firstDiv.classes.add("DivListContact");
      secondDiv.classes.removeWhere((each) => each=="DivList");
      secondDiv.classes.add("DivListContact");   
      break;    
  
    }
  }
}

void confirmMessage(e){

  var clickedElem = e.target;
  switch (clickedElem.id){
    case 'oui':
      messageConfirmation.classes.removeWhere((each) => each=="visible");
      permuteColorLine(inputClickedItem.value , inputClickedItem.id.substring(5), 'dontpermute');
      break;
    case 'non':
      messageConfirmation.classes.removeWhere((each) => each=="visible");
      String contactJson = window.localStorage[inputClickedItem.id.substring(5)];
      Contact contact = new Contact();
      contact.fromJson(JSON.decode(contactJson));
      fillInForm(contact);
      permuteColorLine(inputClickedItem.value , inputClickedItem.id.substring(5), 'permute');
      break;
    case 'resetButton' :
      permuteColorLine(inputClickedItem.value , inputClickedItem.id.substring(5), 'all');
      break;

  }  
}

void initListContact(){

  contactModel.init();
  Contacts contacts = contactModel.contacts;  
  contacts.forEach(storeLine);
  printLocalStorage();
  
}

storeLine(element){

  if (element is Contact){  
    Contact contact = element as Contact;
    try {
        window.localStorage["${contact.idContact}"] = JSON.encode(contact.toJson());
    } on Exception catch (ex) {
          //window.alert("Données non enregistrées: Le stockage local a été désactivé!");
          printErrorMessage("Données non enregistrées: Le stockage local a été désactivé!");
    } 
  }
}


printLocalStorage(){
  
  for (var key in window.localStorage.keys) {
    String contactString = window.localStorage[key];      
    Contact contact = new Contact();
    Map<String, Object> mapContact = JSON.decode(contactString);
    contact.fromJson(mapContact);
    printContactFromLocalStorage(contact);
  
  }  
}

printContactFromLocalStorage(Contact contact){

  var newDivContact = new DivElement();
  newDivContact.id =  contact.idContact.toString();
  newDivContact.classes.add("DivListContact");
  newDivContact.appendHtml("${contact.nom}, ${contact.prenom}");
  newDivContact.onClick.listen(LoadContact);
  list.append(newDivContact);
  
}

void LoadContact(e){

  DivElement currentDiv = e.currentTarget as DivElement;
  currentDiv.classes.removeWhere((each) => each=="DivListContact");
  currentDiv.classes.add("DivList");
  var clickedElem = e.target;
  inputClickedItem.id = "input" + clickedElem.id;
  btnSubmit.value = "Modifier";
  btnSupp.classes.add("visible");
  if (!window.localStorage.containsKey(clickedElem.id)) {
    printErrorMessage("Le contact choisi a été supprimé du stockage local !");    
  }else{      
    String contactJson = window.localStorage[clickedElem.id];
    Contact contact = new Contact();
    contact.fromJson(JSON.decode(contactJson));
    if ((inputIdContact.value != "") && 
        (inputIdContact.value.compareTo(contact.idContact.toString()) != 0)){
      inputClickedItem.value = inputIdContact.value;
      printConfirmMessage("Le contact est en modification, voulez vous le garder ouvert ?");
    }else{
      if ((inputIdContact.value == "") 
          && (inputNom.value != "" 
                || inputPrenom.value != "" 
                || InputCourriel.value != "" 
                || inputTel.value != "" )){
        printConfirmMessage("Les données saisies seront perdues, voulez les garder ?");  
      }else{
        fillInForm(contact);
      }      
    }
  }
}

printErrorMessage(String message){

  var newListErrors = new LIElement();
  newListErrors.id =  "ErrorMessage";
  newListErrors.text = message; 
  uListErrors.children.removeWhere((item) => item.id != "info");
  uListErrors.children.add(newListErrors);
  uListErrors.classes.add("visible");

}

printConfirmMessage(String message){

  spnMsgConfirm.text = message;
  messageConfirmation.classes.add("visible");

}

fillInForm(Contact contact){

  inputIdContact.value = contact.idContact.toString();
  inputNom.value = contact.nom;
  inputPrenom.value = contact.prenom;
  InputCourriel.value = contact.courriel;
  inputTel.value = contact.tel;
  
}
