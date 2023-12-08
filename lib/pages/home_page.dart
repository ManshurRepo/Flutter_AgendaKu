import 'dart:ffi';

import 'package:agendaku_app/data/datasources/task_remote_datasource.dart';
import 'package:agendaku_app/data/models/task_response_model.dart';
import 'package:agendaku_app/pages/add_task_page.dart';
import 'package:agendaku_app/pages/detail_task_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;

  List<Task> tasks = [];

  Future<void> getTasks() async {
    setState(() {
      isLoaded = true;
    });
    final model = await TaskRemoteDatasource().getTask();
    tasks = model.data;

    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Task List',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.lightBlueAccent,
        // actions: [IconButton(onPressed: () {},
        // icon: const Icon(Icons.add),
        // ),
        // ],
      ),
      body: isLoaded
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailTaskPage(
                        task: tasks[index],
                      );
                    }));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(tasks[index].attributes.title),
                      subtitle: Text(tasks[index].attributes.description),
                      trailing: const Icon(Icons.check_circle),
                    ),
                  ),
                );
              },
              itemCount: tasks.length,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddTaskPage();
          }));
          getTasks();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
