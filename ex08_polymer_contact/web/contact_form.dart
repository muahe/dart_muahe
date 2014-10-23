import 'package:polymer/polymer.dart';
import 'model.dart' show Contact;
import 'dart:html' show CustomEvent, Event, Node;

/*
 * la classe du formulaire que j'utilise pour créer et modifier un contact
 * j'ai ajouté des validation sur la taille des champs saisi en plus des validations
 * usuelles de l'HTML5.
 */
@CustomTag('contact-form')
class ContactFormElement extends PolymerElement {
  /*
   * l'objet Contact modifié par ce formulaire.
   */
  @published Contact contact;

  /*
   * récuperer les valeurs des limites minimales et maximales configurées
   * dans mon model.
   */
  List<String> get allTypes => Contact.TYPES;
  int get minNomLength =>  Contact.MIN_NOM_LENGTH;
  int get maxNomLength => Contact.MAX_NOM_LENGTH;
  int get minPrenomLength => Contact.MIN_PRENOM_LENGTH;
  int get maxPrenomLength => Contact.MAX_PRENOM_LENGTH;
  int get minCourrielLength => Contact.MIN_COURRIEL_LENGTH;  
  int get maxCourrielLength => Contact.MAX_COURRIEL_LENGTH;
  int get minTelLength => Contact.MIN_TEL_LENGTH;
  int get maxTelLength => Contact.MAX_TEL_LENGTH;

  /*
   * Variables utilisées pour afficher mes messages d'erreurs.
   */
  @observable String nomErrorMessage = '';
  @observable String prenomErrorMessage = '';
  @observable String courrielErrorMessage = '';
  @observable String telErrorMessage = '';

  ContactFormElement.created() : super.created() {}

  /*
   * Pour valider le nom du contact. un message d'erreur s'affiche
   * si les règles de validation ne sont pas respectées.
   */
  bool validerNom() {
    if (contact.nom.length < minNomLength ||
        contact.nom.length > maxNomLength) {
      nomErrorMessage = "Le nom ne doit pas être vide et ne doit pas depasser "
          "$maxNomLength caractères.";
      return false;
    }
    nomErrorMessage = '';
    return true;
  }

  /*
   * Pour valider le prenom du contact. un message d'erreur s'affiche
   * si les règles de validation ne sont pas respectées.
   */
  bool validerPrenom() {
    if (contact.prenom.length < minPrenomLength ||
                contact.prenom.length > maxPrenomLength) {
      prenomErrorMessage = "Le prénom ne doit pas être vide et ne doit pas dépasser "
          "$maxPrenomLength caractères.";
      return false;
    }
    prenomErrorMessage = '';
    return true;
  }

  /*
   * Pour valider le courriel du contact. un message d'erreur s'affiche
   * si les règles de validation ne sont pas respectées.
   * Pour la validation du format du courriel, j'utilise la validation HTML5
   */
  bool validerCourriel() {
    if (contact.courriel.length > maxCourrielLength) {
      courrielErrorMessage = "Le courriel ne doit pas dépasser "
          "$maxCourrielLength caractères.";
      return false;
    }
    courrielErrorMessage = '';
    return true;
  }

  /*
   * Pour valider le tel du contact. un message d'erreur s'affiche
   * si les règles de validation ne sont pas respectées.
   * le format est validé par HTML5
   */
  bool validerTel() {
    if (contact.tel.length > maxTelLength) {
      telErrorMessage = "Le téléphone ne doit pas dépasser "
          "$maxTelLength caractères.";
      return false;
    }
    telErrorMessage = '';
    return true;
  }  
  
  
  /*
   * Vérifier la validation de tout le formulaire avant de permettre le submit
   * du formulaire.
   */
  validerContact(Event event, Object detail, Node sender) {
    event.preventDefault();
    if (validerNom() && validerPrenom()
        && validerCourriel() && validerTel()) {
      dispatchEvent(new CustomEvent('contactvalidated',
          detail: {'contact': contact}));
    }
  }

  /*
   * Pour annuler et vider la saisie faite dans le formulaire.
   */
  cancelForm(Event event, Object detail, Node sender) {
    event.preventDefault();
    nomErrorMessage = '';
    prenomErrorMessage = '';
    courrielErrorMessage = '';
    telErrorMessage = '';
    dispatchEvent(new CustomEvent('formnotneeded'));
  }
}
