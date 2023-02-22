import 'package:firebase_crud_project/data/remote_data_source/firestore_helper.dart';
import 'package:flutter/material.dart';

import 'data/models/user_model.dart';

class EditPage extends StatefulWidget {
  final UserModel user;
  EditPage({Key? key, required this.user}) : super(key: key);


  @override
  State<EditPage> createState() => _EditPageState();

}

class _EditPageState extends State<EditPage> {

  TextEditingController? _usernameController;
  TextEditingController? _ageController;


  @override
  void initState(){
    // TODO: implement initState
    _usernameController = TextEditingController(text: widget.user.username);
    _ageController = TextEditingController(text: widget.user.age);
    super.initState();
  }
  @override
  void dispose(){
      _usernameController!.dispose();
      _ageController!.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Page"),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  TextFormField(
                   controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                      ),
                      hintText: "username",
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                   controller: _ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                      ),
                      hintText: "age",
                    ),
                  ),
                const SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      FirestoreHelper.update(
                          UserModel(
                            Id: widget.user.Id,
                            username: _usernameController!.text,
                            age: _ageController!.text,
                          ),
                      ).then(
                              (value) => Navigator.pop(context));
                    },

                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            " Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ));
  }
}
