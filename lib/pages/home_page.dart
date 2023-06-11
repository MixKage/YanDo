import 'package:flutter/material.dart';
import 'package:yando/navigation/nav_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

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

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar.large(
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Мои дела'),
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('Info'),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    NavigationService.instance.pushNamed(NavigationPaths.task);
                  },
                  icon: const Icon(Icons.visibility),
                )
              ],
              title: Text(
                'Мои дела',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              leading: const Text('Выполненно - 5'),
            ),

            // Just some content big enough to have something to scroll.
            SliverToBoxAdapter(
              child: ListView(
                shrinkWrap: true,
                controller: _scrollController,
                children: const [
                  Text('GGG'),
                ],
              ),
            ),
          ],
        ),
      );
}
