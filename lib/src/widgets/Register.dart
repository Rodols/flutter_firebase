import 'package:firebase_app/src/providers/usersinfo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRestaurant extends StatefulWidget {
  @override
  _RegisterRestaurantState createState() => _RegisterRestaurantState();
}

class _RegisterRestaurantState extends State<RegisterRestaurant> {
  //Variables del register
  TextEditingController  nameCtrl = new TextEditingController();
  TextEditingController  emailCtrl = new TextEditingController();
  TextEditingController  mobileCtrl = new TextEditingController();
  TextEditingController  passwordCtrl = new TextEditingController();
  TextEditingController  repeatPassCtrl = new TextEditingController();
  TextEditingController  restaurantNameCtrl = new TextEditingController();
  TextEditingController  identityCtrl = new TextEditingController();

  //Firebase instancia
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Variable para el formulario
  GlobalKey<FormState> keyForm= new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Register') ,
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: new Form(
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
            Icons.person_add,
            TextFormField(
              controller: nameCtrl,
              decoration: new InputDecoration(
                labelText: 'Name',
              ),
              keyboardType: TextInputType.name,
              maxLength: 32,
              validator: validateName,)),
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
        formItemsDesign(
            Icons.remove_red_eye,
            TextFormField(
              controller: repeatPassCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
              ),
              validator: validatePassword,
            )),
        formItemsDesign(
            Icons.restaurant,
            TextFormField(
              controller: restaurantNameCtrl,
              decoration: new InputDecoration(
                labelText: 'Nombre del restaurante',
              ),
              keyboardType: TextInputType.name,
              maxLength: 32,
              validator: validateName,)),
        formItemsDesign(
            Icons.phone,
            TextFormField(
              controller: mobileCtrl,
              decoration: new InputDecoration(
                labelText: 'Numero de telefono',
              ),
              keyboardType: TextInputType.name,
              maxLength: 32,
              validator: validateName,)),
        formItemsDesign(
            Icons.contacts,
            TextFormField(
              controller: identityCtrl,
              decoration: new InputDecoration(
                labelText: 'No. Indentificación',
              ),
              keyboardType: TextInputType.name,
              maxLength: 32,
              validator: validateName,)),
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

  String validateName(String value) {
    print("valorrr $value name ${nameCtrl.text}");
    if (value == '') {
      return "el nombre  no es valido";
    }
    return null;
  }

  // Example code for registration.
  Future<void> _register() async {
    final user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailCtrl.text,
      password: passwordCtrl.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        //_success = true;
        //_userEmail = user.email;
        print('hola');
      });
    } else {
     // _success = false;
      print('hola');
    }
  }

  save() {
    if (keyForm.currentState.validate()) {
      print("Nombre ${nameCtrl.text}");
      print("Telefono ${mobileCtrl.text}");
      print("Correo ${emailCtrl.text}");
      print("Restaurant name ${restaurantNameCtrl.text}");
      print("Identity ${identityCtrl.text}");
      UsersInfo user = new UsersInfo();
      user.name = nameCtrl.text;
      user.phone = mobileCtrl.text;
      user.email = emailCtrl.text;
      user.restaurantName = restaurantNameCtrl.text;
      user.identity = identityCtrl.text;
      addUser(user);
      keyForm.currentState.reset();
    }
  }

  addUser(UsersInfo user) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'name': user.name, // John Doe
      'phone': user.phone, // Stokes and Sons
      'email': user.email, // Stokes and Sons
      'restaurantName': user.restaurantName, // 42
      'identity': user.identity, // Stokes and Sons
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

}
