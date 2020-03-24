import 'package:flutter/material.dart';

class MutationBackend {
  static String addPerson(String id, String name, String lastName, int age) {
    return """
mutation{
addPerson(id: "$id", name: "$name", lastName: "$lastName", age: "$age"){
id
name
lastName
age
}
}
""";
  }

  static String auth(String password, String username) {
    return '''
    mutation{
      auth(password: "$password", username: "$username")
      {
        accessToken
        refreshToken
        ok
  }
}
''';
  }

  static String createUser(String password, String username) {
    return """
    mutation{
      createUser(password: "$password", username: "$username"){
        user{
          username
          password
        }
        ok
      }
    }""";
  }

  static String changePassword(String token, String password) {
    return """
    mutation{
  changePassword(password: "$password", token: "$token")
  {
    ok { ... on BooleanField{boolean}}
  }
}
    """;
  }

  static String chooseProfilePicture(String id, String token) {
    return r"""
    mutation{
  chooseProfilePicture(pictureId: "$id", token: "$token"){
    ok { ... on BooleanField{boolean}}
  }
}
    """;
  }

  static String fileUpload(Image file) {
    return r"""
      mutation{
  fileUpload(file:$file ){
    success
  }
}
    """;
  }

  String func() {
    return r"""

    """;
  }

  String func2() {
    return r"""

    """;
  }

  String func3() {
    return r"""

    """;
  }
}
