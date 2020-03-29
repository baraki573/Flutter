import 'package:flutter/cupertino.dart';
import 'package:museum_app/database/database.dart';

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
    return """ query{
      allObjects(token: "$token"){
        additionalInformation
        artType
        category
        creator
        description
        interdisciplinaryContext
        location
        material
        objectId
        size_
        subCategory
        timeRange
        title
        year
        picture {
          id
        } 
      }
    } """;
  }

  static String tourSearchId(String token, String searchId) {
    return """query{
      tourSearchId(token: "$token", searchId: "$searchId")
    }""";
  }

  static String getTour(String token, String tourId) {
    return """query{
      tour(token: "$token", tourId: "$tourId"){
        creation
        currentCheckpoints
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        sessionId
        status
      }
    }""";
  }
  
  static String checkpointTour(String token, String tourId) {
    return """query{
      checkpointsTour(token: "$token", tourId: "$tourId"){
        ... on ObjectCheckpoint{
          index
          museumObject{
            objectId
          }
          showText
          showDetails
          showPicture
        }
        ... on Checkpoint{
          index
          text
        }
        ... on PictureCheckpoint{
          index
          id
        }
        ... on Question{
          index
          text
          question
        }
        ... on MCQuestion{
          index
          question
          possibleAnswers
          correctAnswers
          maxChoices
        }
      }
    }""";
  }

  static String allPictures(String token) {
    return """ query{
      availableProfilePictures(token:"$token")
    } """;
  }

  static String userInfo(String token) {
    return """query{
      me(token: "$token"){
        id
        producer
        profilePicture {
          id
        }
        badgeProgress
        badges {
          id
          name
          cost
          description
        }
      }
    }""";
  }

  static String favTours(String token) {
    return """query{
      favouriteTours(token: "$token"){
        id
      }
    }""";
  }

  static String favStops(String token) {
    return """query{
      favouriteObjects(token: "$token"){
        objectId
      }
    }""";
  }

  static String featured(String token) {
    return """query{
      featured(token: "$token"){
        creation
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        status
      }
    }""";
  }

  static created(String token) {
    return """query{
      ownedTours(token: "$token"){
        creation
        currentCheckpoints
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        sessionId
        status
      }
    }""";
  }

  static String availProfile(String token) {
    return """query{
      availableProfilePictures(token: "$token")
    }""";
  }

  static String imageURLProfile(String id) {
    return imageURL("ProfilePicture", id);
  }

  static String imageURLBadge(String id) {
    return imageURL("Badge", id);
  }

  static String imageURLPicture(String id) {
    return imageURL("Picture", id);
  }

  static String imageURL(String type, String id) {
    return "http://130.83.247.244/file/download?type=$type&id=$id";
  }

  static Widget netWorkImage(String url, {width = 50, height = 50, fit = BoxFit.cover}) {
    return FutureBuilder(
      future: MuseumDatabase().accessToken(),
      builder: (context, snap) {
        String token = snap.data ?? "";
        if (token=="") return Container();
        return Image.network(
          url,
          //GraphQLConfiguration().imageURLProfile("5e7e091dbef4a100e3735722"),
          headers: {"Authorization": "Bearer $token"},
          fit: fit,
          width: width.toDouble(),
          height: height.toDouble(),
        );
      },
    );
  }
}
