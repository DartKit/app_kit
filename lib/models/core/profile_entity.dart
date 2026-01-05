import 'dart:convert';
import 'package:app_kit/generated/json/base/json_field.dart';
import 'package:app_kit/generated/json/profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity {
  late String token = '';
  late ProfileInfo own = ProfileInfo();
  late bool isLogin = false;
  late bool check = false; // 是否选中隐私协议
  late String mobile = ''; //最近一次登录的手机号
  late double lat = 0.0;
  late double lon = 0.0;
  late String address = '';
  late bool can_ima_edit = false; // 选图后编辑
  late bool can_cam_edit = false; //拍照后编辑
  late bool use_cam_sys = true; // 使用系统相机
  late bool notifications_enabled = false; //通知权限
  late int readSetBgLoc = 0; // 是否已设置背景定位
  late String user_host = '';
  late String project_id = '';
  // late bool working = false;
  // late int workId = 0;
  // late int distance = 0;
  // late int duration = 0;
  // late String endTime = '';
  // late String userTip = '';
  // late String url = '';
  // late String title = '';
  // late String logo = '';
  // late String logo_mini = '';
  // late String background_image = '';
  // late String role_name = '';
  // late int role_id = 0;
  // late double paint_width = 4.0;
  // late bool nav_ls = false; //导航样式为列表
  // late bool use_ai = true; // 使用AI
  // late bool road_big = false; // 地图路线设置开关
  // late double road_zoom = 2.1; // 地图路线粗细
  // late double road_opacity = 0.7; // 地图路线透明度
  // late String last_domain = '';

  ProfileEntity();

  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      $ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProfileEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProfileInfo {
  late String token = '';
  // late String type = '';
  late ProfileInfoUser info = ProfileInfoUser();
  // late ProfileInfoProject project = ProfileInfoProject();
  // late List<ProfileInfoProject> projectLink = [];
  // late List<ProfileSite> site = [];

  ProfileInfo();

  factory ProfileInfo.fromJson(Map<String, dynamic> json) =>
      $ProfileInfoFromJson(json);

  Map<String, dynamic> toJson() => $ProfileInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProfileInfoUser {
  late int id = -1;
  late int super_type = 10; //super 10普通人员80超管
  late String mobile = '';
  late int project_id = -1;
  late int type = -1;
  late String real_name = '';
  late String nick_name = '';
  late String username = '';
  late List<String> department_name = [];
  late List<String> role_name = [];
  late List<String> department_type = [];
  late List<String> department_id = [];
  late String sex = '';
  late String avatar_url = '';
  late int status = 0;
  late int city_id = -1;
  late String mobile_format = '';
  late String strength_text = '';

  ProfileInfoUser();

  factory ProfileInfoUser.fromJson(Map<String, dynamic> json) =>
      $ProfileInfoUserFromJson(json);

  Map<String, dynamic> toJson() => $ProfileInfoUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProfileInfoProject {
  late int id = 0;
  late String logo = '';
  late String longitude = '';
  late String latitude = '';
  late String logo_mini = '';
  late String background_image = '';
  late String title = '';
  late String project_name = '';
  late String real_name = '';
  late String username = '';
  late String link_project_name = '';
  late int patrol_public = 0;
  late int background_patrol_time = 0;
  late int project_id = 0;

  ProfileInfoProject();

  factory ProfileInfoProject.fromJson(Map<String, dynamic> json) =>
      $ProfileInfoProjectFromJson(json);

  Map<String, dynamic> toJson() => $ProfileInfoProjectToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProfileSite {
  late String name = '';
  late String domain = '';
  late String remark = '';
  late String title = '';

  ProfileSite();

  factory ProfileSite.fromJson(Map<String, dynamic> json) =>
      $ProfileSiteFromJson(json);

  Map<String, dynamic> toJson() => $ProfileSiteToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
