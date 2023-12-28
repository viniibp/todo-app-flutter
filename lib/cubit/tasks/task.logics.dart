import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/tasks/tasks.bloc.dart';
import 'package:todoapp/models/task.model.dart';
import 'package:todoapp/pages/about.screen.dart';

import 'package:todoapp/pages/home.page.dart';
import 'package:todoapp/widgets/create_task.widget.dart';
import 'package:todoapp/widgets/custom_drawer.widget.dart';

class TaskCubitLogics extends StatefulWidget {
  const TaskCubitLogics({super.key});

  @override
  State<TaskCubitLogics> createState() => _TaskCubitLogicsState();
}

class _TaskCubitLogicsState extends State<TaskCubitLogics> {
  String currentScreen = 'Home';

  void changeCurrentScreen(String screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  Widget getScren() {
    if (currentScreen == 'Home') {
      return const Home();
    } else {
      return const About();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<TasksCubit>(context);
    final currentTabIndex = provider.state.filter.index;
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      backgroundColor: const Color(0xFF111822),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111822),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: getScren(),
      drawer: CustomDrawer(
        currentScreen: currentScreen,
        changeScreen: (String index) {
          changeCurrentScreen(index);
          Navigator.of(context).pop();
        },
      ),
      bottomNavigationBar: currentScreen == 'Home'
          ? BottomNavigationBar(
              iconSize: 28,
              selectedLabelStyle:
                  const TextStyle(fontSize: 12, color: Colors.white),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 12, color: Colors.white),
              backgroundColor: Colors.transparent,
              currentIndex: currentTabIndex,
              onTap: (int index) {
                setState(() {
                  if (index == 0) {
                    provider.changeFilter(FilterTask.completed);
                  }
                  if (index == 1) {
                    provider.changeFilter(FilterTask.all);
                  }
                  if (index == 2) {
                    provider.changeFilter(FilterTask.late);
                  }
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.playlist_add_check_rounded,
                    color: currentTabIndex == 0 ? Colors.blue : Colors.white12,
                  ),
                  label: 'Completas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    color: currentTabIndex == 1 ? Colors.green : Colors.white12,
                  ),
                  label: 'Todas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.disabled_by_default_rounded,
                    color: currentTabIndex == 2 ? Colors.red : Colors.white12,
                  ),
                  label: 'Atrasadas',
                ),
              ],
            )
          : null,
      floatingActionButton: currentScreen == 'Home'
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF1a91ff),
              shape: const CircleBorder(),
              onPressed: () {
                showDialog(
                  builder: (_) => CreateTaskWidget(
                    onSubmit: (Task newTask) {
                      provider.addTask(newTask);
                      Navigator.of(context).pop();
                    },
                  ),
                  context: context,
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
