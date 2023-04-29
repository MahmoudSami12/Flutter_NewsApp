// ignore_for_file: file_names, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:nooooooooote/DB/SqlDb.dart';

import 'home.dart';

class addNote extends StatefulWidget {
  const addNote({Key? key}) : super(key: key);

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  SqlDb sqldb = SqlDb();

  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
                key: formState,
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: note,
                      decoration: const InputDecoration(
                        hintText: 'Task',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        // int response = await sqldb.insertData(
                        //     "INSERT INTO ${sqldb.tb_Name} (${sqldb.col_Title}, ${sqldb.col_Note}) VALUES ('${title.text}', '${note.text}')");
                        int response = await sqldb.insert(sqldb.tb_Name,
                          {
                            sqldb.col_Title : title.text,
                            sqldb.col_Note : note.text,
                          }
                        );
                        print(response);
                        if(response > 0){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home()), (route) => false);
                        }
                      },
                      child: const Text("Add Note"),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
