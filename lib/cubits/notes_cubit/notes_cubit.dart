import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:notesapp/constants.dart';
import 'package:notesapp/models/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<NoteModel> allNotes = [];
  List<NoteModel> notes = [];

  fetchAllNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);

    allNotes = notesBox.values.toList();
    notes = allNotes;

    emit(NotesSuccess());
  }

  void searchNotes(String query) {
    if (query.isEmpty) {
      notes = allNotes;
    } else {
      notes = allNotes.where((note) {
        final title = note.title.toLowerCase();
        final subtitle = note.subTitle.toLowerCase();
        final searchQuery = query.toLowerCase();

        return title.contains(searchQuery) || subtitle.contains(searchQuery);
      }).toList();
    }

    emit(NotesSuccess());
  }
}
