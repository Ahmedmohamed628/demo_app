// error handling using dartz package (future feature=> using sealed class):
abstract class Failure {
  final String message;

  const Failure(this.message);
}

//error coming from server or network issues (Api error)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// If you want to create a cache or local database error in the future
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// todo: in case using sealed class instead of dartz package to handle the error:
// // كلاس sealed معناه إن محدش يقدر يورث منه بره الملف ده، والـ compiler عارف كل أولاده
// sealed class Result<Failure, Success> {}
//
// // failure case
// class FailureResult<Failure, Success> extends Result<Failure, Success> {
//   final Failure failure;
//   FailureResult(this.failure);
// }
//
// // حالة النجاح
// // success case
// class SuccessResult<Failure, Success> extends Result<Failure, Success> {
//   final Success success;
//   SuccessResult(this.success);
// }
