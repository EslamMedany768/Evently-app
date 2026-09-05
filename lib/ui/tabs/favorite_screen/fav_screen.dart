import 'package:evantly_app/providers/firebase_provider.dart';
import 'package:evantly_app/providers/user_provider.dart';
import 'package:evantly_app/ui/tabs/widget/event_card_widget.dart';
import 'package:evantly_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../widget/customTextField.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {

    var eventListProvider = Provider.of<FirebaseProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if(eventListProvider.favList.isEmpty){eventListProvider.addFavListScreen(userProvider.currentUser!.id);}
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Customtextfield(
              borderColor: AppColors.blue,
              errorColor: Colors.red,
              name: "Search for Event",
              HintColor: AppColors.blue,
              prefixIcon: Icons.search,
              prefixColor: AppColors.blue,
            ),
          ),
          eventListProvider.favList.isEmpty
              ? Text("No favotite event added yet")
              : Expanded(
                  child: ListView.builder(
                    itemCount: eventListProvider.favList.length,
                    itemBuilder: (context, index) {
                      return EventCardWidget(
                          event: eventListProvider.favList[index]);
                    },
                  ),
                )
        ],
      ),
    );
  }
}
