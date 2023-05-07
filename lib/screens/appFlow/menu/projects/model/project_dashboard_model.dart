// To parse this JSON data, do
//
//     final projectDashboardModel = projectDashboardModelFromJson(jsonString);

import 'dart:convert';

ProjectDashboardModel projectDashboardModelFromJson(String str) => ProjectDashboardModel.fromJson(json.decode(str));

class ProjectDashboardModel {
    ProjectDashboardModel({
        this.result,
        this.message,
        this.data,
    });

    bool ?result;
    String? message;
    Data? data;

    factory ProjectDashboardModel.fromJson(Map<String, dynamic> json) => ProjectDashboardModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

   
}

class Data {
    Data({
        this.staticstics,
        this.projects,
    });

    List<Staticstic>? staticstics;
    List<Project>? projects;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        staticstics: List<Staticstic>.from(json["staticstics"].map((x) => Staticstic.fromJson(x))),
        projects: List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
    );

  
}

class Project {
    Project({
        this.id,
        this.title,
        this.dateRange,
        this.userCount,
        this.members,
        this.progress,
        this.color,
        this.status,
        this.priority,
        this.priorityColor,
        this.clickable,
        this.endPoint,
    });

    int? id;
    String ?title;
    String? dateRange;
    int? userCount;
    List<Members>? members;
    int? progress;
    String? color;
    String ?status;
    String ?priority;
    String? priorityColor;
    bool? clickable;
    String ?endPoint;

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        title: json["title"],
        dateRange: json["date_range"],
        userCount: json["user_count"],
        members: List<Members>.from(json["members"].map((x) => Members.fromJson(x))),
        progress: json["progress"],
        color: json["color"],
        status: json["status"],
        priority: json["priority"],
        priorityColor: json["priority_color"],
        clickable: json["clickable"],
        endPoint: json["end_point"],
    );

   
}

class Members {
    Members({
        this.id,
        this.name,
        this.phone,
        this.email,
        this.avatar,
        this.department,
        this.designation,

    });
    int ?id;
    String? name;
    String? phone;
    String? email;
    String? avatar;
    String? department;
    String? designation;


    factory Members.fromJson(Map<String, dynamic> json) => Members(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        avatar: json["avatar"],
        department: json["department"],
        designation: json["designation"],

    );
}

class Staticstic {
    Staticstic({
        this.count,
        this.label,
        this.image,
        this.status,
    });

    int? count;
    String? label;
    String? image;
    int ?status;

    factory Staticstic.fromJson(Map<String, dynamic> json) => Staticstic(
        count: json["count"],
        label: json["label"],
        image: json["image"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "label": label,
        "image": image,
        "status": status,
    };
}
