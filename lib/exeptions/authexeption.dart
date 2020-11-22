class AuthException implements Exception {
  static const Map<String, String> errors = {
    "Auth failed": "Falha na autenticação",
    "Auth sucessful": "Autenticação foi feita",
    "OPERATION_NOT_ALLOWED": "Operação não permitida!",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Tente mais tarde!",
    "EMAIL_NOT_FOUND": "E-mail não encontrado!",
    "INVALID_PASSWORD": "Senha inválida!",
    "USER_DISABLED": "Usuário desativado!",
    "User created": "Usuário foi Criado!",
    "User already has this family's invite": "Usuário já tem este convite",
  };

  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    } else {
      return "Ocorreu um erro na autenticação!";
    }
  }
}
