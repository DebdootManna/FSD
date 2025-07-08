void main() {
  BankSystem bankSystem = BankSystem();
  bankSystem.addUser('Debdoot', 1000);
  bankSystem.addUser('Manna', 500);

  var debdoot = bankSystem.getUser('Debdoot');
  debdoot?.account.deposit(200);
  debdoot?.account.withdraw(100);
  debdoot?.account.getBalance();

  var manna = bankSystem.getUser('Manna');
  manna?.account.deposit(300);
  manna?.account.getBalance();
}

class Bank {
  dynamic amount = 0;
  Bank(amount) {
    this.amount = amount;
  }
  deposit(amount) {
    this.amount += amount;
    print("Deposited: $amount");
  }

  withdraw(amount) {
    if (this.amount >= amount) {
      this.amount -= amount;
      print("Withdrawn: $amount");
    } else {
      print("Insufficient balance for withdrawal of $amount");
    }
  }

  getBalance() {
    print("Current balance: $amount");
  }
}

class BankUser {
  String name;
  Bank account;

  BankUser(this.name, double initialAmount) : account = Bank(initialAmount);
}

class BankSystem {
  final List<BankUser> users = [];

  void addUser(String name, double initialAmount) {
    users.add(BankUser(name, initialAmount));
    print('User $name added with initial balance: $initialAmount');
  }

  BankUser? getUser(String name) {
    try {
      return users.firstWhere((user) => user.name == name);
    } catch (e) {
      return null;
    }
  }
}
