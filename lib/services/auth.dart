import 'package:brew_crew/model/user_model.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  UserModel? _userFromFirebase(User? user){
    return user!=null ? UserModel(uid: user.uid) : null;
  }

  //creating stream for auth change
  Stream<UserModel?> get user{
    return _auth.authStateChanges().map(_userFromFirebase);
  }


  //sign in anonymously
  Future signInAnon()async{
    try{
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return user;
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email,String password)async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebase(user);
    }catch (e) {
      print(e.toString());
    }
  }

  //sign up with email & password
  Future registerWithEmailAndPassword(String email,String password)async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      //create a new document for user under new uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
    }
  }

  //sign out
  Future signOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e)
    {
        print(e.toString());
        return null;
    }
  }

}