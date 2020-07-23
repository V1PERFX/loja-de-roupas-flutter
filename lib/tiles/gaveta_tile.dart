import 'package:flutter/material.dart';

class GavetaTile extends StatelessWidget {

  final IconData icone;
  final String texto;
  final PageController controlador;
  final int pagina;

  GavetaTile(this.icone, this.texto, this.controlador, this.pagina);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          controlador.jumpToPage(pagina);
        },
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              Icon(
                icone,
                size: 32,
                color: controlador.page.round() == pagina ?
                  Colors.amber[900] : Colors.grey[700],
              ),
              SizedBox(width: 32,),
              Text(
                texto,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: controlador.page.round() == pagina ?
                    Colors.blue[800] : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}