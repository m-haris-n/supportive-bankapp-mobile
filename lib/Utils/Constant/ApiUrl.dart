class ApiUrl {
  // static const String apiBaseUrl = "https://supportive-bankapp-backend.vercel.app/api/";
  static const String apiBaseUrl = "http://10.61.138.100:3000/api/";
  // static const String apiBaseUrl = "https://bank-app-backend-pi.vercel.app/api/";
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String userMe = "user/me";
  static const String updateProfile = "user/update_profile";
  static const String changePassword = "user/change_password";
  static const String logout = "logout";
  static const String plaidLinkToken = "plaid/link_token";
  static const String plaidAccessToken = "plaid/access_token";
  static const String getAllChat = "chat/all";
  static const String getChatById = "chat/get";
  static const String createChat = "chat/create";
  static const String sendMessage = "chat/message";
  static const String deleteChat = "chat/delete";
  static const String pinChat = "chat/pin";
  static const String unpinChat = "chat/unpin";
}
