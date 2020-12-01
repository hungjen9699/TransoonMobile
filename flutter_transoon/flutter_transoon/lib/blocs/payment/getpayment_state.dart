part of 'getpayment_bloc.dart';

abstract class GetPaymentState extends Equatable {
  const GetPaymentState();
  @override
  List<Object> get props => [];
}

class GetPaymentLoading extends GetPaymentState {}

class GetPaymentSuccess extends GetPaymentState {
  final List<PaymentDTO> listDTO;
  const GetPaymentSuccess(this.listDTO);
  @override
  List<Object> get props => [listDTO];
}

class GetPaymentError extends GetPaymentState {}
