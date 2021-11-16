import 'package:flutter/material.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 30),
                    //Se crea una instancia de LoginFormProvider que solo esta disponible para _LoginForm
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        //Key mantiene la referencia entre el provider y el widget para que el validate() funcione sobre este Form
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.dou@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_sharp,
              ),
              //Pasa valor de email al provider
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                //El validator devuelve null si el texto cumple con la regExp, si no devuelve el mensaje
                return regExp.hasMatch(value ?? '') ? null : 'El correo elctrónico no es válido';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              //Pasa valor de password al provider
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6) ? null : 'El correo elctrónico no es válido';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      //Quita el teclado de la pantalla
                      FocusScope.of(context).unfocus();
                      //si el form no es validado no accede
                      if (!loginForm.isValidForm()) return;
                      //else
                      loginForm.isLoading = true;

                      await Future.delayed(Duration(seconds: 2));

                      loginForm.isLoading = false;
                      //TODO:Validar si el login es correcto
                      Navigator.pushReplacementNamed(context, 'home');
                    },
            )
          ],
        ),
      ),
    );
  }
}
