import 'package:bloc/bloc.dart';
import 'package:controller_vet/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // When User Presses the SignUp Button, we will send the SignUpRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
            email: event.email, password: event.password,evdeBakim:event.evdeBakim,petAdres: event.petAdres,petIl: event.petIl,petIlce: event.petIlce,petTaksi: event.petTaksi,vetDescription: event.vetDescription, vetName:event.vetName,vetPhone: event.vetPhone,vetWhatsapp: event.vetWhatsapp,yediYirmiDort: event.yediYirmiDort ,file: event.file);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // When User Presses the Google Login Button, we will send the GoogleSignInRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
  on<SavePicture>(((event, emit) async{
    try{
      await authRepository.savePicture(event.file);
      emit(Saved());
    }catch(e){
        emit(SaveError());
    }
  }));
    

    on<FacebookSignInRequested>(((event, emit) async{
      try{
        await authRepository.signInWithFacebook();
        emit(Authenticated());
      }catch(e){
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    }
    ));
    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }


  
}
