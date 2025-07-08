void main() {
  var myTotal = doSum(70, 85, 90);
  print("The Total is $myTotal");

  var myper = doPerc(myTotal);
  print("$myper");

  var ans = doMulti(10, 10);
  print("Anser is $ans");

  print("Fibonacci sequence:");
  printFibonacci(10);
}

doSum(a, b, c) {
  var d = a + b + c;
  return d;
}

doPerc(e) {
  var aa = e / 300 * 100;
  return aa;
}

doMulti(a, b) => a * b;

void printFibonacci(int n, [int a = 0, int b = 1]) {
  if (n == 0) return;
  print(b);
  printFibonacci(n - 1, b, a + b);
}
