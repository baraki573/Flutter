import 'package:flutter/material.dart';

class MutationBackend {
  String addPerson(String id, String name, String lastName, int age) {
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

  String auth(String password, String username) {
    return r"""
    mutation{
      auth(password: "$password", username: "$username")
      {
        accessToken
        refreshToken
        ok
  }
}
""";
  }

  String createUser(String password, String username) {
    return r"""
    mutation{
      mutation{
      createUser(password: "$password", username: "$username"){
        user{
          username
          password
        }
    ok
  }
}
}
""";
  }

  String changePassword(String token, String password) {
    return r"""
    mutation{
  changePassword(password: "$password", token: "$token")
  {
    ok { ... on BooleanField{boolean}}
  }
}
    """;
  }

  String chooseProfilePicture(String id, String token) {
    return r"""
    mutation{
  chooseProfilePicture(pictureId: "$id", token: "$token"){
    ok { ... on BooleanField{boolean}}
  }
}
    """;
  }

  String fileUpload(Image file) {
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
