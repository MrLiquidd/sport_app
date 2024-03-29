import 'package:bloc/bloc.dart';
import 'package:travel_app/domain/blocs/detail_bloc/app_cubit_states.dart';
import 'package:travel_app/domain/model/data_model.dart';
import 'package:travel_app/domain/services/data_service/data_services.dart';

class AppCubits extends Cubit<CubitStates>{
  AppCubits({required this.data}): super(InitialState()){
    emit(WelcomeState());
  }
  
  final DataServices data;
  late final places;

  void getData() async {
    try{
      emit(LoadingState());
      places = await data.getInfo();
      emit(LoadedState(places));
    }catch(e){
      print(e);
    }
  }

  detailPage(DataModel data){
    emit(DetailState(data));
  }

  goHome(){
    emit(LoadedState(places));
  }
}

