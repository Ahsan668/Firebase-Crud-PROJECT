import 'dart:math';

import 'package:firebase_crud_project/data/models/user_model.dart';
import 'package:firebase_crud_project/data/remote_data_source/firestore_helper.dart';
import 'package:firebase_crud_project/edit_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final TextEditingController _usernameController = TextEditingController();
 final TextEditingController _ageController = TextEditingController();

 @override
 void dispose(){
   _usernameController.dispose();
   _ageController.dispose();

   super.dispose();
 }

 @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Firebase CRUD"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children:[
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
                const SizedBox(height: 10,),
                InkWell(
                onTap: (){
                FirestoreHelper.create(UserModel(
                  username: _usernameController.text,
                  age: _ageController.text,
                ));
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
                        " Create",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
                const SizedBox(height: 10,),
                StreamBuilder<List<UserModel>>(
                  stream: FirestoreHelper.read(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    } if(snapshot.hasError){
                      return const Center(child: Text("some error has occurred"),);
                    } if(snapshot.hasData){
                      final userData = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: userData!.length,
                            itemBuilder: (context, index){
                          final singleUser = userData[index];
                              return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                title: Text("${singleUser.username}"),
                                subtitle: Text("${singleUser.age}"),
                                trailing: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                      MaterialPageRoute(builder: (context) => EditPage(
                                        user: UserModel(
                                          username: singleUser.username,
                                          age: singleUser.age,
                                          Id: singleUser.Id,
                                        ),)
                                      ),
                                      );
                                    },
                                    child: Icon(Icons.edit)),
                            ),
                          );
                              }
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                ),
              ],
            ),
          ),

        ));
  }

}