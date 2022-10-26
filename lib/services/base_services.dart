import 'dart:async';
import 'dart:convert';

import 'package:flutter_show/models/entities/blog.dart';
import 'package:flutter_show/services/api/blognews_api.dart';

abstract class BaseServices {
  final BlogNewsApi blogApi;

  final String domain;

  BaseServices({
    required this.domain,
    String? blogDomain,
  }) : blogApi = BlogNewsApi(blogDomain ?? domain);


  Future<Blog> getPageById(int? pageId) async {
    var response = await blogApi.getAsync('pages/$pageId?_embed');
    return Blog.fromJson(response);
  }
}
