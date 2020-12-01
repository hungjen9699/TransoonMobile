import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertransoon/dtos/paymentDTO.dart';
import 'package:fluttertransoon/repositories/payment_repository.dart';
part 'getpayment_event.dart';
part 'getpayment_state.dart';

class GetPaymentBloc extends Bloc<GetPaymentEvent, GetPaymentState> {
  GetPaymentBloc();
  @override
  GetPaymentState get initialState => GetPaymentLoading();

  @override
  Stream<GetPaymentState> mapEventToState(GetPaymentEvent event) async* {
    PaymentRepository _paymentRepo = new PaymentRepository();
    if (event is GetPayment) {
      List<PaymentDTO> listDTO = await _paymentRepo.fetchPayment();
      yield* _mapAppStartedToState(listDTO);
    }
  }

  Stream<GetPaymentState> _mapAppStartedToState(
      List<PaymentDTO> listDTO) async* {
    if (listDTO != null) {
      yield GetPaymentSuccess(listDTO);
      close();
    } else {
      yield GetPaymentError();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
