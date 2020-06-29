export 'voice.dart';

class GlobalConfig {
  static String xfKey = '5edb073a';
  static String xfAndroidKey = '5edb073a';

  static String actionUrl = '';
  static Map actionList = {
    "loading": {
      "action": "loading",
      "desc": "反正就是个loading"
    },
    "preview": {
      "action": "preview",
      "desc": "旋转"
    },
    "buying": {
      "action": "buying",
      "desc": "左看右看"
    },
    "hello": {
      "action": "hello",
      "desc": "挥手"
    },
    "show": {
      "action": "show",
      "desc": "抱着"
    },
    "preview_deco": {
      "action": "preview_deco",
      "desc": "装扮预览"
    },
    "show_deco": {
      "action": "show_deco",
      "desc": "装扮上身"
    },
    "listen": {
      "action": "listen",
      "desc": "聆听"
    },
    "sing": {
      "action": "sing",
      "desc": "唱歌"
    }
  };
}