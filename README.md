# Dart and MongoDB

This project demonstrates how to access MongoDB database locally using the `mongo_dart` package.

## Download and Install MongoDB

For installing MongoDB visit [https://docs.mongodb.com/manual/administration/install-community/](https://docs.mongodb.com/manual/administration/install-community/) and select your OS for instructions.

## Upload json dataset into database (people.json)

(You can manually insert documents by creating a collection and then using the insert or insertMany function on your collection)

```bash
db.collection.insert(<document or array of documents>)
                OR
db.collection.insertMany([ <document 1> , <document 2>, ... ],)

```

1. Start your MongoDB server

   ```bash
   mongod
   ```

2. Import person.json with `mongoimport` executable

   ```bash
   mongoimport --jsonArray -d <yourDatabaseName> -c <yourCollectionName> --file <path/To/File.json>
   ```

## Run the project

Execute this command in your terminal:

```bash
dart main.dart
```

```bash
You can use the GET, POST, PUT, DELETE methods while making the request to the localhost 
and perform the basic CRUD operations on your database locally. (using the /people endpoint)
```
