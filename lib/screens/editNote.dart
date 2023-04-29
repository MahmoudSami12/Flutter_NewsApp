// ignore_for_file: file_names, camel_case_types, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:nooooooooote/DB/SqlDb.dart';

import 'home.dart';

class editNote extends StatefulWidget {
  final note, title,id;
  const editNote({Key? key, this.note, this.title, this.id}) : super(key: key);

  @override
  State<editNote> createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  SqlDb sqldb = SqlDb();

  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                        // int response = await sqldb.updateData(
                        //     "UPDATE ${sqldb.tb_Name} SET '${sqldb.col_Title}' = '${title.text}', '${sqldb.col_Note}' = '${note.text}' WHERE ${sqldb.col_Id} = ${widget.id}");
                            int response = await sqldb.update(sqldb.tb_Name,
                              {
                                sqldb.col_Title : title.text,
                                sqldb.col_Note : note.text
                              },
                              '${sqldb.col_Id} = ${widget.id}'
                            );
                            print(response);
                        if(response > 0){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home()), (route) => false);
                        }
                      },
                      child: const Text("Edit Note"),
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
