enum AppRoutes{
  auth('/auth'),
  home('/home', path: '/home'),;
  const AppRoutes(this.route, {this.path});
  final String route;
  final String ? path;
}
