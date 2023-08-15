// All the try catch blocks are handled in the sign up form
// This is just to handle the errors that are not caught in the form
// This is the failure class for the sign up with email and password use case

class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "An unknown error occurred."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Please enter a stronger password.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure('Email already in use.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'Please enter a valid email.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed. please contact support.');
      case 'too-many-requests':
        return const SignUpWithEmailAndPasswordFailure(
            'Too many requests. Please try again later.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support.');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
