import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MeuApp());

class MeuApp extends StatefulWidget {
  @override
  MeuFormulario createState() {
    return MeuFormulario();
  }
}

class MeuFormulario extends State<MeuApp> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: new Text("Exemplo de Formulário")),
        body: SingleChildScrollView(
          child: Container(
            margin: new EdgeInsets.all(15.0),
            child: Form(
                key: _formKey,
                child: MeuFormularioUI(_scaffoldKey, _formKey)
              ),
            ))
      )
    );
    
    
  }
}

calculaConsumo(var _dist, var _etanol, var _gasolina) {
      var _consEt;
      var _consGa;

      _consEt = _dist/9 * _etanol;

      _consGa = _dist/11 * _gasolina;

      return "O consumo com etanol é R\$ ${_consEt.toStringAsFixed(2)}. O consumo com gasolina é R\$ ${_consGa.toStringAsFixed(2)}";
}
    

Widget MeuFormularioUI(var _scaffoldKey, var _formKey) {
  var _distancia;
  var _precoEtanol;
  var _precoGasolina;

  return Column(children: [
    Text("Meu Formulário"),
    TextFormField(
      decoration: InputDecoration(labelText: "Distância a ser percorrida:"),
      keyboardType: TextInputType.number,
      maxLength: 6,
      onSaved: (String val) {
        _distancia = int.parse(val);
      },
    ),
    TextFormField(
      decoration: InputDecoration(labelText: "Preço do Etanol:"),
      keyboardType: TextInputType.number,
      maxLength: 4,
      onSaved: (String val) {
        _precoEtanol = double.parse(val);
      },
    ),
    TextFormField(
      decoration: InputDecoration(labelText: "Preço da gasolina:"),
      keyboardType: TextInputType.number,
      maxLength: 4,
      onSaved: (String val) {
        _precoGasolina = double.parse(val);
      },
    ),
    RaisedButton(
      child: Text("Calcular Consumo"),
      onPressed: () {
        _formKey.currentState.save();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("${calculaConsumo(_distancia, _precoEtanol, _precoGasolina)}")
          )
        );
      },
    )
  ]);
}