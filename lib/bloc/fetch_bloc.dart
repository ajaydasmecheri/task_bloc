import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last/bloc/fetch_event.dart';
import 'package:last/bloc/fetch_state.dart';
import 'package:last/model/model.dart';
import 'package:http/http.dart' as http;


class SuperheroBloc extends Bloc<SuperheroEvent, SuperheroState> {
  SuperheroBloc() : super(SuperheroInitial()) {
    on<FetchSuperheroes>((event, emit) async {
      emit(SuperheroLoading());
      try {
        final response = await http.get(Uri.parse('https://protocoderspoint.com/jsondata/superheros.json'));
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          final List<dynamic>? data = jsonResponse['superheros'] as List<dynamic>?;

          print(data); 
          // data gettt ok done

          if (data == null) {
            emit(SuperheroError('No superheroes found'));
            return;
          }

          final superheroes = data.map((json) => Superhero.fromJson(json)).toList();
          emit(SuperheroLoaded(superheroes));
        } else {
          emit(SuperheroError('Failed to load superheroes'));
        }
      } catch (e) {
        emit(SuperheroError(e.toString()));
      }
    });
  }
}