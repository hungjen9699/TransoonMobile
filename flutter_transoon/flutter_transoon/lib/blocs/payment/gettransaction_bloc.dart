import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';

part 'gettransaction_event.dart';
part 'gettransaction_state.dart';

class GetTransactionBloc
    extends Bloc<GetTransactionEvent, GetTransactionState> {
  GetTransactionBloc();
  @override
  GetTransactionState get initialState => GetTransactionLoading();

  @override
  Stream<GetTransactionState> mapEventToState(
      GetTransactionEvent event) async* {
    if (event is GetTransaction) {
      yield* _mapAppStartedToState();
    }
  }

  Stream<GetTransactionState> _mapAppStartedToState() async* {
    DocumentRepository _documentRepository = new DocumentRepository();
    List<TransactionDTO> listDTO =
        await _documentRepository.fetchTransactionData();
    if (listDTO != null) {
      yield GetTransactionSuccess(listDTO);
    } else {
      yield GetTransactionError();
    }
  }
}
