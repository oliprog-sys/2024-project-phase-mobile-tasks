
class StrongPasswordChecker {
  bool isStrongPassword(String password) {
    // Returns true if password meets all criteria:
    // - At least 8 characters
    // - Contains uppercase and lowercase letters
    // - Contains at least one digit
    // - Contains at least one special character
    return password.length >= 8 &&
           RegExp(r'[A-Z]').hasMatch(password) && // has uppercase
           RegExp(r'[a-z]').hasMatch(password) && // has lowercase
           RegExp(r'\d').hasMatch(password) &&    // has digit
           RegExp(r'[!@#\$&*~]').hasMatch(password); // has special character
  }
}

void main() {
  var passwordChecker = StrongPasswordChecker();

  var passwordsToTest = [
    "Password123!",
    "weakpass",
    "NoSpecialChar1",
    "Short1!",
    "StrongPass1@"
  ];

  for (var password in passwordsToTest) {
    if (passwordChecker.isStrongPassword(password)) {
      print('"$password" is a strong password.');
    } else {
      print('"$password" is not a strong password.');
    }
  }
}