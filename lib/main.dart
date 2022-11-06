import 'package:bloc_hydrated_bloc/blocs/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydrated Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hydrated Bloc')),
      body: Center(
        child: BlocSelector<CounterBloc, CounterState, int>(
          selector: (state) => state.counter,
          builder: (context, counter) => Text(
            '$counter',
            style: const TextStyle(fontSize: 52),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<CounterBloc>().add(IncrementCounterEvent()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
