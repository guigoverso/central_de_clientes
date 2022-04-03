abstract class RouteName {
  static const String home = '/';
  static String contact(int id) => '/contact/$id';
  static String editContact = '/edit';
  static String newContact = '/new_contact';
}