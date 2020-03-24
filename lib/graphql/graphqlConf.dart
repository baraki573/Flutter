import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

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

  // static AuthLink _authLink = AuthLink(
  //   getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
  // );

  // static Link _link = _authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
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
