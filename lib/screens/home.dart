// ignore_for_file: avoid_print, avoid_unnecessary_containers, unnecessary_this

import 'package:flutter/material.dart';
import 'package:nooooooooote/DB/SqlDb.dart';
import 'package:nooooooooote/screens/editNote.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqldb = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future readData() async {
    // List<Map> response = await sqldb.readData('SELECT * FROM ${sqldb.tb_Name}');
    List<Map> response = await sqldb.read(sqldb.tb_Name);
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('addNote');
        },
      ),
      body: isLoading == true
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text("Loading..."),
                ],
              ),
            )
          : Container(
              child: ListView(
                children: [
                  // MaterialButton(onPressed: () async{
                  //   await sqldb.deletingDatabase();
                  //   print("Deleted==================");
                  // },child: const Text("Delete Database"),),

                  // MaterialButton(onPressed: () async{
                  //   int response = await sqldb.insertData("INSERT INTO ${sqldb.tb_Name} (${sqldb.col_Title}, ${sqldb.col_Note}, ${sqldb.col_color}) VALUES ('note 2', 'Hello', 'Red')");
                  //   print(response);
                  // },child: const Text("Insert Database"),),
                  ListView.builder(
                      itemCount: notes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                            title: Text("${notes[i][sqldb.col_Title]}"),
                            subtitle: Text("${notes[i][sqldb.col_Note]}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    // int response = await sqldb.deleteData(
                                    //     "DELETE FROM ${sqldb.tb_Name} WHERE ${sqldb.col_Id} = ${notes[i][sqldb.col_Id]}");
                                        int response = await sqldb.delete(sqldb.tb_Name,
                                          'id = ${notes[i][sqldb.col_Id]}'
                                        );
                                        if (response > 0) {
                                      notes.removeWhere((element) =>
                                      element[sqldb.col_Id] ==
                                          notes[i][sqldb.col_Id]);
                                      setState(() {});
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => editNote(
                                        title: "${notes[i][sqldb.col_Title]}",
                                        note: "${notes[i][sqldb.col_Note]}",
                                        id: "${notes[i][sqldb.col_Id]}",
                                      )
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
    );
  }
}
