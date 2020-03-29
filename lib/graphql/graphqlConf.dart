import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";
import 'package:museum_app/database/database.dart';

class GraphQLConfiguration {
  static GraphQLConfiguration _gc;

  factory GraphQLConfiguration() {
    _gc ??= GraphQLConfiguration._internal();
    return _gc;
  }

  GraphQLConfiguration._internal();

  static HttpLink httpLink =
      //HttpLink(uri: 'https://countries.trevorblades.com/');
  HttpLink(uri: 'http://130.83.247.244/app/');

  static AuthLink _authLink = AuthLink(
     getToken: () async {
       String token = await MuseumDatabase().accessToken();
       return 'Bearer $token';
       },
   );

  static Link _link = _authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: _link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}
