import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('User',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            accountEmail: Text('UesrEmail',),
            decoration: BoxDecoration(
             color: Colors.blue
            ),
            /* currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                //radius: 50.0,
                backgroundColor: Color(0xFF1B5E20),
                child: Icon(Icons.person, color: Colors.white, size: 40.0),
              ),
            ),*/
          ),
          ListTile(leading: Icon(Icons.dashboard,),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage()));
            },
          ),
          ListTile(leading: Icon(Icons.mail,),
            title: Text('Leads'),
            onTap: () {

            },
          ),
          ListTile(leading: Icon(Icons.calendar_today,),
            title: Text('Events'),
            onTap: () {

            },
          ),
          ListTile(leading: Icon(Icons.photo_library,),
            title: Text('Users and Privilages'),
            onTap: () {

            },
          ),
          Divider(),
          /*ListTile(leading: Icon(Icons.import_contacts, color: Color(0xFF1B5E20)),
              title: Text('Courses'),),
            ListTile(leading: Icon(Icons.assignment, color: Color(0xFF1B5E20)),
              title: Text('Syllabus'),
            ),*/
          ListTile(leading: Icon(Icons.location_city, color: Color(0xFF1B5E20)),
            title: Text('Products'),
            onTap: () {

            },
          ),
          ListTile(leading: Icon(Icons.help, color: Color(0xFF1B5E20)),
            title: Text('Customers'),
            onTap: () {

            },
          ),
          ListTile(leading: Icon(Icons.feedback, color: Color(0xFF1B5E20)),
            title: Text('Files and Folders'),
            onTap: () {

            },
          ),
          Divider(),
          ListTile(leading: Icon(Icons.lock, color: Color(0xFF1B5E20)),
            title: Text('Reports'),
            onTap: () {

            },
          ),
          ListTile(leading: Icon(Icons.input, color: Color(0xFF1B5E20)),
            title: Text('Settings'),
            onTap: (){

            },
          ),
          ListTile(leading: Icon(Icons.input, color: Color(0xFF1B5E20)),
          title: Text('Logout'),
          onTap: (){
            doLogout(context);
          },
          )
        ],
      ),
    );
  }

  doLogout(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('response');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false,
    );
  }
}
