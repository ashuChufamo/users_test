import 'Support.dart';
import 'User.dart';

class UsersInPage {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<User>? user;
  Support? support;

  UsersInPage(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.user,
      this.support});

  UsersInPage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      user = <User>[];
      json['data'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
    support =
        json['support'] != null ? Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (user != null) {
      data['data'] = user!.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}
