import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/Auth.dart';
import 'package:chodiapp/Models/User.dart';


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
          return MultiProvider(
            providers: [
              Provider<User>.value(value: user)
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context,snapshot);

      }
    );


  }


}