import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static HttpLink httpLink =
      //HttpLink(uri: 'https://countries.trevorblades.com/');
      HttpLink(uri: 'http://http://247-244.gugw.tu-darmstadt.de/app');

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
