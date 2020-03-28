import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:museum_app/graphql/graphqlConf.dart';
import 'package:museum_app/graphql/query.dart';

class Tutorials extends StatefulWidget {
  Tutorials({Key key}) : super(key: key);

  @override
  _TutorialsState createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryBackend addQuery = QueryBackend();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text('Tutorials'),
        ]),
      ),
      body: FlatButton(
        child: Text("Get"),
        onPressed: () async {
          GraphQLClient _client = graphQLConfiguration.clientToQuery();
          QueryResult result = await _client.query(
            QueryOptions(
                documentNode: gql(addQuery.getContinents()),
                variables: <String, dynamic>{"code": "AS"},
                pollInterval: 1),
          );
          debugPrint(result.data['continent']['countries'].length.toString());
        },
      ),
    ));
  }
}

// class Tutorials1 extends StatelessWidget {
//   final QueryBackend addMutation = QueryBackend();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 16),
//           child: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         title:
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
//           Text('Tutorials'),
//         ]),
//       ),
//       body: Query(
//         options: QueryOptions(
//             document: query,
//             variables: <String, dynamic>{"code": "AS"},
//             pollInterval: 1),
//         builder: (
//           QueryResult result, {
//           VoidCallback refetch,
//           FetchMore fetchMore,
//         }) {
//           if (result.loading) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (result.data == null) {
//             return Text("No Data Found !");
//           }
//           return ListView.builder(
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 title:
//                     Text(result.data['continent']['countries'][index]['name']),
//               );
//             },
//             itemCount: result.data['continent']['countries'].length,
//           );
//         },
//       ),
//     ));
//   }
// }
