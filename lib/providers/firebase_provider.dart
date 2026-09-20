import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/event.dart';

class FirebaseProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Event> eventList = [];
  List<Event> filterList = [];
  List<Event> favList = [];
  List<String> eventTitle = [
    "All",
    'Sport',
    "Birthday",
    'Meeting',
    "Gaming",
    "Workshop",
    "Book Club",
    "Exhibition",
    "Holiday",
    "Eating"
  ];


  void getAllEvent(String uId) async {


    QuerySnapshot<Event> collection =
        await FirebaseUtils.getEventCollection(uId).get();
    eventList = collection.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    eventList.sort(
      (a, b) {
        return a.history.compareTo(b.history);
      },
    );
    filterList = eventList;
    notifyListeners();
  }

  void getFilterEvent(String uId) async {
    QuerySnapshot<Event> collection =
        await FirebaseUtils.getEventCollection(uId).get();
    eventList = collection.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    filterList = eventList.where(
      (event) {
        return event.eventName == eventTitle[selectedIndex];
      },
    ).toList();
    filterList.sort(
      (Event event1, Event event2) {
        return event1.history.compareTo(event2.history);
      },
    );
    notifyListeners();
  }

   changeSelectedIndex(int index,String uId) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      getAllEvent(uId);
    } else {
      getFilterEvent(uId);
    }
  }

  void updateIsFavoriteEvent(Event event,String uId) async {
    await FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({"isfav": !event.isfav}).timeout(
      Duration(milliseconds: 200),
      onTimeout: () {},
    );

    selectedIndex == 0 ? getAllEvent(uId) : getFilterEvent(uId);

    addFavListScreen(uId);
    // notifyListeners();
  }

  void addFavListScreen(String uId) async {
    var collection = await FirebaseUtils.getEventCollection(uId)
        .orderBy("history", descending: false)
        .where("isfav", isEqualTo: true)
        .get();
    favList = collection.docs.map(
      (docs) {
        return docs.data();
      },
    ).toList();
    notifyListeners();
  }
  clearAll(){
    favList=[];
    filterList=[];
    eventList=[];
    notifyListeners();
  }

}
