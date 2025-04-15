import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_count_by_status_model.dart';
import 'package:task_manager/data/models/task_count_model.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/screens/add_new_task_screen.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/widget/custom_circular_progress_indicator.dart';
import 'package:task_manager/widget/screen_background.dart';
import 'package:task_manager/widget/snackbar_message.dart';
import 'package:task_manager/widget/task_item_widget.dart';
import 'package:task_manager/widget/task_status_summary_counter_widget.dart';
import 'package:task_manager/widget/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getTaskCountByStatusInProgress = false;
  bool _getNewTaskListInProgress = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? newTaskListModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Scaffold(
      appBar: TMAppBar(textTheme: textTheme),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskSummaryByStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Visibility(
                    visible: _getNewTaskListInProgress == false,
                    replacement: const CustomCircularProgressIndicator(),
                    child: _buildTaskListView()),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, AddNewTaskScreen.name).then((_) => _getNewTaskList()).then((_) => _getTaskCountByStatus());
          },
         child: Icon(Icons.add),

      ),
    );

  }

  Widget _buildTaskListView() {
    return ListView.builder(
                itemCount: newTaskListModel?.taskList?.length ?? 0,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context,index){
              return   TaskItemWidget(
                  taskModel:newTaskListModel!.taskList![index],

              );


            });
  }

  Widget _buildTaskSummaryByStatus() {
    return  Visibility(
      visible: _getTaskCountByStatusInProgress == false,
      replacement: CustomCircularProgressIndicator(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            //primary: false,
          //  shrinkWrap: true,
            itemCount: taskCountByStatusModel?.taskByStatusList?.length ?? 0,
              itemBuilder: (context,index){
              final TaskCountModel model = taskCountByStatusModel!.taskByStatusList![index];
          return TaskStatusSummaryCounterWidget(
              title: model.sId ?? '',
              count: model.sum.toString(),
          );

              }

          ),
        )
      ),
    );
  }

Future<void> _getTaskCountByStatus()async{
 _getTaskCountByStatusInProgress = true;
 setState(() {

 });

 final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);
 if(response.isSuccess){
  taskCountByStatusModel = TaskCountByStatusModel.fromJson(response.responseData!);

 }else{
   showSnackBarMessage(context, response.errorMessage);
 }
 _getTaskCountByStatusInProgress = false;
 setState(() {

 });
}

Future<void> _getNewTaskList()async{
 _getNewTaskListInProgress = true;
 setState(() {

 });

 final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('New'));
 if(response.isSuccess){
  newTaskListModel = TaskListByStatusModel.fromJson(response.responseData!);

 }else{
   showSnackBarMessage(context, response.errorMessage);
 }
 _getNewTaskListInProgress = false;
 setState(() {

 });
}


}



