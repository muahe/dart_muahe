void main() {
  var i = 0;
  var multipleTrois = 0;
  var multipleCinq = 0;
   for (i = 1; i <= 100; i++){
    multipleTrois = i % 3;
    multipleCinq = i % 5;
    if ((multipleTrois == 0) && (multipleCinq == 0)) {
      print('$i is FizzBuzz');
    } else if ((multipleTrois != 0) && (multipleCinq == 0)){
      print('$i is Buzz');
    } else if ((multipleTrois == 0) && (multipleCinq != 0)){
      print('$i is Fizz');
    } else {
      print('$i');
    }
    
  }
}