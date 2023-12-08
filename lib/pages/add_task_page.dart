import 'package:agendaku_app/data/datasources/task_remote_datasource.dart';
import 'package:agendaku_app/data/models/add_task_request_model.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tambahkan Agenda',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 2,
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          children: [
            TextField(
              controller: titlecontroller,
              decoration: const InputDecoration(
                hintText: 'Nama Kegiatan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptioncontroller,
              decoration: const InputDecoration(
                hintText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final model = AddTaskRequestModel(
                  data: Data(
                      title: titlecontroller.text,
                      description: descriptioncontroller.text),
                );
                final response = await TaskRemoteDatasource().addTask(model);
                Navigator.pop(context);
              },
              child: const Text('Tambahkan'),
            ),
          ],
        ));
  }
}
