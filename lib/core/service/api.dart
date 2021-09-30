import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:github_dashboard/core/model/repo.dart';
import 'package:github_dashboard/core/model/user.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class Api {
  static const endpoint = 'https://api.github.com';

  http.Client get client {
    return http.Client();
  }

  NetworkImage image(String name) {
    return NetworkImage('$name');
    // return NetworkImage('$endpoint/image/$name');
  }

  Future<User?> getUser(String username) async {
    print("api getUser : called");

    String url = '$endpoint/users/$username';
    Uri uri = Uri.parse(url);
    print(uri);

    var response = await client.get(
      uri,
    );
    print("api getUser : got response ${response.statusCode}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = (json.decode(response.body));

      User data = User.fromJson(jsonData);
      return data;
    }
    return null;
  }

  Future<List<Repo>?> getRepository(User user, {int page = 1}) async {
    print("api getRepository : called");

    String url = user.reposUrl!;
    url += '?page=$page';
    Uri uri = Uri.parse(url);
    print(uri);

    var response = await client.get(
      uri,
    );
    print("api getRepository : got response ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> jsonData = (json.decode(response.body));

      List<Repo> data = [];

      jsonData.forEach((element) {
        if (element is Map<String, dynamic>) {
          data.add(Repo.fromJson(element));
        }
      });

      return data;
    }
    return null;
  }
}
