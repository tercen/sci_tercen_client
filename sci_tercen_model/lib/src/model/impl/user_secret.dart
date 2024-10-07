part of sci_model;

class UserSecret extends UserSecretBase {
  static String GOOGLE_CREDENTIALS = 'google.credentials';

  UserSecret() : super();
  UserSecret.json(Map m) : super.json(m);
}
