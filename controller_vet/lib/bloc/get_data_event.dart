part of 'get_data_bloc.dart';

abstract class GetDataEvent extends Equatable {
  const GetDataEvent();

  @override
  List<Object> get props => [];
}

class FindVetRequested extends GetDataEvent{
  final String vetIl;
  final String vetIlce;
  final bool vetPetTaksi;
  final bool vetEvdeBakim;
  final bool vetYediYirmiDort;
  FindVetRequested(this.vetIl,this.vetIlce,this.vetPetTaksi,this.vetEvdeBakim,this.vetYediYirmiDort);

}
