import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuraciones'
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
           child: SizedBox(
              height: MediaQuery.of(context).size.height *0.9,
              child: Column(
                children: [
                  GestureDetector(
                    child: const Card(
                      child: ListTile(
                        leading: Icon(Icons.lock_reset),
                        title: Text('Cambiar contraseña'),
                        trailing: Icon(Icons.arrow_forward),
                      ),
                    ),
                    onTap: () => Navigator.pushNamed(context, 'changePassword'),
                  ),
                  const SizedBox(height: 12), 
                ],
              ),
            ),
        )
      ),
    );
  }
}