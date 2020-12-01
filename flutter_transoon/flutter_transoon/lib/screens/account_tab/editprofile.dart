import 'package:flutter/material.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/home.dart';

class EditPro extends StatefulWidget {
  final UserRepository userRepository;
  final String displayName;
  EditPro({Key key, this.userRepository, this.displayName}) : super(key: key);
  @override
  State<EditPro> createState() => EditProState();
}

class EditProState extends State<EditPro> {
  var name = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.width / 3.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('assets/avatar.jpg')),
                color: Colors.red,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: TextField(
                controller: name,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    hintText: 'Input your name',
                    labelText: 'Name',
                    prefixIcon: const Icon(
                      Icons.perm_identity,
                      color: Colors.blue,
                    ),
                    prefixText: ' ',
                    suffixStyle: const TextStyle(color: Colors.green)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
              child: TextField(
                controller: phone,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    hintText: 'Input your phone',
                    labelText: 'Phone',
                    prefixIcon: const Icon(
                      Icons.perm_identity,
                      color: Colors.blue,
                    ),
                    prefixText: ' ',
                    suffixStyle: const TextStyle(color: Colors.green)),
              ),
            ),
            ButtonTheme(
              height: 50,
              minWidth: 100,
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                splashColor: Colors.blueAccent,
                onPressed: () async {
                  UserInfoUpdate dto = UserInfoUpdate(name.text, phone.text);
                  UserRepository user = UserRepository();
                  bool check = await user.updateBasicInfo(dto);
                  if (check) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeAuthentication(
                                  userRepository: widget.userRepository,
                                  displayName: widget.displayName,
                                )));
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
