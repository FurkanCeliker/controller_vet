import 'package:bloc/bloc.dart';
import 'package:controller_vet/repositories/get_vet_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_data_event.dart';
part 'get_data_state.dart';

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  final GetVetRepository getVetRepository;
  GetDataBloc({required this.getVetRepository}) : super(GetDataInitial()) {
    on<GetDataEvent>((event, emit) {
      
    });

  on<FindVetRequested>((event, emit) {
      emit(LoadingData());
      try{
      getVetRepository.getVetData(vetIl: event.vetIl, vetIlce: event.vetIlce, vetPetTaksi: event.vetPetTaksi, vetYediYirmiDort:event.vetYediYirmiDort, vetEvdeBakim: event.vetEvdeBakim);
      emit(LoadedData());
      }
      catch(e){
        ErrorData(e.toString());
      }

    });

  }

  

  
}
