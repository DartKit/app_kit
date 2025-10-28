import 'dart:async';
/*

// 使用
main() {
  Future task1() {
    return Future(() async {
      print("start task1");
      await Future.delayed(Duration(seconds: 3));
      return "end task1";
    });
  }

  Future task2() {
    return Future(() async {
      print("start task2");
      await Future.delayed(Duration(seconds: 1));
      return "end task2";
    });
  }

  TaskQueueUtils queueUtils = TaskQueueUtils();
  queueUtils.addTask(task1).then((result) {
    print(result);
    return Future.value(result);
  });
  queueUtils.addTask(task2).then((result) {
    print(result);
    return Future.value(result);
  });
}

// 打印：task1，task2 为模拟的耗时任务。
start task1
end task1
start task2
end task2
* */

typedef TaskCallback = void Function(bool success, dynamic result);
typedef TaskFutureFuc = Future Function();

///队列任务，先进先出，一个个执行
class TaskQueueUtils {
  bool _isTaskRunning = false;
  List<TaskItem> _taskList = [];

  bool get isTaskRunning => _isTaskRunning;

  Future addTask(TaskFutureFuc futureFunc, {dynamic param}) {
    Completer completer = Completer();
    TaskItem taskItem = TaskItem(
      futureFunc,
      (success, result) {
        if (success) {
          completer.complete(result);
        } else {
          completer.completeError(result);
        }
        _taskList.removeAt(0);
        _isTaskRunning = false;
        //递归任务
        _doTask();
      },
    );
    _taskList.add(taskItem);
    _doTask();
    return completer.future;
  }

  Future<void> _doTask() async {
    if (_isTaskRunning) return;
    if (_taskList.isEmpty) return;

    //获取先进入的任务
    TaskItem task = _taskList[0];
    _isTaskRunning = true;
    try {
      //执行任务
      var result = await task.futureFun();
      //完成任务
      task.callback(true, result);
    } catch (_) {
      task.callback(false, null);
    }
  }
}

///任务封装
class TaskItem {
  final TaskFutureFuc futureFun;
  final TaskCallback callback;

  const TaskItem(
    this.futureFun,
    this.callback,
  );
}
