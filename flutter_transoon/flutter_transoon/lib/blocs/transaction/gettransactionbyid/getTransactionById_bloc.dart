import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
part 'getTransactionById_event.dart';
part 'getTransactionById_state.dart';

class GetTransactionByIdBloc
    extends Bloc<GetTransactionByIdEvent, GetTransactionByIdState> {
  final int id;
  GetTransactionByIdBloc(this.id);
  @override
  GetTransactionByIdState get initialState => GetTransactionByIdLoading();

  @override
  Stream<GetTransactionByIdState> mapEventToState(
      GetTransactionByIdEvent event) async* {
    DocumentRepository _documentRepository = new DocumentRepository();
    if (event is GetTransactionById) {
      TransactionInfoToUpdate dto = await _documentRepository.viewDoc(id);

      yield* _mapAppStartedToState(dto);
    }
  }

  Stream<GetTransactionByIdState> _mapAppStartedToState(
      TransactionInfoToUpdate dto) async* {
    if (dto != null) {
      yield GetTransactionByIdSuccess(dto);
      close();
    } else {
      yield GetTransactionByIdError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
