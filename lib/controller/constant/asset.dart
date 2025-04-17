// ignore_for_file: non_constant_identifier_names, constant_identifier_names

enum AppAnimation {
  activity,
  alert,
  aperture,
  arrow,
  basket,
  bell,
  calendar,
  camera,
  celebration,
  chat,
  checklist,
  compass,
  confetti_alternative,
  confetti,
  connection_lost,
  creditcard,
  exclamation,
  exit,
  failed,
  file,
  fingerprint,
  gallery,
  gears,
  gift,
  graph_line,
  location,
  lock,
  like,
  maintenance,
  microphone,
  qr,
  scan,
  sound,
  star,
  success,
  user_group,
  user,
  wallet;

  String get path => 'assets/animation/$name.json';

  static List<AppAnimation> get valuesList => AppAnimation.values;
}

enum AppIcon {
  credit_card,
  eye,
  images,
  letter,
  link_alt,
  link,
  menu,
  home,
  wallet,
  lock;

  String get path => 'assets/icon/$name.png';

  static List<AppIcon> get valuesList => AppIcon.values;
}

class AppFont {
  static String avenir = "Avenir";
}

enum AppImage {
  amblem_on_dark,
  logo_on_dark,
  logotype_on_dark,
  amblem_on_light,
  logo_on_light,
  logotype_on_light,
  back;

  String get path {
    switch (this) {
      case AppImage.amblem_on_dark:
      case AppImage.logo_on_dark:
      case AppImage.logotype_on_dark:
        return 'assets/logo/on_dark/${name.split("_on_")[0]}.png';
      case AppImage.amblem_on_light:
      case AppImage.logo_on_light:
      case AppImage.logotype_on_light:
        return 'assets/logo/on_light/${name.split("_on_")[0]}.png';
      default:
        return 'assets/image/$name.png';
    }
  }

  static List<AppImage> get valuesList => AppImage.values;
}
