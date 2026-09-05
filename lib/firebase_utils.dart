import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evantly_app/model/my_user.dart';

import 'model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection().doc(uId)
        .collection(Event.EventNameCollection)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, options) => MyUser.toJson(user),
        );
  }

  static Future<void> addUserToFireStore(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot = await getUserCollection().doc(id).get();
    return querySnapshot.data();
  }

  static Future<void> addEventToFireStore(Event event,String uId) {
    var collection = getEventCollection(uId);
    var doc = collection.doc();
    event.id = doc.id;
    return doc.set(event);
  }
  static Future<void> updateEventInFireStore(String uId,Event event){
   return getEventCollection(uId).doc(event.id).update(event.toFireStore());
  }
  static Future<void> deleteEventInFireStore(String uId,Event event){

    return getEventCollection(uId).doc(event.id).delete();
  }

}
