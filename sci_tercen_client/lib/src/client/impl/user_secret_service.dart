part of sci_client;

class UserSecretService extends UserSecretServiceBase {
  Future<String?> getGoogleAccessToken() async {
    var list =
        await findSecretByUserId(keys: [factory.userService.session!.user.id]);
    if (list.isNotEmpty) {
      try {
        var googleAccessToken =
            await getSecret(list.first.id, UserSecret.GOOGLE_CREDENTIALS);
        if (googleAccessToken.isNotEmpty) {
          return googleAccessToken;
        }
      } on ServiceError catch (e) {
        if (e.error == "google.refresh.token.missing") {
          return null;
        } else {
          rethrow;
        }
      }
    }
    return null;
  }
}
