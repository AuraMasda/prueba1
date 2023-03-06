import 'package:flutter/material.dart';

import 'widgets/estylos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]
  String teclado = 'Teclado1';

  //

  void fRetrollamadaBotonera() {
    setState(() {
      if (teclado == 'Teclado1') {
        teclado = 'Teclado2';
      } else {
        teclado = 'Teclado1';
      }
    });
  }

  //[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]
  @override
  Widget build(BuildContext context) {
    //
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MaterialApp(
          title: 'My App',
          home: Scaffold(
            appBar: AppBar(
              toolbarHeight: constraints.maxWidth * 0.05,
              title: Text('My App'),
            ),
            body: Column(
              children: [
                Display1(
                    mostrar: teclado, maxHeight: constraints.maxHeight * 0.09),
                //
                Display2(
                    mostrar: teclado, maxHeight: constraints.maxHeight * 0.07),
                //
                Expanded(
                  child: Column(
                    children: [
                      Text(teclado),
                      SelectorDeTeclados(
                        nombreDeTeclado: teclado,
                        retrollamadaBotonera: fRetrollamadaBotonera,
                        boxConstraints: constraints,
                      ),
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
        );
      },
    );
  }
}

//(((((((((((((((((((((((((((((((((Display1)))))))))))))))))))))))))))))))))
class Display1 extends StatefulWidget {
  double maxHeight;
  String mostrar;
  Display1({required this.mostrar, required this.maxHeight, super.key});

  @override
  State<Display1> createState() => _Display1State();
}

class _Display1State extends State<Display1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: SizedBox(
        height: widget.maxHeight,
        child: Text(
          'Display mostrado es: ${widget.mostrar}',
          style: TextStyle(
            fontSize: widget.maxHeight * 0.9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
//(((((((((((((((((((((((((((((((((Display2)))))))))))))))))))))))))))))))))

class Display2 extends StatefulWidget {
  double maxHeight;
  String mostrar;
  Display2({required this.mostrar, required this.maxHeight, super.key});

  @override
  State<Display2> createState() => _Display2State();
}

class _Display2State extends State<Display2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Text(
        'Display mostrado es: ${widget.mostrar}',
        style: TextStyle(
          fontSize: widget.maxHeight * 0.7,
        ),
      ),
    );
  }
}
//(((((((((((((((((((((((((((+Teclado1 ))))))))))))))))))))))))))))))

class Teclado extends StatefulWidget {
  double maxHeightConsedida;
  VoidCallback? ejecutarEstaFunction;
  VoidCallback? ejecutarEstaAccion;

  Map<int, List<CampoBoton>> mapaBotones;

  Teclado(
      {required this.maxHeightConsedida,
      required this.ejecutarEstaAccion,
      required this.ejecutarEstaFunction,
      required this.mapaBotones,
      super.key});

  @override
  State<Teclado> createState() => _TecladoState();
}

class _TecladoState extends State<Teclado> {
  List<Widget> lineaDeBotones({required List<CampoBoton> rowBotones}) {
    List<Widget> t = [];

    double maxHeightBoton = widget.maxHeightConsedida / 8.5;

    for (var e in rowBotones) {
      t.add(
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(0.8),
            child:

                //
                Container(
              height: maxHeightBoton,
              child: ElevatedButton(
                style: e.buttonStyle,
                // ?.copyWith(
                //   //sombra
                // //  shadowColor: MaterialStatePropertyAll(Colors.amber),
                //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //       RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30.0),
                //   )),
                //   elevation: MaterialStateProperty.resolveWith<double>(
                //     (Set<MaterialState> states) {
                //       if (states.contains(MaterialState.pressed)) {
                //         return 1;
                //       }
                //       return 10;
                //     },
                //   ),
                // ),
                // +retrollamada-------------------
                onPressed: e.accion == 'cambioTeclado'
                    ? widget.ejecutarEstaFunction
                    : widget.ejecutarEstaAccion,
                // -retrollamada-------------------
                child: FittedBox(
                  child: e.nombre == null && e.icono != null
                      ? e.icono!
                      : Text(
                          e.nombre!,
                          style: TextStyle(fontSize: maxHeightBoton * 0.7),
                        ),
                ),
              ),
            ),
            //
          ),
        ),
      );
    }

    return t;
  }

  @override
  Widget build(BuildContext context) {
    var listaDeBotones = botonenesTeclado1().mapaDeBotones();
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
            children: lineaDeBotones(rowBotones: listaDeBotones[10] ?? [])),
        TableRow(children: lineaDeBotones(rowBotones: listaDeBotones[0] ?? [])),
        TableRow(children: lineaDeBotones(rowBotones: listaDeBotones[1] ?? [])),
        TableRow(children: lineaDeBotones(rowBotones: listaDeBotones[2] ?? [])),
        TableRow(children: lineaDeBotones(rowBotones: listaDeBotones[3] ?? [])),
      ],
    );
  }
}

//(((((((((((((((((((((((((((+Teclado2 ))))))))))))))))))))))))))))))

class SelectorDeTeclados extends StatefulWidget {
  String nombreDeTeclado;

  void Function()? retrollamadaBotonera;

  var boxConstraints;

  SelectorDeTeclados(
      {required this.nombreDeTeclado,
      required this.retrollamadaBotonera,
      required this.boxConstraints,
      super.key});

  @override
  State<SelectorDeTeclados> createState() => _SelectorDeTecladosState();
}

class _SelectorDeTecladosState extends State<SelectorDeTeclados> {
  @override
  Widget build(BuildContext context) {
    print('fue accionado fSelectorDeTeclados');

    if (widget.nombreDeTeclado == 'Teclado1') {
      return Teclado(
        mapaBotones: botonenesTeclado1().mapaDeBotones(),
        ejecutarEstaAccion: () {},
        ejecutarEstaFunction: widget.retrollamadaBotonera,
        maxHeightConsedida: widget.boxConstraints.maxHeight * 0.8,
      );
    } else {
      print(
          'teclado2→ ${botonenesTeclado2().mapDeBotones()[1]![3].nombre ?? 'sin dato 10-5'}');
      return Teclado(
        mapaBotones: botonenesTeclado2().mapDeBotones(),
        ejecutarEstaAccion: () {},
        ejecutarEstaFunction: widget.retrollamadaBotonera,
        maxHeightConsedida: widget.boxConstraints.maxHeight * 0.8,
      );
    }
  }
}
//((((((((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))

//(((((((((((((((((((((((((((((())))))))))))))))))))))))))))))
class CampoBoton {
  String? nombre;
  String accion;
  Icon? icono;
  ButtonStyle? buttonStyle;
  //VoidCallback? retrollamada; //VoidCallback?
  CampoBoton({
    this.nombre,
    this.icono,
    this.accion = '',
    this.buttonStyle,
    //this.retrollamada,
  });
}

//(((((((((((((((((((((((((((((())))))))))))))))))))))))))))))
class botonenesTeclado2 {
  ButtonStyle eAC = Estylos().botonAC;
  // ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
  //   foregroundColor: MaterialStateProperty.all(Colors.white),
  // );
  ButtonStyle eNum = Estylos().botonNum;
  ButtonStyle eOp = Estylos().botonOP1;
  // ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
  //   foregroundColor: MaterialStateProperty.all(Colors.white),
  // );
  ButtonStyle eOp2 = Estylos().botonOP2;
  // ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
  //   foregroundColor: MaterialStateProperty.all(Colors.white),
  // );
  Map<int, List<CampoBoton>> mapDeBotones() {
    return {
      10: [
        CampoBoton(accion: 'AC', icono: null, nombre: 'AC', buttonStyle: eAC),
        CampoBoton(
            accion: 'CE',
            icono: null,
            nombre: 'CE',
            buttonStyle: Estylos().botonDC),
        CampoBoton(
          accion: 'cambioTeclado',
          icono: Icon(Icons.construction),
          nombre: null,
          buttonStyle: eOp,
          //retrollamada: this.retrollamadaBotonera(),
        ),
        CampoBoton(accion: '(', icono: null, nombre: '(', buttonStyle: eOp2),
        CampoBoton(accion: ')', icono: null, nombre: ')', buttonStyle: eOp2),
        CampoBoton(accion: '{', icono: null, nombre: '{', buttonStyle: eOp2),
        CampoBoton(accion: '}', icono: null, nombre: '}', buttonStyle: eOp2),
      ],
      0: [
        CampoBoton(
            accion: 'sin', icono: null, nombre: 'sin', buttonStyle: eOp2),
        CampoBoton(
            accion: 'cos', icono: null, nombre: 'cos', buttonStyle: eOp2),
        CampoBoton(
            accion: 'tan', icono: null, nombre: 'tan', buttonStyle: eOp2),
        CampoBoton(
            accion: 'asin', icono: null, nombre: 'asin', buttonStyle: eOp2),
        CampoBoton(
            accion: 'acos', icono: null, nombre: 'acos', buttonStyle: eOp2),
        CampoBoton(
            accion: 'atan', icono: null, nombre: 'atan', buttonStyle: eOp2),
        CampoBoton(
            accion: 'asin', icono: null, nombre: 'asin', buttonStyle: eOp2),
      ],
      1: [
        CampoBoton(
            nombre: 'x²', icono: null, accion: 'cuadrado', buttonStyle: eNum),
        CampoBoton(
            accion: 'EXP', icono: null, nombre: 'x\u207F', buttonStyle: eNum),
        CampoBoton(
            nombre: '\u207F\u221A',
            icono: null,
            accion: 'RaizDeN',
            buttonStyle: eNum),
        CampoBoton(
            nombre: '\u221A', icono: null, accion: 'Raiz2', buttonStyle: eOp),
        CampoBoton(
            nombre: '\u207F\u221A',
            icono: null,
            accion: 'ROOT',
            buttonStyle: eNum),
        CampoBoton(
            accion: 'PI', icono: null, nombre: '\u03C0', buttonStyle: eOp),
        CampoBoton(accion: 'E', icono: null, nombre: 'e', buttonStyle: eOp),
      ],
      2: [
        CampoBoton(accion: '1', icono: null, nombre: '1', buttonStyle: eNum),
        CampoBoton(accion: '2', icono: null, nombre: '2', buttonStyle: eNum),
        CampoBoton(accion: '3', icono: null, nombre: '3', buttonStyle: eNum),
        CampoBoton(accion: '+', icono: null, nombre: '+', buttonStyle: eOp),
        CampoBoton(
            accion: '\u207F\u221A',
            icono: null,
            nombre: 'ROOT',
            buttonStyle: eNum),
        CampoBoton(
            accion: 'x²', icono: null, nombre: 'cuadrado', buttonStyle: eNum),
        CampoBoton(accion: '-', icono: null, nombre: '-', buttonStyle: eOp),
      ],
      3: [
        CampoBoton(accion: '0', icono: null, nombre: '0', buttonStyle: eNum),
        CampoBoton(
            accion: '.',
            icono: null, //Icon(Icons.radio_button_on),
            nombre: '.',
            buttonStyle: eNum // null,
            ),
        CampoBoton(
            accion: '-/+',
            icono: null, //Icon(Icons.autorenew_rounded),
            nombre: '-/+', //null,
            buttonStyle: eNum),
        CampoBoton(
          accion: '=',
          icono: null, //Icon(Icons.done_all),
          nombre: '=',
          buttonStyle: eNum.copyWith(
              backgroundColor: MaterialStatePropertyAll(Colors.lime)),
        ),
        CampoBoton(
            accion: '\u207F\u221A',
            icono: null,
            nombre: 'ROOT',
            buttonStyle: eNum),
        CampoBoton(
            accion: 'x²', icono: null, nombre: 'cuadrado', buttonStyle: eNum),
        CampoBoton(accion: '-', icono: null, nombre: '-', buttonStyle: eOp),

        ///null),
      ],
    };
  }
}

//--
class botonenesTeclado1 {
  ButtonStyle eAC = Estylos().botonAC;
  //  ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
  //   foregroundColor: MaterialStateProperty.all(Colors.white),
  // );
  ButtonStyle eDC = Estylos().botonDC;
  // ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.orange.shade800),
  //   foregroundColor: MaterialStateProperty.all(Colors.white),
  // );
  ButtonStyle eNum = Estylos().botonNum;
  // ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.green),
  //   foregroundColor: MaterialStateProperty.all(Colors.black),
  // );
  ButtonStyle eOp = Estylos().botonOP1;
  // ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
  //   foregroundColor: MaterialStateProperty.all(Colors.white),
  // );
  ButtonStyle eOp2 = Estylos().botonOP2;
  // ButtonStyle(
  //   backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
  //   foregroundColor: MaterialStateProperty.all(Colors.white),
  // );
  Map<int, List<CampoBoton>> mapaDeBotones() {
    return {
      10: [
        CampoBoton(accion: 'AC', icono: null, nombre: 'AC', buttonStyle: eAC),
        CampoBoton(accion: 'CE', icono: null, nombre: 'CE', buttonStyle: eDC),
        CampoBoton(
          accion: 'cambioTeclado',
          icono: Icon(Icons.construction),
          nombre: null,
          buttonStyle: eOp,
          //retrollamada: this.retrollamadaBotonera(),
        ),
        CampoBoton(accion: '/', icono: null, nombre: '/', buttonStyle: eOp),
      ],
      0: [
        CampoBoton(accion: '7', icono: null, nombre: '7', buttonStyle: eNum),
        CampoBoton(accion: '8', icono: null, nombre: '8', buttonStyle: eNum),
        CampoBoton(accion: '9', icono: null, nombre: '9', buttonStyle: eNum),
        CampoBoton(accion: '*', icono: null, nombre: '*', buttonStyle: eOp),
      ],
      1: [
        CampoBoton(accion: '4', icono: null, nombre: '4', buttonStyle: eNum),
        CampoBoton(accion: '5', icono: null, nombre: '5', buttonStyle: eNum),
        CampoBoton(accion: '6', icono: null, nombre: '6', buttonStyle: eNum),
        CampoBoton(accion: '-', icono: null, nombre: '-', buttonStyle: eOp),
      ],
      2: [
        CampoBoton(accion: '1', icono: null, nombre: '1', buttonStyle: eNum),
        CampoBoton(accion: '2', icono: null, nombre: '2', buttonStyle: eNum),
        CampoBoton(accion: '3', icono: null, nombre: '3', buttonStyle: eNum),
        CampoBoton(accion: '+', icono: null, nombre: '+', buttonStyle: eOp),
      ],
      3: [
        CampoBoton(accion: '0', icono: null, nombre: '0', buttonStyle: eNum),
        CampoBoton(
            accion: '.',
            icono: null, //Icon(Icons.radio_button_on),
            nombre: '.',
            buttonStyle: eNum // null,
            ),

        CampoBoton(
            accion: '-/+',
            icono: null, //Icon(Icons.autorenew_rounded),
            nombre: '-/+', //null,
            buttonStyle: eNum),

        CampoBoton(
            accion: '=',
            icono: null, //Icon(Icons.done_all),
            nombre: '=',
            buttonStyle: eNum.copyWith(
                backgroundColor: MaterialStatePropertyAll(Colors.lime))),

        ///null),
      ],
    };
  }
}
