import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://api.the-ring.io';

//  static const endpoint = 'http://192.168.5.1:3600';

  http.Client get client {
    return http.Client();
  }

  NetworkImage image(String name) {
    return NetworkImage('$name');
    // return NetworkImage('$endpoint/image/$name');
  }

}
