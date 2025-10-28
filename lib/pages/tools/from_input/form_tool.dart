
class FormTool {

 static String hint (String key) {
    Map<String,dynamic> map = {
    "work_path":"请添加",
    "team_path":"请添加",
    "image_camera":"请添加",
    "camera":"请添加",
    "image":"请添加",
    "file":"请添加",
    "none":"请添加",
    "map":"请选择",
    "pick_box":"请选择",
    "check_box":"请选择",
    "time_ymdhm":"请选择",
    "time2_ymd":"请选择",
    "time_ymd":"请选择",
    "time2_ym":"请选择",
    "time_ym":"请选择",
    "time_2y":"请选择",
    "time_y":"请选择",
    "drop_select_more":"请选择",
    "pick_tick":"请选择",
    "pick_sons":"请选择",
    "select_more":"请选择",
    "select":"请选择",
    "pull_search":"请选择",
    "add_minus":"请选择",
    "num":"请选择",
    "text":"请输入" ,
    };
    return  map.containsKey(key)? map[key] : '请添加';
  }
}