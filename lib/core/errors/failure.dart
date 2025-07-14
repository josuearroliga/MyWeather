abstract class Failure {
  final String message;
  const Failure(this.message);
}

// Auth-related failures
class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure([String? message])
    : super(message ?? 'Invalid email or password');
}

class WeatherNotFoundFailure extends Failure {
  const WeatherNotFoundFailure([String? message])
    : super(message ?? 'Weather not found');
}

class WeatherAlreadyExistsFailure extends Failure {
  const WeatherAlreadyExistsFailure([String? message])
    : super(message ?? 'Weather already exists');
}

// Server failure
class ServerFailure extends Failure {
  const ServerFailure([String? message]) : super(message ?? 'Server error');
}

// General Firebase failure
class FirebaseFailure extends Failure {
  FirebaseFailure([String? message]) : super(message ?? 'Firebase error');
}

// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure([String? message])
    : super(message ?? 'No internet connection');
}

// Unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure([String? message])
    : super(message ?? 'Unexpected error');
}
