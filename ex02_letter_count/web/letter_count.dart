import 'dart:html';

/** 
 * fonction fromTextToLetters prend en entrée un texte, le splite
 * en lettres et retourne une liste de ces lettres.  
 */

List fromTextToLetters(String text) {
  var textWithout = text.split('');
  return textWithout;
}

/**
 * fonction analyzeLetterFrequency : prend en entrée une liste de lettres
 * et retourne un objet Map contenant chaque lettre et sa fréquence
 */

Map analyzeLetterFrequency(List letterList) {
  var letterFrequencyMap = new Map();
  for (var w in letterList) {
    if (w != '') {
      if (!letterFrequencyMap.containsKey(w)) {
        
        letterFrequencyMap[w] = 0;
      }
      letterFrequencyMap[w] = letterFrequencyMap[w] + 1;
    }
  }

  return letterFrequencyMap;
}

/**
 * fonction sortLetters prend en entrée un objet Map de lettres et de leurs fréquences
 * et retourne un objet list contenant ces lettres triées par ordre alphabétique selon
 * le langage du système.
 * elle rajoute à la fin de la liste, la fréquence des espaces trouvés dans le Map.
 */

List sortLetters(Map letterFrequencyMap) {
  const ESPACE_PREFIXE = 'Espace';
  var allLetterFrequencyMap = new Map<String, String>();
  letterFrequencyMap.forEach((k, v) =>
      allLetterFrequencyMap[k] = '${k}: ${v.toString()}');
  List sortedLetterList = allLetterFrequencyMap.values.toList();
  sortedLetterList.sort((m,n) => m.compareTo(n));
  
  if (sortedLetterList.contains(allLetterFrequencyMap[' '].toString())) {
    sortedLetterList.remove(allLetterFrequencyMap[' '].toString());
    sortedLetterList.add(ESPACE_PREFIXE + allLetterFrequencyMap[' '].toString());
  }
  return sortedLetterList;
}

/**
 * Main : lancement du programme, 
 * 
 */
void main() {
  TextAreaElement textArea = document.querySelector('#textToAnalyse');
  TextAreaElement lettersArea = document.querySelector('#letters');
  ButtonElement lettersButton = document.querySelector('#frequency');
  ButtonElement clearButton = document.querySelector('#clear');
  lettersButton.onClick.listen((MouseEvent e) {
    var text = textArea.value;
    if (text != '') {
      lettersArea.value = 'Lettres: fréquence \n';
      var lettersList = fromTextToLetters(textArea.value);
      var lettersMap = analyzeLetterFrequency(lettersList);
      var sortedLettersList = sortLetters(lettersMap);
      sortedLettersList.forEach((letter) =>
          lettersArea.value = '${lettersArea.value} \n${letter}');
    } else {
      lettersArea.value = 'Veuillez saisir un texte à analyser !!!';
    }
      
  });
  clearButton.onClick.listen((MouseEvent e) {
    textArea.value = '';
    lettersArea.value = '';
  });
}


