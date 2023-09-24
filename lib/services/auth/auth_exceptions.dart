//* login exceptions
// user not found exception
class UserNotFoundAuthException implements Exception {}

// wrong password exception
class WrongPasswordAuthException implements Exception {}

// * sign up exceptions
// weak password
class WeakPasswordAuthException implements Exception {}

// email already in use
class EmailAlreadyInUseAuthException implements Exception {}

// invalid email
class InvalidEmailAuthException implements Exception {}

// channel error
class EmptyFieldAuthException implements Exception {}

// generic exceptions
class GenericAuthException implements Exception {}

// User not logged in
class UserNotLoggedInAuthException implements Exception {}

// invalid phone number
class InvalidPhoneNumberAuthException implements Exception {}