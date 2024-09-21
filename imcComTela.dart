import 'package:flutter/material.dart';

class IMC {
  late double _altura;
  late double _peso;
  late double resultado;

  double get altura => _altura;
  set altura(double alt) => _altura = alt;

  double get peso => _peso;
  set peso(double p) => _peso = p;

  void calcularGrau() {
    resultado = peso / (altura * altura);
  }

  double getResultado() {
    return resultado;
  }

  String analisarImc() {
    if (resultado < 18.5) {
      return "Magreza";
    } else if (resultado >= 18.5 && resultado <= 24.9) {
      return "Normal";
    } else if (resultado >= 25 && resultado <= 29.9) {
      return "Sobrepeso I";
    } else if (resultado >= 30 && resultado <= 39.9) {
      return "Obesidade II";
    } else {
      return "Obesidade Grave III";
    }
  }
}

void main() {
  runApp(IMCApp());
}

class IMCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: IMCForm(),
    );
  }
}

class IMCForm extends StatefulWidget {
  @override
  _IMCFormState createState() => _IMCFormState();
}

class _IMCFormState extends State<IMCForm> {
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();
  String _resultado = '';
  String _classificacao = '';

  void _calcularIMC() {
    final imc = IMC();
    imc.altura = double.tryParse(_alturaController.text) ?? 0.0;
    imc.peso = double.tryParse(_pesoController.text) ?? 0.0;
    imc.calcularGrau();

    setState(() {
      _resultado = imc.getResultado().toStringAsFixed(2);
      _classificacao = imc.analisarImc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _alturaController,
              decoration: InputDecoration(labelText: 'Altura (m)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20),
            if (_resultado.isNotEmpty)
              Text(
                'Seu IMC é de $_resultado\nClassificado como $_classificacao',
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
