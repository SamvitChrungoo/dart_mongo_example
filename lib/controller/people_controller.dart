import 'package:dart_mongo_example/dart_mongo.dart';

class PeopleController {
  PeopleController(this._reqBody, Db db)
      : _req = _reqBody.request,
        _store = db.collection('people') {
    handle();
  }

  final HttpRequestBody _reqBody;
  final HttpRequest _req;
  final DbCollection _store;

  void handle() async {
    switch (_req.method) {
      case 'GET':
        await handleGet();
        break;
      case 'POST':
        await handlePost();
        break;
      case 'PUT':
        await handlePut();
        break;
      case 'DELETE':
        await handleDelete();
        break;
      default:
        _req.response.statusCode = 405;
    }
    await _req.response.close();
  }

  void handleGet() async {
    if (_req.uri.queryParameters['id'] == null) {
      _req.response.write(await _store.find().toList());
    } else {
      var id = int.parse(_req.uri.queryParameters['id']);
      var itemToGet = await _store.findOne(where.eq('id', id));
      _req.response.write(itemToGet);
    }
  }

  void handlePost() async {
    _req.response.write(await _store.save(_reqBody.body));
  }

  void handlePut() async {
    var id = int.parse(_req.uri.queryParameters['id']);
    var itemToPut = await _store.findOne(where.eq('id', id));

    if (itemToPut == null) {
      await _store.save(_reqBody.body);
    } else {
      await _store.update(itemToPut, _reqBody.body);
    }
  }

  void handleDelete() async {
    var id = int.parse(_req.uri.queryParameters['id']);
    var itemToDelete = await _store.findOne(where.eq('id', id));
    if (itemToDelete != null) {
      _req.response.write(await _store.remove(itemToDelete));
    }
  }
}
