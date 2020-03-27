import 'package:path_provider/path_provider.dart';
import 'package:test/test.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/graphql/query.dart';

void main() {
  //GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  //GraphQLClient _client = graphQLConfiguration.clientToQuery();
  //QueryBackend addQuery = QueryBackend();
  WidgetsFlutterBinding.ensureInitialized();
  QueryBackend addQuery = QueryBackend();
  // test('Graphql_test', () async {
  //   GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  //   GraphQLClient _client = graphQLConfiguration.clientToQuery();
  //   QueryBackend addQuery = QueryBackend();

  //   QueryResult result = await _client.query(
  //     QueryOptions(
  //         documentNode: gql(addQuery.getContinents()),
  //         variables: <String, dynamic>{"code": "AS"},
  //         pollInterval: 1),
  //   );
  //   var my = result.data['continent']['countries'].length.toString();
  //   expect(my, '52');
  // });

  test('graphql', () async {
    QueryOptions _queryOptions() {
      return QueryOptions(
          documentNode: gql(addQuery.getContinents()),
          variables: <String, dynamic>{"code": "AS"},
          pollInterval: 1);
    }

    QueryResult result = await getGraphQLClient().query(_queryOptions());
    var my = result.data['continent']['countries'].length.toString();
    expect(my, 52);
  });

  test('1+2', () {
    expect(3, 3);
  });
}

final HttpLink _httpLink = HttpLink(
  uri: 'https://countries.trevorblades.com/',
);
final Link _link = _httpLink;
GraphQLClient _client;
// Create a common client for further requests
GraphQLClient getGraphQLClient() {
  _client ??= GraphQLClient(
      link: _link, cache: InMemoryCache()); // Provide a cache mechanism

  return _client;
}
