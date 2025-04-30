import 'package:flutter/material.dart';
import 'package:location/location.dart';

typedef TryAgain = void Function();

mixin LocationMixin<E extends StatefulWidget> on State<E> {

  void showDialogLocationServiceUnavailable() {
    showDialog(
      context: context, 
      builder: (contextDialog){
        return AlertDialog(
          title: Text('Precisamos da sua localização'),
          content: Text(
            'Para realizar a busca da sua localização, precisamos que você ative o GPS do dispositivo.',
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(contextDialog);
              }, 
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(contextDialog);
                Location().requestService();
              }, 
              child: Text('Abrir Configurações'),
            ),
          ],
        );
      }
    );
  }

  void showDialogLocationDenied(TryAgain? tryAgain) {
    showDialog(
      context: context, 
      builder: (contextDialog){
        return AlertDialog(
          title: Text('Precisamos da sua authorização'),
          content: Text(
            'Para realizar a busca da sua localização, precisamos que você autorize a utilização.',
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(contextDialog);
              }, 
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(contextDialog);
                if(tryAgain != null) {
                  tryAgain();
                }
              }, 
              child: Text('Tentar Novamente'),
            ),
          ],
        );
      }
    );
  }
  void showDialogLocationDeniedForever(){
        showDialog(
      context: context, 
      builder: (contextDialog){
        return AlertDialog(
          title: Text('Precisamos da sua authorização'),
          content: Text(
            'Para realizar a busca da sua localização, precisamos que você autorize a utilização, Clique no botão configurações e autorize a utilização e clique novamente no botão "Localização Atual".',
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(contextDialog);
              }, 
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(contextDialog);
                Location().requestService();
              }, 
              child: Text('Abrir Configurações'),
            ),
          ],
        );
      }
    );
  }

}