import 'dart:ui';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class Opcion1Screen extends StatefulWidget {
  Opcion1Screen({Key? key}) : super(key: key);

  @override
  _Opcion1ScreenState createState() => _Opcion1ScreenState();
}

class _Opcion1ScreenState extends State<Opcion1Screen> {
  TextEditingController txtMontoCon =
      TextEditingController(); //captura el monto

  @override
  Widget build(BuildContext context) {
    TextFormField txtMonto = TextFormField(
      controller: txtMontoCon,
      decoration: InputDecoration(hintText: 'Consumo'),
      keyboardType: TextInputType.number, //tipo de teclado
    );

    Widget alerta(String resultado) {
      return AlertDialog(
        title: Text('Detalles de compra'),
        content: Text("$resultado"),
        actions: <Widget>[
          ElevatedButton(
              child: Text("Aceptar"),
              style:
                  ElevatedButton.styleFrom(primary: ColorSettings.colorButton),
              onPressed: () {
                Navigator.of(context).pop();
                txtMontoCon.clear(); //limpia el campo
              })
        ],
      );
    }

    Future<void> mostAlerta(BuildContext context, String resultado) async {
      return showDialog<void>(
        barrierDismissible: false, //solo se cierra al presionar aceptar
        context: context,
        builder: (_) => alerta(resultado),
      );
    }

    ElevatedButton btnCalcular = ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: ColorSettings.colorButton,
            padding: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
                //se redondea el boton
                borderRadius: BorderRadius.all(Radius.circular(30)))),
        onPressed: () {
          try {
            double monto = double.parse(txtMontoCon.text);
            double propina = monto * .10;
            double total = propina + double.parse(txtMontoCon.text);
            String resultado =
                'Monto: $monto \nPropina 10%: $propina \nTotal a pagar: $total';
            if (monto < 0) {
              resultado = 'El monto debe ser mayor que cero';
            }
            mostAlerta(this.context, resultado);

            // alerta(propina, total, monto);
            print(propina);
            print(total);
            print(txtMontoCon.text);
          } catch (e) {
            mostAlerta(this.context, 'Error en los datos');
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.monetization_on), Text('Calcular propina')],
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text('Propinas'),
          centerTitle: true,
          backgroundColor: ColorSettings.colorPrimary,
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.only(left: 30, right: 30),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'Ingresa el monto del consumo',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  txtMonto,
                  SizedBox(
                    height: 15,
                  ),
                  btnCalcular
                ],
              ),
            ),
          ),
        ));
  }
}
