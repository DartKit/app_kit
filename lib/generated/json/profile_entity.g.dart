import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/profile_entity.dart';

ProfileEntity $ProfileEntityFromJson(Map<String, dynamic> json) {
  final ProfileEntity profileEntity = ProfileEntity();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    profileEntity.token = token;
  }
  final ProfileInfo? own = jsonConvert.convert<ProfileInfo>(json['own']);
  if (own != null) {
    profileEntity.own = own;
  }
  final bool? isLogin = jsonConvert.convert<bool>(json['isLogin']);
  if (isLogin != null) {
    profileEntity.isLogin = isLogin;
  }
  final bool? check = jsonConvert.convert<bool>(json['check']);
  if (check != null) {
    profileEntity.check = check;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    profileEntity.mobile = mobile;
  }
  final double? lat = jsonConvert.convert<double>(json['lat']);
  if (lat != null) {
    profileEntity.lat = lat;
  }
  final double? lon = jsonConvert.convert<double>(json['lon']);
  if (lon != null) {
    profileEntity.lon = lon;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    profileEntity.address = address;
  }
  final bool? can_ima_edit = jsonConvert.convert<bool>(json['can_ima_edit']);
  if (can_ima_edit != null) {
    profileEntity.can_ima_edit = can_ima_edit;
  }
  final bool? can_cam_edit = jsonConvert.convert<bool>(json['can_cam_edit']);
  if (can_cam_edit != null) {
    profileEntity.can_cam_edit = can_cam_edit;
  }
  final bool? use_cam_sys = jsonConvert.convert<bool>(json['use_cam_sys']);
  if (use_cam_sys != null) {
    profileEntity.use_cam_sys = use_cam_sys;
  }
  final bool? notifications_enabled = jsonConvert.convert<bool>(json['notifications_enabled']);
  if (notifications_enabled != null) {
    profileEntity.notifications_enabled = notifications_enabled;
  }
  final int? readSetBgLoc = jsonConvert.convert<int>(json['readSetBgLoc']);
  if (readSetBgLoc != null) {
    profileEntity.readSetBgLoc = readSetBgLoc;
  }
  final String? user_host = jsonConvert.convert<String>(json['user_host']);
  if (user_host != null) {
    profileEntity.user_host = user_host;
  }
  final String? project_id = jsonConvert.convert<String>(json['project_id']);
  if (project_id != null) {
    profileEntity.project_id = project_id;
  }
  return profileEntity;
}

Map<String, dynamic> $ProfileEntityToJson(ProfileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['own'] = entity.own.toJson();
  data['isLogin'] = entity.isLogin;
  data['check'] = entity.check;
  data['mobile'] = entity.mobile;
  data['lat'] = entity.lat;
  data['lon'] = entity.lon;
  data['address'] = entity.address;
  data['can_ima_edit'] = entity.can_ima_edit;
  data['can_cam_edit'] = entity.can_cam_edit;
  data['use_cam_sys'] = entity.use_cam_sys;
  data['notifications_enabled'] = entity.notifications_enabled;
  data['readSetBgLoc'] = entity.readSetBgLoc;
  data['user_host'] = entity.user_host;
  data['project_id'] = entity.project_id;
  return data;
}

extension ProfileEntityExtension on ProfileEntity {
  ProfileEntity copyWith({
    String? token,
    ProfileInfo? own,
    bool? isLogin,
    bool? check,
    String? mobile,
    double? lat,
    double? lon,
    String? address,
    bool? can_ima_edit,
    bool? can_cam_edit,
    bool? use_cam_sys,
    bool? notifications_enabled,
    int? readSetBgLoc,
    String? user_host,
    String? project_id,
  }) {
    return ProfileEntity()
      ..token = token ?? this.token
      ..own = own ?? this.own
      ..isLogin = isLogin ?? this.isLogin
      ..check = check ?? this.check
      ..mobile = mobile ?? this.mobile
      ..lat = lat ?? this.lat
      ..lon = lon ?? this.lon
      ..address = address ?? this.address
      ..can_ima_edit = can_ima_edit ?? this.can_ima_edit
      ..can_cam_edit = can_cam_edit ?? this.can_cam_edit
      ..use_cam_sys = use_cam_sys ?? this.use_cam_sys
      ..notifications_enabled = notifications_enabled ?? this.notifications_enabled
      ..readSetBgLoc = readSetBgLoc ?? this.readSetBgLoc
      ..user_host = user_host ?? this.user_host
      ..project_id = project_id ?? this.project_id;
  }
}

ProfileInfo $ProfileInfoFromJson(Map<String, dynamic> json) {
  final ProfileInfo profileInfo = ProfileInfo();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    profileInfo.token = token;
  }
  final ProfileInfoUser? info = jsonConvert.convert<ProfileInfoUser>(json['info']);
  if (info != null) {
    profileInfo.info = info;
  }
  return profileInfo;
}

Map<String, dynamic> $ProfileInfoToJson(ProfileInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['info'] = entity.info.toJson();
  return data;
}

extension ProfileInfoExtension on ProfileInfo {
  ProfileInfo copyWith({
    String? token,
    ProfileInfoUser? info,
  }) {
    return ProfileInfo()
      ..token = token ?? this.token
      ..info = info ?? this.info;
  }
}

ProfileInfoUser $ProfileInfoUserFromJson(Map<String, dynamic> json) {
  final ProfileInfoUser profileInfoUser = ProfileInfoUser();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    profileInfoUser.id = id;
  }
  final int? super_type = jsonConvert.convert<int>(json['super_type']);
  if (super_type != null) {
    profileInfoUser.super_type = super_type;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    profileInfoUser.mobile = mobile;
  }
  final int? project_id = jsonConvert.convert<int>(json['project_id']);
  if (project_id != null) {
    profileInfoUser.project_id = project_id;
  }
  final int? type = jsonConvert.convert<int>(json['type']);
  if (type != null) {
    profileInfoUser.type = type;
  }
  final String? real_name = jsonConvert.convert<String>(json['real_name']);
  if (real_name != null) {
    profileInfoUser.real_name = real_name;
  }
  final String? nick_name = jsonConvert.convert<String>(json['nick_name']);
  if (nick_name != null) {
    profileInfoUser.nick_name = nick_name;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    profileInfoUser.username = username;
  }
  final List<String>? department_name = (json['department_name'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (department_name != null) {
    profileInfoUser.department_name = department_name;
  }
  final List<String>? role_name = (json['role_name'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (role_name != null) {
    profileInfoUser.role_name = role_name;
  }
  final List<String>? department_type = (json['department_type'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (department_type != null) {
    profileInfoUser.department_type = department_type;
  }
  final List<String>? department_id = (json['department_id'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (department_id != null) {
    profileInfoUser.department_id = department_id;
  }
  final String? sex = jsonConvert.convert<String>(json['sex']);
  if (sex != null) {
    profileInfoUser.sex = sex;
  }
  final String? avatar_url = jsonConvert.convert<String>(json['avatar_url']);
  if (avatar_url != null) {
    profileInfoUser.avatar_url = avatar_url;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    profileInfoUser.status = status;
  }
  final int? city_id = jsonConvert.convert<int>(json['city_id']);
  if (city_id != null) {
    profileInfoUser.city_id = city_id;
  }
  final String? mobile_format = jsonConvert.convert<String>(json['mobile_format']);
  if (mobile_format != null) {
    profileInfoUser.mobile_format = mobile_format;
  }
  final String? strength_text = jsonConvert.convert<String>(json['strength_text']);
  if (strength_text != null) {
    profileInfoUser.strength_text = strength_text;
  }
  return profileInfoUser;
}

Map<String, dynamic> $ProfileInfoUserToJson(ProfileInfoUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['super_type'] = entity.super_type;
  data['mobile'] = entity.mobile;
  data['project_id'] = entity.project_id;
  data['type'] = entity.type;
  data['real_name'] = entity.real_name;
  data['nick_name'] = entity.nick_name;
  data['username'] = entity.username;
  data['department_name'] = entity.department_name;
  data['role_name'] = entity.role_name;
  data['department_type'] = entity.department_type;
  data['department_id'] = entity.department_id;
  data['sex'] = entity.sex;
  data['avatar_url'] = entity.avatar_url;
  data['status'] = entity.status;
  data['city_id'] = entity.city_id;
  data['mobile_format'] = entity.mobile_format;
  data['strength_text'] = entity.strength_text;
  return data;
}

extension ProfileInfoUserExtension on ProfileInfoUser {
  ProfileInfoUser copyWith({
    int? id,
    int? super_type,
    String? mobile,
    int? project_id,
    int? type,
    String? real_name,
    String? nick_name,
    String? username,
    List<String>? department_name,
    List<String>? role_name,
    List<String>? department_type,
    List<String>? department_id,
    String? sex,
    String? avatar_url,
    int? status,
    int? city_id,
    String? mobile_format,
    String? strength_text,
  }) {
    return ProfileInfoUser()
      ..id = id ?? this.id
      ..super_type = super_type ?? this.super_type
      ..mobile = mobile ?? this.mobile
      ..project_id = project_id ?? this.project_id
      ..type = type ?? this.type
      ..real_name = real_name ?? this.real_name
      ..nick_name = nick_name ?? this.nick_name
      ..username = username ?? this.username
      ..department_name = department_name ?? this.department_name
      ..role_name = role_name ?? this.role_name
      ..department_type = department_type ?? this.department_type
      ..department_id = department_id ?? this.department_id
      ..sex = sex ?? this.sex
      ..avatar_url = avatar_url ?? this.avatar_url
      ..status = status ?? this.status
      ..city_id = city_id ?? this.city_id
      ..mobile_format = mobile_format ?? this.mobile_format
      ..strength_text = strength_text ?? this.strength_text;
  }
}

ProfileInfoProject $ProfileInfoProjectFromJson(Map<String, dynamic> json) {
  final ProfileInfoProject profileInfoProject = ProfileInfoProject();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    profileInfoProject.id = id;
  }
  final String? logo = jsonConvert.convert<String>(json['logo']);
  if (logo != null) {
    profileInfoProject.logo = logo;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    profileInfoProject.longitude = longitude;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    profileInfoProject.latitude = latitude;
  }
  final String? logo_mini = jsonConvert.convert<String>(json['logo_mini']);
  if (logo_mini != null) {
    profileInfoProject.logo_mini = logo_mini;
  }
  final String? background_image = jsonConvert.convert<String>(json['background_image']);
  if (background_image != null) {
    profileInfoProject.background_image = background_image;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    profileInfoProject.title = title;
  }
  final String? project_name = jsonConvert.convert<String>(json['project_name']);
  if (project_name != null) {
    profileInfoProject.project_name = project_name;
  }
  final String? real_name = jsonConvert.convert<String>(json['real_name']);
  if (real_name != null) {
    profileInfoProject.real_name = real_name;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    profileInfoProject.username = username;
  }
  final String? link_project_name = jsonConvert.convert<String>(json['link_project_name']);
  if (link_project_name != null) {
    profileInfoProject.link_project_name = link_project_name;
  }
  final int? patrol_public = jsonConvert.convert<int>(json['patrol_public']);
  if (patrol_public != null) {
    profileInfoProject.patrol_public = patrol_public;
  }
  final int? background_patrol_time = jsonConvert.convert<int>(json['background_patrol_time']);
  if (background_patrol_time != null) {
    profileInfoProject.background_patrol_time = background_patrol_time;
  }
  final int? project_id = jsonConvert.convert<int>(json['project_id']);
  if (project_id != null) {
    profileInfoProject.project_id = project_id;
  }
  return profileInfoProject;
}

Map<String, dynamic> $ProfileInfoProjectToJson(ProfileInfoProject entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['logo'] = entity.logo;
  data['longitude'] = entity.longitude;
  data['latitude'] = entity.latitude;
  data['logo_mini'] = entity.logo_mini;
  data['background_image'] = entity.background_image;
  data['title'] = entity.title;
  data['project_name'] = entity.project_name;
  data['real_name'] = entity.real_name;
  data['username'] = entity.username;
  data['link_project_name'] = entity.link_project_name;
  data['patrol_public'] = entity.patrol_public;
  data['background_patrol_time'] = entity.background_patrol_time;
  data['project_id'] = entity.project_id;
  return data;
}

extension ProfileInfoProjectExtension on ProfileInfoProject {
  ProfileInfoProject copyWith({
    int? id,
    String? logo,
    String? longitude,
    String? latitude,
    String? logo_mini,
    String? background_image,
    String? title,
    String? project_name,
    String? real_name,
    String? username,
    String? link_project_name,
    int? patrol_public,
    int? background_patrol_time,
    int? project_id,
  }) {
    return ProfileInfoProject()
      ..id = id ?? this.id
      ..logo = logo ?? this.logo
      ..longitude = longitude ?? this.longitude
      ..latitude = latitude ?? this.latitude
      ..logo_mini = logo_mini ?? this.logo_mini
      ..background_image = background_image ?? this.background_image
      ..title = title ?? this.title
      ..project_name = project_name ?? this.project_name
      ..real_name = real_name ?? this.real_name
      ..username = username ?? this.username
      ..link_project_name = link_project_name ?? this.link_project_name
      ..patrol_public = patrol_public ?? this.patrol_public
      ..background_patrol_time = background_patrol_time ?? this.background_patrol_time
      ..project_id = project_id ?? this.project_id;
  }
}

ProfileSite $ProfileSiteFromJson(Map<String, dynamic> json) {
  final ProfileSite profileSite = ProfileSite();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    profileSite.name = name;
  }
  final String? domain = jsonConvert.convert<String>(json['domain']);
  if (domain != null) {
    profileSite.domain = domain;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    profileSite.remark = remark;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    profileSite.title = title;
  }
  return profileSite;
}

Map<String, dynamic> $ProfileSiteToJson(ProfileSite entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['domain'] = entity.domain;
  data['remark'] = entity.remark;
  data['title'] = entity.title;
  return data;
}

extension ProfileSiteExtension on ProfileSite {
  ProfileSite copyWith({
    String? name,
    String? domain,
    String? remark,
    String? title,
  }) {
    return ProfileSite()
      ..name = name ?? this.name
      ..domain = domain ?? this.domain
      ..remark = remark ?? this.remark
      ..title = title ?? this.title;
  }
}