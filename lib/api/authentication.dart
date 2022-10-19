import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService._();
  static final AuthService _service = AuthService._();
  factory AuthService() => _service;

  static AuthService get instance => _service;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  FirebaseAuth get fbauth=> _firebaseAuth;
  User? get currentUser => _firebaseAuth.currentUser;
  Future<User?> signinwithgoogle()async{
    try{
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile'
        ],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if(googleUser !=null){
        final googleAuth = await googleUser.authentication;
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            )
        );
        return userCredential.user;
      }
    }
    on FirebaseException catch(e){
      print(e.message);
    }
    catch(e){

      print(e.toString());
    }
  }
  Future<User?> signinwithemail(String email,String password)async{
    try{
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code=='weak-password'){

      }
      else if(e.code=='email-already-in-use'){

      }
      else{

      }
    }
    catch(e){

      print(e.toString());
    }
  }
  Future<User?> signinemail(String email,String password)async{
    try{
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code=='weak-password'){

      }
      else if(e.code=='email-already-in-use'){

      }
      else{

      }
    }
    catch(e){

      print(e.toString());
    }
  }
  Future<void> sendpasswordresetemail(String email)async{
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}