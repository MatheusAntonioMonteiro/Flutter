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
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nome = "";
  String cpf = "";
  double salarioMensal = 0.0;
  double decimoTerceiro = 0.0;
  double impostoSM = 0.0;
  double impostoDT = 0.0;
  double salarioAnual = 0.0;
  double impostoAnual = 0.0;
  double impostoRetido = 0.0;
  double impostoTotal = 0.0;
  String verificaRest = "";
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(title: new Text("Prova Ely")),
            body: SingleChildScrollView(
                child: Container(
              margin: new EdgeInsets.all(15.0),
              child: Form(
                  key: formKey,
                  child: MeuFormularioUI(this)),
            ))));
  }
}

calculaSA(var _salario, var _decimoTerceiro) {
  var salarioAnual = 0.0;

  salarioAnual = (_salario + _decimoTerceiro) * 12;

  return salarioAnual;
}

calculaIA(var _salarioAnual) {
  var impostoAnual = 0.0;

  if (_salarioAnual <= 22847.76) {
    impostoAnual = 0.0;
  } else if(_salarioAnual > 22847.76 && _salarioAnual <= 33919.80) {
     impostoAnual = _salarioAnual * 0.075;
  } else if(_salarioAnual > 33919.80 && _salarioAnual <= 45012.60) {
    impostoAnual = _salarioAnual * 0.15;
  } else if(_salarioAnual > 45012.60 && _salarioAnual <= 55976.16) {
    impostoAnual = _salarioAnual * 0.225;
  } else if(_salarioAnual > 55976.16) {
    impostoAnual = _salarioAnual * 0.275;
  }
  else {
    return "Valores inválidos";
  }

  return impostoAnual;
}

calculaImposto(var _impostoAnual, var _impostoRetido) {
  var _total;

  _total = _impostoAnual - _impostoRetido;

  return _total;
}

verificaRest(var _impostoTotal) {
  if(_impostoTotal > 0.0) {
    return "Deve realizar o pagamento do imposto de renda de R\$ ${_impostoTotal.toStringAsFixed(2)}";
  } else {
    return "É necessário realizar a restituição do imposto de renda de R\$ ${_impostoTotal.toStringAsFixed(2)}";
  }
}

Widget MeuFormularioUI(var meuFormulario) {


  return Column(children: [
    Image.asset('images/leao2.jpg'),
    Text("Cálculo do imposto de renda!!"),
    TextFormField(
        decoration: InputDecoration(labelText: "Nome:"),
        maxLength: 50,
        onSaved: (String val) {
          meuFormulario.setState(() {
            meuFormulario.nome = val;
          });
        }),
    TextFormField(
        decoration: InputDecoration(labelText: "CPF:"),
        maxLength: 11,
        onSaved: (String val) {
          meuFormulario.setState(() {
            meuFormulario.cpf = val;
          });
        }),
    TextFormField(
        decoration: InputDecoration(labelText: "Salario Mensal R\$"),
        maxLength: 7,
        keyboardType: TextInputType.number,
        onSaved: (String val) {
          meuFormulario.setState(() {
            meuFormulario.salarioMensal = double.parse(val);
          });

        }),
        TextFormField(
        decoration: InputDecoration(labelText: "Décimo terceiro R\$"),
        maxLength: 7,
        keyboardType: TextInputType.number,
        onSaved: (String val) {
          meuFormulario.setState(() {
            meuFormulario.decimoTerceiro = double.parse(val);
          });

        }),
        TextFormField(
        decoration: InputDecoration(labelText: "Imposto sobre o Salario Mensal R\$"),
        maxLength: 7,
        keyboardType: TextInputType.number,
        onSaved: (String val) {
          meuFormulario.setState(() {
            meuFormulario.impostoSM = double.parse(val);
          });

        }),
        TextFormField(
        decoration: InputDecoration(labelText: "Imposto sobre o décimo terceiro R\$"),
        maxLength: 7,
        keyboardType: TextInputType.number,
        onSaved: (String val) {
          meuFormulario.setState(() {
            meuFormulario.impostoDT = double.parse(val);
          });

        }),
    RaisedButton(
        child: Text("Calcular Imposto"),
        onPressed: () {
          meuFormulario.formKey.currentState.save();

          meuFormulario.setState(() {
            meuFormulario.salarioAnual = calculaSA(meuFormulario.salarioMensal, meuFormulario.decimoTerceiro);
            meuFormulario.impostoAnual = calculaIA(meuFormulario.salarioAnual);
            meuFormulario.impostoRetido = meuFormulario.impostoSM * 12 + meuFormulario.impostoDT;
            meuFormulario.impostoTotal = calculaImposto(meuFormulario.impostoAnual, meuFormulario.impostoRetido);
            meuFormulario.verificaRest = verificaRest(meuFormulario.impostoTotal);
          });
          
          
           

         /* meuFormulario.scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                  "Valor gasto com Etanol: R\$ ${meuFormulario.gastoEtanol.toStringAsFixed(2)} e Valor gasto com Gasolina R\$ ${meuFormulario.gastoGasolina.toStringAsFixed(2)}")));*/
        }),
    
        Text("Valor imposto anual: R\$ ${meuFormulario.impostoAnual.toStringAsFixed(2)}"),
        Text("Valor imposto retido: R\$ ${meuFormulario.impostoRetido.toStringAsFixed(2)}"),
        Text(meuFormulario.verificaRest),
        //Text("Valor gasto com Gasolina R\$ ${meuFormulario.gastoGasolina.toStringAsFixed(2)}")
  ]);
}

