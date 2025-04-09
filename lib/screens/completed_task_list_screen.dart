import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/widget/custom_circular_progress_indicator.dart';
import 'package:task_manager/widget/screen_background.dart';
import 'package:task_manager/widget/snackbar_message.dart';
import 'package:task_manager/widget/task_item_widget.dart';
import 'package:task_manager/widget/task_status_summary_counter_widget.dart';
import 'package:task_manager/widget/tm_app_bar.dart';

import '../data/utils/urls.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  bool _getCompletedTaskListInProgress = false;
  TaskListByStatusModel? completedTaskListModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Scaffold(
      appBar: TMAppBar(textTheme: textTheme),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Visibility(
              visible: _getCompletedTaskListInProgress == false,
              replacement: const CustomCircularProgressIndicator(),
              child: _buildTaskListView()),

        ),
      ),
    );

  }

  Widget _buildTaskListView() {
    return ListView.builder(
        itemCount: completedTaskListModel?.taskList?.length ?? 0,
        itemBuilder: (context,index){
            return TaskItemWidget(
              taskModel: completedTaskListModel!.taskList![index],
            );

          // return Card(
          //   color: Colors.white,
          //   elevation: 0,
          //   child: ListTile(
          //
          //     title: const Text('Completed Title',),
          //     subtitle: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text( 'Completed Subtitle'),
          //         const Text('2/6/25'),
          //         const SizedBox(height: 4,),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Chip(
          //
          //               label:
          //               const Text('Completed',
          //                 style: TextStyle(
          //                     color: Colors.white
          //                 ),),
          //               backgroundColor: Colors.green,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(30)
          //               ),
          //
          //             ),
          //             Row(
          //               children: [
          //                 IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
          //                 IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
          //               ],
          //             )
          //           ],
          //         )
          //
          //       ],
          //     ),
          //   ),
          // );


        });
  }

  Widget _buildTaskSummaryByStatus() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(

          children: [
            TaskStatusSummaryCounterWidget(
              title: 'New',
              count: '12',),
            TaskStatusSummaryCounterWidget(
              title: 'Progress',
              count: '12',
            ),
            TaskStatusSummaryCounterWidget(
              title: 'Completed',
              count: '12',
            ),
            TaskStatusSummaryCounterWidget(
              title: 'cancelled',
              count: '12',
            ),
          ],
        ),
      ),
    );
  }

  Future <void> _getCompletedTaskList()async{
    _getCompletedTaskListInProgress = true;
    setState(() {

    });
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('Completed'));
    if(response.isSuccess){
      completedTaskListModel = TaskListByStatusModel.fromJson(response.responseData!);

    }else{
      showSnackBarMessage(context, response.errorMessage);

    }

    _getCompletedTaskListInProgress = false;
    setState(() {

    });

  }
}



