import 'dart:async';
import 'dart:convert';

import 'package:flutter_show/common/config/defalut_env.dart';
import 'package:flutter_show/models/entities/blog.dart';
import 'package:flutter_show/services/api/blognews_api.dart';

class BlogServices {
  final BlogNewsApi blogApi;

  BlogServices(String blogDomain) : blogApi = BlogNewsApi(blogDomain);

  Future<List<Blog>> fetchBlogLayout({required config, lang}) async {
    try {
      var list = <Blog>[];
      var endPoint = 'posts?_embed';
      if (DefaultConfig.advanceConfig['httpCache']) {
        endPoint += '&lang=$lang';
      }
      if (config.containsKey('category')) {
        endPoint += "&categories=${config["category"]}";
      }
      if (config.containsKey('tag')) {
        endPoint += "&tags=${config["tag"]}";
      }
      if (config.containsKey('limit')) {
        endPoint += "&per_page=${config["limit"] ?? 20}";
      }

      var response = await blogApi.getAsync(endPoint);

      for (var item in response) {
        list.add(Blog.fromJson(item));
      }

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<Blog> getPageById(int? pageId) async {
    var response = await blogApi.getAsync('pages/$pageId?_embed');
    return Blog.fromJson(response);
  }
}
