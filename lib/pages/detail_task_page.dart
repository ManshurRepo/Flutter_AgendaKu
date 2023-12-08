// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agendaku_app/data/datasources/task_remote_datasource.dart';
import 'package:agendaku_app/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:agendaku_app/pages/edit_task_page.dart';

import '../data/models/task_response_model.dart';

class DetailTaskPage extends StatefulWidget {
  final Task task;
  const DetailTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Kegiatan',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          Text('Judul : ${widget.task.attributes.title}'),
          const SizedBox(height: 16),
          Text('Deskripsi : ${widget.task.attributes.description}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 40),
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditTaskPage(task: widget.task);
                  }));
                },
                child: const Text(
                  'Ubah',
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 40),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text(
                              'Apakah anda yakin akan menghapus kegiatan ini?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            TextButton(
                                onPressed: () async {
                                  await TaskRemoteDatasource()
                                      .deleteTask(widget.task.id);
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const HomePage();
                                  }));
                                },
                                child: const Text('Yes')),
                          ],
                        );
                      });
                },
                child: const Text(
                  'Hapus',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
