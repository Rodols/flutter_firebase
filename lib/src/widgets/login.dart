import 'package:flutter/material.dart';

class LoginModal extends StatefulWidget {
  @override
  LoginModalState createState() => LoginModalState();
}

class LoginModalState extends State <LoginModal> {

  //Variables del login
  TextEditingController  emailCtrl = new TextEditingController();
  TextEditingController  mobileCtrl = new TextEditingController();
  TextEditingController  passwordCtrl = new TextEditingController();

  //Variable para el formulario
  GlobalKey<FormState> keyForm= new GlobalKey();

  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        appBar:  AppBar(
          title:  Text('Login') ,
        ),
        body:  SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              key: keyForm,
              child: formLogin(),
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formLogin() {
    return  Column(
      children: <Widget>[
        //Aqui van los elementos de nuestro dormulario
        formItemsDesign(
            Icons.email,
            TextFormField(
              controller: emailCtrl,
              decoration: new InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              maxLength: 32,
              validator: validateEmail,)),
        formItemsDesign(
            Icons.remove_red_eye,
            TextFormField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            )),
        GestureDetector(
          onTap: (){
            save();
          },child: Container(
          margin: new EdgeInsets.all(30.0),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)),
          gradient: LinearGradient( colors: [
            Color(0xFF0EDED2),
            Color(0xFF03A0FE),
          ],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Text('Ingresar',
            style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500)),
          padding: EdgeInsets.only(top: 16, bottom: 16),
            ))
      ],
    );
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    print("valorrr $value passsword ${passwordCtrl.text}");
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }


  save() {
    if (keyForm.currentState.validate()) {
      print("Telefono ${mobileCtrl.text}");
      print("Correo ${emailCtrl.text}");
      print("password ${passwordCtrl.text}");
      keyForm.currentState.reset();
    }
  }




}

