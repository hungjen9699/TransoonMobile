import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/transactionQueueDTO.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
part 'gettransactionqueue_event.dart';
part 'gettransactionqueue_state.dart';

class GetTransactionQueueBloc
    extends Bloc<GetTransactionQueueEvent, GetTransactionQueueState> {
  final int id;
  GetTransactionQueueBloc(this.id);
  @override
  GetTransactionQueueState get initialState => GetTransactionQueueLoading();

  @override
  Stream<GetTransactionQueueState> mapEventToState(
      GetTransactionQueueEvent event) async* {
    DocumentRepository _documentRepository = new DocumentRepository();
    if (event is GetTransactionQueue) {
      List<TransactionQueueDTO> listDTO =
          await _documentRepository.fetchTransactionQueueData(id);

      yield* _mapAppStartedToState(listDTO);
    }
  }

  Stream<GetTransactionQueueState> _mapAppStartedToState(
      List<TransactionQueueDTO> listDTO) async* {
    if (listDTO != null) {
      yield GetTransactionQueueSuccess(listDTO);
      close();
    } else {
      yield GetTransactionQueueError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
