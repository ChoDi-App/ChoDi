import 'package:chodiapp/services/auth.dart';
import 'package:chodiapp/services/firebase_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chodiapp/models/user.dart';
import 'Services/firestore.dart';
import 'models/events.dart';
import 'services/auth.dart';


class AuthWidgetBuilder extends StatelessWidget{
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext,AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context){
    print('AuthWidgetBuilder rebuild');
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.user,
      builder: (context,snapshot){
        print('StreamBuilder: ${snapshot.connectionState}');
        final User user = snapshot.data;
        if (user != null){
          //print(user.uid);
          return MultiProvider(
            providers: [
              StreamProvider<UserData>.value(value: FirestoreService(uid: user.uid).userData),
              Provider<FirebaseStorageService>(
                create: (_) => FirebaseStorageService(uid: user.uid),
              ),
              StreamProvider<List<Events>>.value(value: FirestoreService().eventsData,
                initialData: [],
              catchError: (_,__)=> [],),

              //StreamProvider<User>.value(value: DatabaseService(uid: user.uid)
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context,snapshot);

      }
    );


  }


}