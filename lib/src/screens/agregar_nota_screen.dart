import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class AgregarNotaScreen extends StatefulWidget {
  NotasModel? nota;
  AgregarNotaScreen({Key? key, this.nota}) : super(key: key);

  @override
  _AgregarNotaScreenState createState() => _AgregarNotaScreenState();
}

class _AgregarNotaScreenState extends State<AgregarNotaScreen> {
  late DatabaseHelper _databaseHelper;
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDetalle = TextEditingController();

  @override
  void initState() {
    if (widget.nota != null) {
      _controllerTitulo.text = widget.nota!.titulo!;
      _controllerDetalle.text = widget.nota!.detalle!;
    }

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: widget.nota == null ? Text('Agregar nota') : Text('Editar nota'),
      ),
      body: ListView(
        //column
        children: [
          _crearTextFieldTitulo(),
          SizedBox(
            height: 10,
          ),
          _crearTextFieldDetalle(),
          ElevatedButton(
              onPressed: () {
                if (widget.nota == null) {
                  NotasModel nota = NotasModel(
                      titulo: _controllerTitulo.text,
                      detalle: _controllerDetalle.text);

                  _databaseHelper.insert(nota.toMap()).then((value) {
                    if (value > 0) {
                      Navigator.pop(context);
                      // Navigator.pop(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text('La solicitud se completo')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('La solicitud no se completo')));
                    }
                  });
                } else {
                  NotasModel nota = NotasModel(
                      id: widget.nota!.id,
                      titulo: _controllerTitulo.text,
                      detalle: _controllerDetalle.text);
                  _databaseHelper.update(nota.toMap()).then((value) {
                    if (value > 0) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('La solicitud no se completo')));
                    }
                  });
                }
              },
              child: Text('Guardar nota'))
        ],
      ),
    );
  }

  Widget _crearTextFieldTitulo() {
    return TextField(
      controller: _controllerTitulo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: 'T??tulo de la nota',
          errorText: 'Este campo es obligatorio'),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldDetalle() {
    return TextField(
      controller: _controllerDetalle,
      keyboardType: TextInputType.text,
      maxLines: 8,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: 'Detalle de la nota',
          errorText: 'Este campo es obligatorio'),
      onChanged: (value) {},
    );
  }
}
