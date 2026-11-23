import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/cubits/notes_cubit/notes_cubit.dart';
import 'package:notesapp/widgets/custom_app_bar.dart';
import 'package:notesapp/widgets/notes_list_view.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({super.key});

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {
  bool isSearching = false;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 50),

          if (isSearching)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    onChanged: (value) {
                      BlocProvider.of<NotesCubit>(context).searchNotes(value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search notes...',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {
                    searchController.clear();

                    BlocProvider.of<NotesCubit>(context).searchNotes('');

                    setState(() {
                      isSearching = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            )
          else
            CustomAppBar(
              title: 'Notes',
              icon: Icons.search,
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),

          Expanded(child: NotesListView()),
        ],
      ),
    );
  }
}
