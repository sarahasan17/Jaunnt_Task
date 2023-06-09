class SignupResponse {
  final String? message;
  final Token? token;

  SignupResponse({
    this.message,
    this.token,
  });

  SignupResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        token = (json['token'] as Map<String, dynamic>?) != null
            ? Token.fromJson(json['token'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'message': message, 'token': token?.toJson()};
}

class Token {
  final String? accessToken;
  final RefreshToken? refreshToken;

  Token({
    this.accessToken,
    this.refreshToken,
  });

  Token.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'] as String?,
        refreshToken = (json['refreshToken'] as Map<String, dynamic>?) != null
            ? RefreshToken.fromJson(
                json['refreshToken'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'accessToken': accessToken, 'refreshToken': refreshToken?.toJson()};
}

class RefreshToken {
  final String? token;
  final String? user;
  final String? expiryDate;
  final String? id;

  RefreshToken({
    this.token,
    this.user,
    this.expiryDate,
    this.id,
  });

  RefreshToken.fromJson(Map<String, dynamic> json)
      : token = json['token'] as String?,
        user = json['user'] as String?,
        expiryDate = json['expiryDate'] as String?,
        id = json['_id'] as String?;

  Map<String, dynamic> toJson() =>
      {'token': token, 'user': user, 'expiryDate': expiryDate, '_id': id};
}
