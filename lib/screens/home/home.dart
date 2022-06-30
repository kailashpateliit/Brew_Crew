import 'package:brew_crew/model/brew_model.dart';
import 'package:brew_crew/model/user_model.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    //This is responsible for displaying the bottom Sheet on clicking the settings button
    final user = Provider.of<UserModel?>(context);

    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                child: Provider(
                  create: (_) => UserModel(uid: user!.uid),
                  child: FormSettings(),
                ));
          });
    }

    return StreamProvider<List<BrewModel>?>.value(
      catchError: (_,__) => null,
      initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Color(0xFFDCC7C0),
        appBar: AppBar(
          title: Text('Brew Crew',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.brown[300],
          actions: [
            TextButton.icon(onPressed: ()async{
              await _auth.signOut();
            },
                icon: Icon(Icons.power_settings_new, color: Colors.black,),
                label: Text('Logout',style: TextStyle(color: Colors.black),)
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/coffee_home.jpeg'),
                fit: BoxFit.fill,
            ),
          ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: BrewList(),
            )
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showSettingPanel();
          },
          backgroundColor: Colors.brown[100],
          child:Icon(Icons.settings,color: Colors.black),

        ),
      ),
    );
  }
}
