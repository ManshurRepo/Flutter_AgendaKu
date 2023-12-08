// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agendaku_app/data/datasources/task_remote_datasource.dart';
import 'package:agendaku_app/data/models/add_task_request_model.dart';
import 'package:flutter/material.dart';

import 'package:agendaku_app/pages/home_page.dart';

import '../data/models/task_response_model.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.task.attributes.title;
    descriptionController.text = widget.task.attributes.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Kegiatan',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Judul',
              border: OutlineInputBorder(),
            ),
            controller: titleController,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Deskripsi',
              border: OutlineInputBorder(),
            ),
            controller: descriptionController,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final newModel = AddTaskRequestModel(
                data: Data(
                    title: titleController.text,
                    description: descriptionController.text),
              );

              await TaskRemoteDatasource().updateTask(widget.task.id, newModel);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            },
            child: const Text('Ubah'),
          ),
        ],
      ),
    );
  }
}
