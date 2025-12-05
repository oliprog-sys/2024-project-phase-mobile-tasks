
abstract class Failure {
  final String message;

  Failure({this.message = "Unexpected Failure"}); 

  @override
  String toString() => message;
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}