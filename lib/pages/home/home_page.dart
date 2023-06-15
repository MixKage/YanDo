import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yando/database/locale_data.dart';
import 'package:yando/model/count_close_tasks.dart';
import 'package:yando/model/task.dart';
import 'package:yando/navigation/nav_service.dart';
import 'package:yando/pages/home/widgets/create_task_tile.dart';
import 'package:yando/pages/home/widgets/home_sliver_bar.dart';
import 'package:yando/pages/home/widgets/list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  bool visible = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void createTask({
    required String type,
    required bool isChecked,
    required String text,
  }) {
    final newTask = TaskModel(
      type: type,
      isChecked: isChecked,
      text: text,
      dateTime: null,
    );
    LocaleData.instance.addTask(newTask);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //createTask(type: 'Нет', isChecked: false, text: '');
            await NavigationService.instance.pushNamed(NavigationPaths.task);
          },
          child: const Icon(Icons.add),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: HomeAppBarDelegate(
                // TODO: CHANGE IT
                changeVisibility: () {},
                doneTasksCount:
                    Provider.of<CountCloseTasks>(context).countCloseTask,
                visibility: false,
              ),
              floating: true,
              pinned: true,
            ),
            ValueListenableBuilder(
              valueListenable: Hive.box('yando_tasks').listenable(),
              builder: (context, box, child) => SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: box.length + 1,
                      itemBuilder: (context, index) => (index != box.length)
                          ? MyListTile(index: index)
                          : const CreateTaskTile(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
