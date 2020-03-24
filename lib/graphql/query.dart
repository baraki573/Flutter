class QueryBackend {
  String getContinents() {
    // for my testing, we can delete it later
    return r"""
      query GetContinent($code : String!){
        continent(code:$code){
          name
          countries{
            name
          }
        }
      }
      """;
  }

  String fileUpload(String token) {
    return r"""
      query{
        favouriteTours(token: "$token"){
          creation
          currentCheckpoints
          description
          difficulty
          id
          name
          owner{
            username
          }
          searchId
          sessionId
          status
          users{
            username
          }
        }
        
      }""";
  }

  String favObjects(String token) {
    //picture is wrong. needs subfield??
    return r"""
      query{
  favouriteObjects(token: "$token"){
    additionalInformation
    artType
    category
    creator
    description
    interdisciplinaryContext
    location
    material
    objectId
    size
    subCategory
    timeRange
    title
    year
    picture 
  }
}
    """;
  }

  static String allObjects(String token) {
    return """ query all{
      allObjects(token:"$token"){
        objectId
        title
      }
    } """;
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
