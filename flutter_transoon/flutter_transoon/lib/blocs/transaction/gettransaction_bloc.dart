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
    DocumentRepository _documentRepository = new DocumentRepository();
    if (event is GetAllTransaction) {
      List<TransactionDTO> listDTO =
          await _documentRepository.fetchTransactionData();
      List<TransactionDTO> listDTOTemp = List<TransactionDTO>();
      if (listDTO != null) {
        listDTO.forEach((element) {
          if (element.status == 'canceled' || element.status == 'completed') {
            listDTOTemp.add(element);
          }
        });
      }
      yield* _mapAppStartedToState(listDTOTemp);
    } else if (event is GetRequestTransaction) {
      List<TransactionDTO> listDTO =
          await _documentRepository.fetchRequestTransactionData();
      yield* _mapAppStartedToState(listDTO);
    } else if (event is GetTransooningTransaction) {
      List<TransactionDTO> listDTO =
          await _documentRepository.fetchTransooningTransactionData();
      List<TransactionDTO> listDTO2 =
          await _documentRepository.fetchWaitingForFeedbackTransactionData();
      listDTO.forEach((element) {
        listDTO2.add(element);
      });
      yield* _mapAppStartedToState(listDTO2);
    }
  }

  Stream<GetTransactionState> _mapAppStartedToState(
      List<TransactionDTO> listDTO) async* {
    if (listDTO != null) {
      yield GetTransactionSuccess(listDTO);
      close();
    } else {
      yield GetTransactionError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
