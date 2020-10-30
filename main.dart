import 'package:dart_mongo_example/dart_mongo.dart';

void main() async {
  var port = 4000;
  var dbName = 'dart_test';

  var server = await HttpServer.bind('localhost', port);
  var db = Db('mongodb://localhost:27017/$dbName');
  await db.open();

  print('Connected to database --- $dbName');

  server.transform(HttpBodyHandler()).listen((HttpRequestBody reqBody) async {
    var request = reqBody.request;
    var response = request.response;

    switch (request.uri.path) {
      case '/':
        response.write('This is an API to interact with MongoDB (locally)');
        await response.close();
        break;
      case '/people':
        PeopleController(reqBody, db);
        break;
      default:
        response
          ..statusCode = HttpStatus.notFound
          ..write('Not Found');
        await response.close();
    }
  });

  print('Server listening at http://localhost:$port');
}
