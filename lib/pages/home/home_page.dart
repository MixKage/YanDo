import 'package:flutter/material.dart' hide ListTile;
import 'package:provider/provider.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';
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

  // TaskNotifier
  late TasksNotifier tN;

  // TaskNotifierNoListener
  late TasksNotifier tNL;

  Future<void> createNewTask() async {
    final newTask = TaskModel.defaultTask()..id = -1;

    tNL.addTask(newTask);
    await NavigationService.instance.pushNamed(
      NavigationPaths.task,
      tNL.listTasks[tNL.listTasks.length - 1],
    );
  }

  Future<void> onRefresh() async {
    await tNL.syncList();
  }

  void changeVisibility() {
    tNL.visibility = !tNL.visibility;
  }

  @override
  void didChangeDependencies() {
    tN = Provider.of<TasksNotifier>(context);
    tNL = Provider.of<TasksNotifier>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    Provider.of<TasksNotifier>(context, listen: false).getFromServer();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 184,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: HomeAppBarDelegate(
                  changeVisibility: changeVisibility,
                  doneTasksCount: tN.countCloseTask,
                  visibility: tN.visibility,
                ),
                floating: true,
                pinned: true,
              ),
              Consumer<TasksNotifier>(
                builder: (context, notifier, _) => SliverToBoxAdapter(
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
                        itemCount: notifier.listTasks.length + 1,
                        itemBuilder: (context, index) => (index !=
                                notifier.listTasks.length)
                            ? ListTile(
                                key: ValueKey(notifier.listTasks[index].done),
                                task: notifier.listTasks[index],
                              )
                            : const CreateTaskTile(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
