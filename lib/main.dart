// Main app and Pages for Tab Layout



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_future_stream/model/user.dart';
import 'package:provider_future_stream/services/event_provider.dart';
import 'package:provider_future_stream/services/user_provider.dart';

import 'model/data_provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataProvider()),
          FutureProvider(create: (_) => UserProvider().loadUserData()),
          StreamProvider(create: (_) => EventProvider().intStream(), initialData: 0)
        ],
        child: DefaultTabController(
            length: 3,
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Provider Demo"),
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.add)),
                      Tab(icon: Icon(Icons.person)),
                      Tab(icon: Icon(Icons.message)),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    MyCountPage(),
                    MyUserPage(),
                    MyEventPage(),
                  ],
                ),
              ),
            )
        )
      )
    );
  }
}
 
// Event page (counting)
class MyEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _value = Provider.of<int>(context);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('StreamProvider Example'),
            SizedBox(height: 150),
            Text('${_value.toString()}',
                style: Theme.of(context).textTheme.display1
            )
          ],
        )
      )
    );
  }
}
 
// User List Page
class MyUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _users = Provider.of<List<User>>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'FutureProvider Example, users loaded from a File'
          ),
        ),
        Expanded(
          child: _users == null ? Container(child: CupertinoActivityIndicator(radius: 50.0)) :
          ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index){
                return Container(
                    height: 50,
                    color: Colors.grey[(index*200) % 400],
                    child: Center(
                        child: Text(
                            '${_users[index].firstName} ${_users[index].lastName} | ${_users[index].website}'
                        )
                    )
                );
              }
          )
        )
      ],
    );
 
  }
}
 
// Counter Page
class MyCountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataProvider _data = Provider.of<DataProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ChangeNotifierProvider Example'),
            SizedBox(height: 150),
            Text(
              '${_data.value}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _data.increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
 

 

 

