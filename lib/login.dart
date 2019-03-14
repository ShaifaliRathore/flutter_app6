import 'package:flutter/material.dart';
import 'home.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: new Stack(
              children: <Widget>[

                new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    ),
                  ),
                ),

                new Column(
                  children: <Widget>[

                    Container(
                        padding: EdgeInsets.only(
                            top: 80
                        ),
                        child: Image.asset('assets/icon.png')
                    ),

                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 120
                      ),
                      child: TextField(
                        controller: _usernameController,
                        //textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          //icon: Icon(Icons.mail),
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 5.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20
                      ),
                      child: TextField(
                        controller: _passwordController,
                        //textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          //icon: Icon(Icons.mail),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 5.0,
                            ),
                          ),

                        ),
                        obscureText: true,
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                      child: new CheckboxListTile(
                        value: false,
                        //onChanged: _onChanged,
                        title: Text("Remember me",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            )
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.only(
                            left: 220,
                          ),
                          child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blue,
                              )),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    new MaterialButton(
                        height: 50.0,
                        minWidth: 370,
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: new Text("LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16.0,
                                color: Colors.white
                            )),
                        onPressed: () {
                          String result = doLogin(_usernameController.text,
                              _passwordController.text);
                          print("--->" + result);
                          if (result == "success") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          }
                          //splashColor: Colors.redAccent,
                        }
                    )

                  ],
                )
              ],
            ),
          ),
        )
    );
  }

  doLogin(String username, String password) async {
    Dio dio = new Dio();
    final prefs = await SharedPreferences.getInstance();
    print(username + "----");
    print(password + "----");

    FormData formData = new FormData.from({
      "Username": username,
      "Password": password
    });

    Response response = await dio.post(
        "http://192.168.0.200/UBICRMNEW/AppDashboard", data: formData);
    print("------->" + response.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map employeeMap = json.decode(response.data);
      print(employeeMap.toString());
      if (employeeMap["status"] == 1) {
        print("----->" + employeeMap["status"].toString());
        prefs.setInt('response', employeeMap["status"]);
        prefs.setString('username', employeeMap["username"]);
        //prefs.setString('email', employeeMap["email"]);
        //prefs.setString('mobile', employeeMap["mobile"]);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), (
            Route<dynamic> route) => false,
        );
        return "success";
      } else {
        return "failure";
      }
    }
  }
}
