import 'package:flutter/material.dart';
import 'package:flutter_todo/controllers/taskController.dart';
import 'package:flutter_todo/controllers/task_bar_controller.dart';
import 'package:flutter_todo/ui/theme.dart';
import 'package:flutter_todo/ui/widgets/button.dart';
import 'package:flutter_todo/ui/widgets/input_field.dart';
import 'package:flutter_todo/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = Get.put(TaskController());
  final TaskBarController _taskBarController = Get.put(TaskBarController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyInputField(
                  title: "Title",
                  hint: 'Enter your title',
                  controller: _titleController,
                ),
                MyInputField(
                  title: "Note",
                  hint: 'Enter your Note',
                  controller: _noteController,
                ),
                MyInputField(
                  onTap: () async {
                    await _getDateFromUser();

                    if (_calculateDifference(
                            _taskBarController.selectedDate.value) <
                        0) {
                      Utils.getSnackBar("can not use previous date",
                          "previous date isnot a valid starting date");

                      _taskBarController.selectedDate.value = DateTime.now();
                    }
                  },
                  title: "Date",
                  hint: DateFormat.yMd()
                      .format(_taskBarController.selectedDate.value),
                  widget: IconButton(
                    onPressed: () async {
                      await _getDateFromUser();

                      if (_calculateDifference(
                              _taskBarController.selectedDate.value) <
                          0) {
                        Utils.getSnackBar("can not use previous date",
                            "previous date isnot a valid starting date");

                        _taskBarController.selectedDate.value = DateTime.now();
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: "start time",
                        hint: _taskBarController.startTime.value,
                        onTap: () async {
                          await _getTimeFromUser(true);
                          if (_calculateDifferenceTime(
                                  _taskBarController.startTime.value) <
                              0) {
                            Utils.getSnackBar("cann't start task from past ",
                                "please start your task from present time not past");
                            _taskBarController.startTime.value =
                                DateFormat("hh:mm a").format(DateTime.now());
                          }
                        },
                        widget: IconButton(
                          onPressed: () async {
                            await _getTimeFromUser(true);
                            if (_calculateDifferenceTime(
                                    _taskBarController.startTime.value) <
                                0) {
                              Utils.getSnackBar("cann't start task from past ",
                                  "please start your task from present time not past");
                              _taskBarController.startTime.value =
                                  DateFormat("hh:mm a").format(DateTime.now());
                            }

                            debugPrint(
                                "start time ${_taskBarController.startTime.value} :: formated time");
                          },
                          icon: const Icon(Icons.access_time_filled_rounded),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: MyInputField(
                        title: "End time",
                        hint: _taskBarController.endTime.value,
                        onTap: () {
                          _getTimeFromUser(false);
                        },
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(false);
                          },
                          icon: const Icon(Icons.access_time_filled_rounded),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                MyInputField(
                  title: "Remind",
                  hint:
                      "${_taskBarController.selectedRemind.value} minutes early",
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 5,
                    style: subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      _taskBarController.selectedRemind.value =
                          int.parse(newValue!);
                    },
                    items: _taskBarController.remindList
                        .map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        //remind list
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
                MyInputField(
                  title: "Repeat",
                  hint: _taskBarController.selectedRepeat.value,
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 5,
                    style: subTitleStyle,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      _taskBarController.selectedRepeat.value = newValue!;
                    },
                    items: _taskBarController.repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallate(),
                    MyButton(
                        label: "Create Task",
                        onTap: () {
                          _validateData();
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addTaskToDb() async {
    int val = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text.toString(),
        date: DateFormat.yMd().format(_taskBarController.selectedDate.value),
        startTime: _taskBarController.startTime.value,
        endTime: _taskBarController.endTime.value,
        remind: _taskBarController.selectedRemind.value,
        repeat: _taskBarController.selectedRepeat.value,
        color: _taskBarController.selectedColor.value,
        isCompleted: 0,
      ),
    );
    print(val);
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "all fields are required",
        snackPosition: SnackPosition.BOTTOM,
        colorText: pinkClr,
        backgroundColor: Colors.white,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.colorScheme.background,
      elevation: 0,
      title: const Text('Add Task'),
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/profile.jpg'),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _colorPallate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                _taskBarController.selectedColor.value = index;
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: _taskBarController.selectedColor.value == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );

    if (pickerDate != null) {
      _taskBarController.selectedDate.value = pickerDate;
    } else {
      _taskBarController.selectedDate.value = DateTime.now();
    }
  }

  _getTimeFromUser(bool isStartTime) async {
    var pickedTime = isStartTime
        ? await _showTimePicker(_taskBarController.startTime.value)
        : await _showTimePicker(_taskBarController.endTime.value);
    String formatedTime = await pickedTime.format(context);
    if (pickedTime == null) {
      debugPrint("time cancel");
    } else if (isStartTime == true) {
      _taskBarController.startTime.value = formatedTime;
    } else if (isStartTime == false) {
      _taskBarController.endTime.value = formatedTime;
    }
  }

  _showTimePicker(String time) async {
    return await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1].split(" ")[0]),
      ),
    );
  }

  int _calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  int _calculateDifferenceTime(String date) {
    String now = DateFormat("hh:mm a").format(DateTime.now());
    return DateFormat("hh:mm a")
        .parse(date)
        .difference(DateFormat("hh:mm a").parse(now))
        .inMinutes;
  }
}
