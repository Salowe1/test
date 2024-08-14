import 'package:mongo_dart/mongo_dart.dart';

class MongoDB {
  static late Db db;
  static late DbCollection userCollection;

  static Future<void> connect() async {
    db = await Db.create("mongodb+srv://salowe:Adouabou102001.@lockre.xrasr0e.mongodb.net/?retryWrites=true&w=majority&appName=Lockre");
    await db.open();
    userCollection = db.collection("lockre");
    print('MongoDB Connected');
  }
}
