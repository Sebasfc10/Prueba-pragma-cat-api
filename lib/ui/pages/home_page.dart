import 'dart:async';

import 'package:cat_api_prueba_pragma_jeant/config/bloc/bloc/cat_bloc.dart';
import 'package:cat_api_prueba_pragma_jeant/domain/models/cat_model.dart';
import 'package:cat_api_prueba_pragma_jeant/infraestructure/resource/cat_api_repositoy.dart';
import 'package:cat_api_prueba_pragma_jeant/ui/widgets/card_preview_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CatBloc(CatApiRepository()))
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'Catbreeds',
                style: GoogleFonts.alike(
                  color: Colors.black,
                  textStyle: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            )),
        body: blocBodycat(),
      ),
    );
  }

  Widget blocBodycat() {
    return BlocProvider(
      create: (context) => CatBloc(CatApiRepository())..add(LoadCatEvent()),
      child: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          if (state is CatLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CatErrorState) {
            print(state.error);
            return Center(child: Text("Error de estado: ${state.error}"));
          }

          if (state is CatLoadedState) {
            List<CatModel> catList = state.cats;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      prefixIcon: Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    ),
                    style: TextStyle(fontSize: 14),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        BlocProvider.of<CatBloc>(context).add(LoadCatEvent());
                      } else {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          BlocProvider.of<CatBloc>(context)
                              .add(SearchCatEvent(value));
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<CatBloc, CatState>(
                    builder: (context, state) {
                      if (state is CatLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CatErrorState) {
                        return Center(
                          child: Text('Error: ${state.error}'),
                        );
                      } else if (state is CatLoadedState) {
                        if (state.cats.isEmpty) {
                          return Center(
                            child: Text('Not Found Cats!!!!'),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: state.cats.length,
                            itemBuilder: (context, index) {
                              final cat = state.cats[index];
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1.0)),
                                  child: CardPreviewresponse(
                                      adaptabilidad:
                                          cat.adaptability.toString(),
                                      descripcion: cat.description!,
                                      labelName: cat.name!,
                                      labelCountry: cat.origin!,
                                      inteligent: cat.intelligence.toString(),
                                      img: cat.imageUrl!),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
