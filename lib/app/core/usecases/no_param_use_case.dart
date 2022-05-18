abstract class NoParamUseCase<Type> {
  Future<Type> execute();
}

abstract class NoParamStreamUseCase<Type> {
  Stream<Type> execute();
}
