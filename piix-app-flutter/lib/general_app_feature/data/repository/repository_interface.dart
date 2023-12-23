abstract class Repository {
  Future<T> get<T>() async {
    throw Error();
  }

  Future<T> getAll<T>() async {
    throw Error();
  }

  Future<T> put<T>(T model) async {
    throw Error();
  }

  Future<T> post<T>(T model) async {
    throw Error();
  }

  Future<T> delete<T>() async {
    throw Error();
  }
}
