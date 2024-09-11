import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/bloc/fetch_bloc.dart';
import 'package:last/bloc/fetch_event.dart';
import 'package:last/bloc/fetch_state.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => SuperheroBloc()..add(FetchSuperheroes()),
        child: const SuperheroList(),
      ),
    );
  }
}

class SuperheroList extends StatelessWidget {
  const SuperheroList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Superheroes'),
      ),
      body: BlocBuilder<SuperheroBloc, SuperheroState>(
        builder: (context, state) {
          if (state is SuperheroLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuperheroLoaded) {
            final superheroes = state.superheroes;
            return ListView.builder(
              itemCount: superheroes.length,
              itemBuilder: (context, index) {
                final superhero = superheroes[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.network(superhero.url)),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(superhero.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(superhero.power),
                    ),

                  ],
                  
                );
              },
            );
          } else if (state is SuperheroError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
