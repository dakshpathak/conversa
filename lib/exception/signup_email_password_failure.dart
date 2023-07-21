class SignUpWithEmailPasswordFailure{

  final String message;

  SignUpWithEmailPasswordFailure([this.message = "An unknown error occurred"]);

  factory SignUpWithEmailPasswordFailure.code (String code){

    switch(code){
      case 'weak-password':
        return SignUpWithEmailPasswordFailure('Please enter a strong password');

      case 'invalid-email':
        return SignUpWithEmailPasswordFailure('Email is not valid or badly formatted');

      case 'operation-not-allowed':
        return SignUpWithEmailPasswordFailure('operation is not allowed. Please contact support');

      case 'email-already-in-use':
        return SignUpWithEmailPasswordFailure('An account already exists for that email');

      case 'user-disabled':
        return SignUpWithEmailPasswordFailure('this user has been disabled.');

      default:
        return SignUpWithEmailPasswordFailure();
    }
  }
}