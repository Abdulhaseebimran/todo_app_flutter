import 'dart:html';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> ChatsNames = ["Haseeb", "Bilal"];
  TextEditingController MyTextController = TextEditingController();
  TextEditingController updatingnames = TextEditingController();
  TextEditingController editTodoController = TextEditingController();

  addNames() {
    setState(() {
      ChatsNames.add(MyTextController.text);
      MyTextController.clear();
    });
    print(ChatsNames);

    deleteChats(int index) {
      ChatsNames.removeAt(index);
    }
  }

   editTodo(i) {
  ChatsNames[i] = editTodoController.text;
    editTodoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text("MY TODO APP"), centerTitle: true,
      //  foregroundColor: Colors.black,backgroundColor: Colors.white,
       leading: Icon(Icons.check_box_outlined,
       size: 45, color: Colors.white,),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "ENTER TODO",
            ),
            controller: MyTextController,
            autocorrect: true,
            cursorHeight: 10,
            autofocus: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: (){addNames();}, child: const Text("ADD TODO")),
          Expanded(
            child: ListView.builder(
                itemCount: ChatsNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      tileColor: Colors.blueAccent,
                      focusColor: Colors.white,
                      title: Text("${ChatsNames[index]}"),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width*0.2,
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                title: const Text("EDIT"),
                                 content: TextField(
                                  controller: editTodoController,
                                 ), actions: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.of(context).pop();
                                    setState(){
                                      ChatsNames.replaceRange(
                                                index,
                                                index + 1,
                                                {editTodoController.text},
                                              );
                                              updatingnames.clear();
                                    }
                                  }, child: const Text("EDIT")),
                                 ],
                                 );
                              });
                            }, icon: const Icon(Icons.edit)),
                            IconButton(onPressed: (){
                             deleteChats(index);
                            }, icon: const Icon(Icons.delete))
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ),
        ],
      ),
    );
  }

  void deleteChats(int index) {}
}