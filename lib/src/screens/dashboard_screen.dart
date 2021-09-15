import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      drawer: Drawer(
        // se coloca un menu de hambuerguesa
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("María Guadalupe García Hernández"),
              accountEmail: Text("17030689@itcelaya.edu.mx"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.flaticon.com/icons/png/512/1177/1177568.png'),
                // child: Image.network(
                //     'https://image.flaticon.com/icons/png/512/1177/1177568.png'),
              ),
              decoration: BoxDecoration(color: ColorSettings.colorPrimary),
            ),
            ListTile(
              title: Text('Propinas'),
              subtitle: Text('Descripción corta'),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/opc1');
              },
            ),
            ListTile(
              title: Text('Intenciones'),
              subtitle: Text('Intenciones implícitas'),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/intenciones');
              },
            )
          ],
        ),
      ),
    );
  }
}
