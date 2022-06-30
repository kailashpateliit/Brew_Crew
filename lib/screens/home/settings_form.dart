// import 'package:brew_crew/model/user_model.dart';
// import 'package:brew_crew/services/database.dart';
// import 'package:brew_crew/services/loading.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
//
// class FormSettings extends StatefulWidget {
//   const FormSettings({Key? key}) : super(key: key);
//
//   @override
//   _FormSettingsState createState() => _FormSettingsState();
// }
//
// class _FormSettingsState extends State<FormSettings> {
//
//   final _formKey = GlobalKey<FormState>();
//   final List<String> sugar = ['0','1','2','3','4','5'];
//
//   //entries in the form
//    String? _currentName;
//    int? _currentStrength;
//    String? _currentSugar;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final user = Provider.of<UserModel>(context);
//     CollectionReference collectionReference = FirebaseFirestore.instance.collection(user.uid);
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: collectionReference.snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         print(user.uid);
//
//         if(snapshot.hasData){
//           return Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//
//                   //heading
//                   Text('Update your profile',style: TextStyle(fontSize: 20),),
//                   SizedBox(height: 20),
//
//                   //Name entry
//                   TextFormField(
//                     initialValue: snapshot.data!.docs[0]['name'],
//                     validator: (val) => val!.isEmpty? 'Please enter your name' : null,
//                     onChanged: (val){
//                       _currentName = val;
//                     },
//                   ),
//                   SizedBox(height: 20),
//
//                   //dropdown menu for sugar
//                   DropdownButtonFormField(
//                     value: _currentSugar??snapshot.data!.docs[0]['sugar'],
//                     items: sugar.map((sugars){
//                       return DropdownMenuItem(
//                         value: sugars,
//                         child: Text('$sugars sugars'),
//                       );
//                     }).toList(),
//                     onChanged: (val){
//                       setState(() {
//                         _currentSugar = val.toString();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 20),
//
//
//                   //Slider for strength
//                   Slider(
//                       value: (_currentStrength??snapshot.data!.docs[0]['strength']).toDouble() ,
//                       activeColor: Colors.brown[_currentStrength??snapshot.data!.docs[0]['strength']],
//                       inactiveColor: Color(0xA1DEB3AB),
//                       min:100.0 ,
//                       max: 900.0,
//                       divisions: 8,
//                       onChanged: (val){
//                         setState(() {
//                           _currentStrength = val.round();
//                         });
//                       }),
//                   SizedBox(height: 10),
//
//
//
//                   //Submit button
//                   TextButton(
//                       style: TextButton.styleFrom(
//                         primary: Colors.white,
//                         backgroundColor: Colors.brown,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         elevation: 10,
//                       ),
//                       onPressed: ()async{
//                         print(_currentName);
//                         print(_currentStrength);
//                         print(_currentSugar);
//                       },
//                       child: Text('Submit',style: TextStyle(color: Colors.white),)),
//                 ],
//               ),
//             ),
//           );
//         }
//         else {
//           if(snapshot.hasError)throw('$snapshot.error');
//           print('enjoy the infinite loading');
//           return Loading();
//         }
//       }
//     );
//   }
// }
import 'package:brew_crew/model/user_model.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/services/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FormSettings extends StatefulWidget {
  const FormSettings({Key? key}) : super(key: key);

  @override
  _FormSettingsState createState() => _FormSettingsState();
}

class _FormSettingsState extends State<FormSettings> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugar = ['0','1','2','3','4','5'];

  //entries in the form
  String? _currentName;
  int? _currentStrength;
  String? _currentSugar;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);
    String uid = user.uid;
    Stream<DocumentSnapshot> _userData = FirebaseFirestore.instance.collection('brews').doc(uid).snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: _userData,
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        if(snapshot.hasError) {
          throw '$snapshot.error';
        }
        // if(snapshot.hasData)print(snapshot.data!.get('strength'));

        if (snapshot.hasData) {


          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/coffee_settings_form.png'),
              fit: BoxFit.fill),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    //heading
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('Update your profile',style: TextStyle(fontSize: 20),),
                    ),
                    SizedBox(height: 20),

                    //Name entry
                    TextFormField(
                      initialValue: _currentName ?? snapshot.data!.get('name'),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)),
                          hoverColor: Colors.white,
                          hintText: 'Name'
                      ),
                      validator: (val) => val!.isEmpty? 'Please enter your name' : null,
                      onChanged: (val){
                        _currentName = val;
                        //print(_currentName);
                      },
                    ),
                    SizedBox(height: 20),


                    //dropdown menu for sugar
                    DropdownButtonFormField(
                      value: _currentSugar ?? snapshot.data!.get('sugar'),
                      items: sugar.map((sugars){
                        return DropdownMenuItem(
                          value: sugars,
                          child: Text('$sugars sugars'),
                        );
                      }).toList(),
                      onChanged: (val){
                        setState(() {
                          _currentSugar = val.toString();
                        });
                      },
                    ),


                    //Slider for strength
                    Slider(
                        value: (_currentStrength ?? snapshot.data!.get('strength')).toDouble() ,
                        activeColor: Colors.brown[_currentStrength ?? snapshot.data!.get('strength')],
                        inactiveColor: Color(0xA1DEB3AB),
                        min:100.0 ,
                        max: 900.0,
                        divisions: 8,
                        onChanged: (val){
                          setState(() {
                            _currentStrength = val.round();
                          });
                        }),
                    SizedBox(height: 10),


                    //Submit button
                    TextButton(

                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.brown[800],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                        onPressed: ()async{
                          // if(_currentName==null) {
                          //   _currentName = snapshot.data!.get('name');
                          // }
                          // if(_currentSugar==null) {
                          //     _currentSugar = snapshot.data!.get('sugar');
                          //   }
                          //   if(_currentStrength==null) {
                          //     _currentStrength = snapshot.data!.get('strength');
                          //   }
                          print( _currentName ?? snapshot.data!.get('name'));
                          print(_currentStrength ?? snapshot.data!.get('strength'));
                          print( _currentSugar ?? snapshot.data!.get('sugar'));
                          if(_formKey.currentState!.validate()){
                            await DatabaseService(uid: uid).updateUserData(
                                _currentSugar ?? snapshot.data!.get('sugar'),
                                _currentName ?? snapshot.data!.get('name'),
                                _currentStrength ?? snapshot.data!.get('strength'));
                          }
                          Navigator.pop(context);
                        },
                        child: Text('Submit')),
                  ],
                ),
              ),
            ),
          );
        }
        else
          return Loading();
      }
    );
  }
}



