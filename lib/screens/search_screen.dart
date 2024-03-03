import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giphy_demo_app/bloc/search_bloc/search_bloc.dart';

class SearchScreenWidget extends StatefulWidget {
  final String category;
  const SearchScreenWidget({
    super.key,
    required this.category,
  });

  @override
  State<SearchScreenWidget> createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  @override
  void initState() {
    context.read<SearchBloc>().add(const SearchQueryResetEvent());
    context.read<SearchBloc>().add(SearchQueryEvent(query: widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          onChanged: (String value) {
            context.read<SearchBloc>().add(SearchQueryEvent(query: value));
          },
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchBlocState>(
        builder: (context, state) {
          if (state.status == FormzSubmissionStatus.initial ||
              state.status == FormzSubmissionStatus.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == FormzSubmissionStatus.success) {
            return GridView.builder(
              itemCount: state.searchedGifs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final data = state.searchedGifs[index];
                return Container(
                  margin: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      if (data.gifUrl != null)
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: data.gifUrl!,
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
                        data.username ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state.status == FormzSubmissionStatus.failure) {
            return Center(
              child: Text(state.errorMessage),
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

class Debouncer {
  int? millisecond;
  Timer? _timer;

  void debouncer(VoidCallback? action) {
    if (_timer?.isActive ?? true) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(seconds: millisecond ?? 350), () {
      action?.call();
    });
  }
}
