
import 'package:asuka/asuka.dart';

class Messages {
  
  Messages._();

  static void alert(String message){
    AsukaSnackbar.alert(message).show();
  }

  static void info(String message){
    AsukaSnackbar.info(message).show();
  }

}