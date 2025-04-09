import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/widget/custom_circular_progress_indicator.dart';
import 'package:task_manager/widget/snackbar_message.dart';

class TaskItemWidget extends StatefulWidget {
  const TaskItemWidget({
    super.key,
    required this.taskModel,

  });
  final TaskModel taskModel ;


  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  bool _deleteTaskInProgress = false;
  bool _isDeleted = false; //  Flag to hide widget after delete

  @override
  Widget build(BuildContext context) {
    if (_isDeleted) return const SizedBox.shrink(); //  Don't render if deleted
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(

        title: Text(widget.taskModel.title ?? '',),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text(widget.taskModel.createdDate ?? ''),
            const SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(

                  label:
                  Text(widget.taskModel.status ?? 'New',
                    style: const TextStyle(
                      color: Colors.white
                  ),),
                  backgroundColor: _getStatusColor(widget.taskModel.status ?? 'New'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),

                ),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      _showEditStatusDialog();

                    }, icon: Icon(Icons.edit)),
                    Visibility(
                      visible: _deleteTaskInProgress == false,
                      replacement: CustomCircularProgressIndicator(),
                      child: IconButton(onPressed: (){
                        _deleteTask();



                      }, icon: Icon(Icons.delete)),
                    ),
                  ],
                )
              ],
            )

          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status){
    if(status=='New'){
      return Colors.blue;
    }else if(status == 'Progress'){
      return Colors.yellow;
    }else if(status == 'Cancelled'){
      return Colors.red;
    }else{
      return Colors.green;
    }

  }

Future <void> _deleteTask () async {
    _deleteTaskInProgress = true;
    setState(() {

    });
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.deleteTask(widget.taskModel!.sId!));
    _deleteTaskInProgress = false;
    if (response.isSuccess) {
      _isDeleted = true;//  Hide the widget
      showSnackBarMessage(context, 'Task is deleted');
    }else{
      showSnackBarMessage(context, response.errorMessage);

    }

    setState(() {

    });

}

  void _showEditStatusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24), // Leave space for the close icon
                    const Text(
                      'Update Task Status',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _statusOption('Progress'),
                    const SizedBox(height: 8),
                    _statusOption('Completed'),
                    const SizedBox(height: 8),
                    _statusOption('Cancelled'),
                  ],
                ),
              ),


              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusOption(String status) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        // minimumSize: Size.zero, // Override default 88x36 size
        backgroundColor: _getStatusColor(status),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () async {
        Navigator.pop(context); // Close dialog

        // // Optional: Make API call to update status here
        // // Example (replace this with your actual API logic):
        // // await NetworkCaller.postRequest(
        // //   url: Urls.updateTaskStatus(widget.taskModel.sId!, status),
        // // );
        //
        // setState(() {
        //   widget.taskModel.status = status;
        // });
      },
      child: Text(status, style: const TextStyle(color: Colors.white)),
    );
  }
}
