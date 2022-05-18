abstract class ParamUseCase<Type, Params> {
  Future<Type> execute(Params params);
}

abstract class ParamStreamUseCase<Type, Params> {
  Stream<Type> execute(Params params);
}
