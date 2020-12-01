import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
part 'newdocument_event.dart';
part 'newdocument_state.dart';

class NewdocumentBloc extends Bloc<NewdocumentEvent, NewdocumentState> {
  TransactionInfoCreateRequestToTransooner dto;

  @override
  NewdocumentState get initialState => NewdocumentUninitial();

  @override
  Stream<NewdocumentState> mapEventToState(NewdocumentEvent event) async* {
    if (event is NewDocumentButtonPressed) {
      yield NewdocumentInProgress();
      try {
        yield NewdocumentSuccess();
      } catch (error) {
        yield NewdocumentFailure(error: null);
      }
    }
  }
}
