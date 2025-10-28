import 'package:app_kit/generated/json/base/json_convert_content.dart';
import 'package:app_kit/models/core/profile_entity.dart';

ProfileEntity $ProfileEntityFromJson(Map<String, dynamic> json) {
  final ProfileEntity profileEntity = ProfileEntity();
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
  final bool? working = jsonConvert.convert<bool>(json['working']);
  if (working != null) {
    profileEntity.working = working;
  }
  final int? workId = jsonConvert.convert<int>(json['workId']);
  if (workId != null) {
    profileEntity.workId = workId;
  }
  final int? distance = jsonConvert.convert<int>(json['distance']);
  if (distance != null) {
    profileEntity.distance = distance;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    profileEntity.duration = duration;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    profileEntity.token = token;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    profileEntity.mobile = mobile;
  }
  final String? endTime = jsonConvert.convert<String>(json['endTime']);
  if (endTime != null) {
    profileEntity.endTime = endTime;
  }
  final String? userTip = jsonConvert.convert<String>(json['userTip']);
  if (userTip != null) {
    profileEntity.userTip = userTip;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    profileEntity.url = url;
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
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    profileEntity.title = title;
  }
  final String? logo = jsonConvert.convert<String>(json['logo']);
  if (logo != null) {
    profileEntity.logo = logo;
  }
  final String? logo_mini = jsonConvert.convert<String>(json['logo_mini']);
  if (logo_mini != null) {
    profileEntity.logo_mini = logo_mini;
  }
  final String? background_image = jsonConvert.convert<String>(json['background_image']);
  if (background_image != null) {
    profileEntity.background_image = background_image;
  }
  final String? role_name = jsonConvert.convert<String>(json['role_name']);
  if (role_name != null) {
    profileEntity.role_name = role_name;
  }
  final int? role_id = jsonConvert.convert<int>(json['role_id']);
  if (role_id != null) {
    profileEntity.role_id = role_id;
  }
  final bool? can_ima_edit = jsonConvert.convert<bool>(json['can_ima_edit']);
  if (can_ima_edit != null) {
    profileEntity.can_ima_edit = can_ima_edit;
  }
  final bool? can_cam_edit = jsonConvert.convert<bool>(json['can_cam_edit']);
  if (can_cam_edit != null) {
    profileEntity.can_cam_edit = can_cam_edit;
  }
  final bool? nav_ls = jsonConvert.convert<bool>(json['nav_ls']);
  if (nav_ls != null) {
    profileEntity.nav_ls = nav_ls;
  }
  final bool? use_cam_sys = jsonConvert.convert<bool>(json['use_cam_sys']);
  if (use_cam_sys != null) {
    profileEntity.use_cam_sys = use_cam_sys;
  }
  final bool? use_ai = jsonConvert.convert<bool>(json['use_ai']);
  if (use_ai != null) {
    profileEntity.use_ai = use_ai;
  }
  final bool? only_seged = jsonConvert.convert<bool>(json['only_seged']);
  if (only_seged != null) {
    profileEntity.only_seged = only_seged;
  }
  final bool? road_big = jsonConvert.convert<bool>(json['road_big']);
  if (road_big != null) {
    profileEntity.road_big = road_big;
  }
  final double? road_zoom = jsonConvert.convert<double>(json['road_zoom']);
  if (road_zoom != null) {
    profileEntity.road_zoom = road_zoom;
  }
  final double? font_zoom = jsonConvert.convert<double>(json['font_zoom']);
  if (font_zoom != null) {
    profileEntity.font_zoom = font_zoom;
  }
  final double? road_opacity = jsonConvert.convert<double>(json['road_opacity']);
  if (road_opacity != null) {
    profileEntity.road_opacity = road_opacity;
  }
  final bool? notifications_enabled = jsonConvert.convert<bool>(json['notifications_enabled']);
  if (notifications_enabled != null) {
    profileEntity.notifications_enabled = notifications_enabled;
  }
  final int? readSetBgLoc = jsonConvert.convert<int>(json['readSetBgLoc']);
  if (readSetBgLoc != null) {
    profileEntity.readSetBgLoc = readSetBgLoc;
  }
  final String? last_domain = jsonConvert.convert<String>(json['last_domain']);
  if (last_domain != null) {
    profileEntity.last_domain = last_domain;
  }
  final String? user_host = jsonConvert.convert<String>(json['user_host']);
  if (user_host != null) {
    profileEntity.user_host = user_host;
  }
  return profileEntity;
}

Map<String, dynamic> $ProfileEntityToJson(ProfileEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['own'] = entity.own.toJson();
  data['isLogin'] = entity.isLogin;
  data['check'] = entity.check;
  data['working'] = entity.working;
  data['workId'] = entity.workId;
  data['distance'] = entity.distance;
  data['duration'] = entity.duration;
  data['token'] = entity.token;
  data['mobile'] = entity.mobile;
  data['endTime'] = entity.endTime;
  data['userTip'] = entity.userTip;
  data['url'] = entity.url;
  data['lat'] = entity.lat;
  data['lon'] = entity.lon;
  data['address'] = entity.address;
  data['title'] = entity.title;
  data['logo'] = entity.logo;
  data['logo_mini'] = entity.logo_mini;
  data['background_image'] = entity.background_image;
  data['role_name'] = entity.role_name;
  data['role_id'] = entity.role_id;
  data['can_ima_edit'] = entity.can_ima_edit;
  data['can_cam_edit'] = entity.can_cam_edit;
  data['nav_ls'] = entity.nav_ls;
  data['use_cam_sys'] = entity.use_cam_sys;
  data['use_ai'] = entity.use_ai;
  data['only_seged'] = entity.only_seged;
  data['road_big'] = entity.road_big;
  data['road_zoom'] = entity.road_zoom;
  data['font_zoom'] = entity.font_zoom;
  data['road_opacity'] = entity.road_opacity;
  data['notifications_enabled'] = entity.notifications_enabled;
  data['readSetBgLoc'] = entity.readSetBgLoc;
  data['last_domain'] = entity.last_domain;
  data['user_host'] = entity.user_host;
  return data;
}

extension ProfileEntityExtension on ProfileEntity {
  ProfileEntity copyWith({
    ProfileInfo? own,
    bool? isLogin,
    bool? check,
    bool? working,
    int? workId,
    int? distance,
    int? duration,
    String? token,
    String? mobile,
    String? endTime,
    String? userTip,
    String? url,
    double? lat,
    double? lon,
    String? address,
    String? title,
    String? logo,
    String? logo_mini,
    String? background_image,
    String? role_name,
    int? role_id,
    bool? can_ima_edit,
    bool? can_cam_edit,
    bool? nav_ls,
    bool? use_cam_sys,
    bool? use_ai,
    bool? only_seged,
    bool? road_big,
    double? road_zoom,
    double? font_zoom,
    double? road_opacity,
    bool? notifications_enabled,
    int? readSetBgLoc,
    String? last_domain,
    String? user_host,
  }) {
    return ProfileEntity()
      ..own = own ?? this.own
      ..isLogin = isLogin ?? this.isLogin
      ..check = check ?? this.check
      ..working = working ?? this.working
      ..workId = workId ?? this.workId
      ..distance = distance ?? this.distance
      ..duration = duration ?? this.duration
      ..token = token ?? this.token
      ..mobile = mobile ?? this.mobile
      ..endTime = endTime ?? this.endTime
      ..userTip = userTip ?? this.userTip
      ..url = url ?? this.url
      ..lat = lat ?? this.lat
      ..lon = lon ?? this.lon
      ..address = address ?? this.address
      ..title = title ?? this.title
      ..logo = logo ?? this.logo
      ..logo_mini = logo_mini ?? this.logo_mini
      ..background_image = background_image ?? this.background_image
      ..role_name = role_name ?? this.role_name
      ..role_id = role_id ?? this.role_id
      ..can_ima_edit = can_ima_edit ?? this.can_ima_edit
      ..can_cam_edit = can_cam_edit ?? this.can_cam_edit
      ..nav_ls = nav_ls ?? this.nav_ls
      ..use_cam_sys = use_cam_sys ?? this.use_cam_sys
      ..use_ai = use_ai ?? this.use_ai
      ..only_seged = only_seged ?? this.only_seged
      ..road_big = road_big ?? this.road_big
      ..road_zoom = road_zoom ?? this.road_zoom
      ..font_zoom = font_zoom ?? this.font_zoom
      ..road_opacity = road_opacity ?? this.road_opacity
      ..notifications_enabled = notifications_enabled ?? this.notifications_enabled
      ..readSetBgLoc = readSetBgLoc ?? this.readSetBgLoc
      ..last_domain = last_domain ?? this.last_domain
      ..user_host = user_host ?? this.user_host;
  }
}

ProfileInfo $ProfileInfoFromJson(Map<String, dynamic> json) {
  final ProfileInfo profileInfo = ProfileInfo();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    profileInfo.token = token;
  }
  final String? currentAuthority = jsonConvert.convert<String>(json['currentAuthority']);
  if (currentAuthority != null) {
    profileInfo.currentAuthority = currentAuthority;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    profileInfo.type = type;
  }
  final ProfileInfoUser? user = jsonConvert.convert<ProfileInfoUser>(json['user']);
  if (user != null) {
    profileInfo.user = user;
  }
  final ProfileInfoProject? project = jsonConvert.convert<ProfileInfoProject>(json['project']);
  if (project != null) {
    profileInfo.project = project;
  }
  final List<ProfileInfoProject>? projectLink = (json['projectLink'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ProfileInfoProject>(e) as ProfileInfoProject).toList();
  if (projectLink != null) {
    profileInfo.projectLink = projectLink;
  }
  final int? expire_at = jsonConvert.convert<int>(json['expire_at']);
  if (expire_at != null) {
    profileInfo.expire_at = expire_at;
  }
  final List<ProfileSite>? site = (json['site'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ProfileSite>(e) as ProfileSite).toList();
  if (site != null) {
    profileInfo.site = site;
  }
  return profileInfo;
}

Map<String, dynamic> $ProfileInfoToJson(ProfileInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['currentAuthority'] = entity.currentAuthority;
  data['type'] = entity.type;
  data['user'] = entity.user.toJson();
  data['project'] = entity.project.toJson();
  data['projectLink'] = entity.projectLink.map((v) => v.toJson()).toList();
  data['expire_at'] = entity.expire_at;
  data['site'] = entity.site.map((v) => v.toJson()).toList();
  return data;
}

extension ProfileInfoExtension on ProfileInfo {
  ProfileInfo copyWith({
    String? token,
    String? currentAuthority,
    String? type,
    ProfileInfoUser? user,
    ProfileInfoProject? project,
    List<ProfileInfoProject>? projectLink,
    int? expire_at,
    List<ProfileSite>? site,
  }) {
    return ProfileInfo()
      ..token = token ?? this.token
      ..currentAuthority = currentAuthority ?? this.currentAuthority
      ..type = type ?? this.type
      ..user = user ?? this.user
      ..project = project ?? this.project
      ..projectLink = projectLink ?? this.projectLink
      ..expire_at = expire_at ?? this.expire_at
      ..site = site ?? this.site;
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
  final bool? is_supervise = jsonConvert.convert<bool>(json['is_supervise']);
  if (is_supervise != null) {
    profileInfoUser.is_supervise = is_supervise;
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
  data['is_supervise'] = entity.is_supervise;
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
    bool? is_supervise,
  }) {
    return ProfileInfoUser()
      ..id = id ?? this.id
      ..super_type = super_type ?? this.super_type
      ..mobile = mobile ?? this.mobile
      ..project_id = project_id ?? this.project_id
      ..type = type ?? this.type
      ..real_name = real_name ?? this.real_name
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
      ..strength_text = strength_text ?? this.strength_text
      ..is_supervise = is_supervise ?? this.is_supervise;
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