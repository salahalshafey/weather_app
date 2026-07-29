/// Contract for a single domain operation.
abstract interface class UseCase<Result, Params> {
  Future<Result> call(Params params);
}
