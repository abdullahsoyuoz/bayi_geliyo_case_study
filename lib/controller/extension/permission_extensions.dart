enum AppPermissions { notification, location, gallery, camera, microphone }

extension PermissionExtensions on AppPermissions {
  bool isNotification() => this == AppPermissions.notification;
  bool isLocation() => this == AppPermissions.location;
  bool isGallery() => this == AppPermissions.gallery;
  bool isCamera() => this == AppPermissions.camera;
  bool isMicrophone() => this == AppPermissions.microphone;
}

/* class PermissionModelBase {
  late String title;
  late String image;
  PermissionModelBase(this.title, this.image);
}

List<PermissionModelBase> permissions = [
  PermissionModelBase(AppPermissions.notification.name, AppAnimation.bell),
  PermissionModelBase(AppPermissions.location.name, AppAnimation.compass),
  PermissionModelBase(AppPermissions.gallery.name, AppAnimation.aperture),
  PermissionModelBase(AppPermissions.camera.name, AppAnimation.aperture),
  PermissionModelBase(AppPermissions.microphone.name, AppAnimation.aperture),
];
 */