import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'getdocument_event.dart';
part 'getdocument_state.dart';

class GetdocumentBloc extends Bloc<GetdocumentEvent, GetdocumentState> {
  @override
  Stream<GetdocumentState> mapEventToState(GetdocumentEvent event) async* {}

  @override
  GetdocumentState get initialState => throw UnimplementedError();
}
