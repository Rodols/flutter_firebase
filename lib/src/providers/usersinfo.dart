import 'package:flutter/material.dart';

class UsersInfo with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _restaurantName = '';
  String _identity = '';
  String _pasword = '';



  get name{
    return _name;
  }

  get phone{
    return _phone;
  }

  get email{
    return _email;
  }

  get restaurantName{
    return _restaurantName;
  }

  get identity{
    return _identity;
  }

  set name(String name){
    this._name = name;

    notifyListeners();
  }

  set phone(String phone){
    this._phone = phone;

    notifyListeners();
  }

  set email(String email){
    this._email = email;

    notifyListeners();
  }

  set identity(String identity){
    this._identity = identity;

    notifyListeners();
  }

  set restaurantName(String restaurantName){
    this._restaurantName = restaurantName;

    notifyListeners();
  }


}