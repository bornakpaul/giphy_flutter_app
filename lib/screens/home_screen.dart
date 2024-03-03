import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_demo_app/bloc/category_bloc/category_bloc.dart';
import 'package:giphy_demo_app/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(FetchCategoryBlocEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gify App"),
      ),
      body: BlocBuilder<CategoryBloc, CategoryBlocState>(
        builder: (context, state) {
          if (state is CategoryBlocInitialState ||
              state is CategoryBlocLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryBlocLoadedState) {
            return GridView.builder(
              itemCount: state.categoryList.data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final data = state.categoryList.data[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SearchScreenWidget(category: data.name)));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        if (data.gif != null)
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: data.gif!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Text(error.toString()),
                              fit: BoxFit.fill,
                            ),
                          ),
                        Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is CategoryBlocErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
