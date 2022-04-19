part of 'get_data_bloc.dart';

abstract class GetDataState extends Equatable {
  const GetDataState();
  
  @override
  List<Object> get props => [];
}

class GetDataInitial extends GetDataState {}

class LoadingData extends GetDataState{
  
}

class LoadedData extends GetDataState{

}

class ErrorData extends GetDataState{
 final String error;
 ErrorData(this.error);
@override
  List<Object> get props => [error];
 
  
}
