import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  
  final String ruta;
  final String texto;
  final String titulo;

  const Labels({super.key, required this.ruta, required this.texto, required this.titulo});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Center(
        
        child: Column(
          children: [
             Text(
              titulo,
              style: const TextStyle(
                color: Colors.black54, 
                fontSize: 15,
                fontWeight: FontWeight.w300
              ),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, ruta);
              },
              child: Text(
                texto,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}