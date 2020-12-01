part of 'newdocument_bloc.dart';

abstract class NewdocumentEvent extends Equatable {
  const NewdocumentEvent();
}

class NewDocumentButtonPressed extends NewdocumentEvent {
  final String title,
      description,
      hastag,
      fileName,
      date,
      time,
      originalLanguage,
      transoonedLanguage;

  const NewDocumentButtonPressed(
      {@required this.title,
      @required this.description,
      @required this.hastag,
      @required this.fileName,
      @required this.date,
      @required this.time,
      @required this.originalLanguage,
      @required this.transoonedLanguage});

  @override
  List<Object> get props => [
        title,
        description,
        hastag,
        fileName,
        date,
        time,
        originalLanguage,
        transoonedLanguage
      ];

  @override
  String toString() =>
      'NewDocumentButtonPressed {title: $title, description: $description, hastag: $hastag, fileName: $fileName, date: $date, time: $time, originalLanguage: $originalLanguage, transoonedLanguage: $transoonedLanguage}';
}
