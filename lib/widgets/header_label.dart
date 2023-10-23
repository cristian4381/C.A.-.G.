import 'package:flutter/material.dart';

class HeaderLabel extends StatelessWidget {
  
  final String subtitulo;
  final String titulo;

  const HeaderLabel({super.key, required this.titulo,  this.subtitulo=''});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Center(
        
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Text(
              titulo,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            
            if(subtitulo.isNotEmpty)
              const SizedBox(height: 10,),
              Text(
                subtitulo,
                style: const TextStyle(
                  color: Colors.black54, 
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
          ],
        ),
      ),
    );
  }
}