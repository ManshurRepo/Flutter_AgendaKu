
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_task/add_task_bloc.dart';
import '../bloc/get_task/get_task_bloc.dart';

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
          BlocConsumer<AddTaskBloc, AddTaskState>(listener: (context, state) {
            if (state is AddTaskSuccess) {
              context.read<GetTaskBloc>().add(DoGetAllTaskEvent());
              Navigator.pop(context);
            }
            if (state is AddTaskFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            },
            builder: (context, state) {
              if (state is AddTaskLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  context.read<AddTaskBloc>().add(DoAddTaskEvent(
                        titlecontroller.text,
                        descriptioncontroller.text,
                      ));

                  // final model = AddTaskRequestModel(
                  //   data: Data(
                  //       title: titlecontroller.text,
                  //       description: descriptioncontroller.text),
                  // );
                  // final response =
                  //     await TaskRemoteDatasource().addTask(model);
                  // Navigator.pop(context);
                },
                child: const Text('Tambahkan'),
              );
          },
          ),
        ],
      ),
    );
  }
}

