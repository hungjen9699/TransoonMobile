import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/document/newDocument/newdocument_bloc.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/document_tab/document_new.dart';

class DocumentNewApp extends StatelessWidget {
  final UserRepository userRepository;
  final String displayName;

  DocumentNewApp({Key key, this.userRepository, this.displayName})
      : assert(true),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NewdocumentBloc>(
        create: (context) => NewdocumentBloc(),
        child: DocumentNew(
          displayName: displayName,
          userRepository: userRepository,
        ),
      ),
    );
  }
}
