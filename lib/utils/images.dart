const assetPath = 'assets/images';
String image(String imageName, {String type = 'png'}) {
  return '$assetPath/$imageName.$type';
}

String svgImage(String imageName) {
  return '$assetPath/$imageName';
}

class ImageOf {
  //===================APP ICONS====================
  static String arrowLeft = image('arrow_left');
  //===================APP IMAGES===================
  static String homeIcon = image('home');
  static String messagesIcon = image('messages');
  static String profile = image('profile');
  static String wallet = image('wallet');
  static String copy = image('copy');
  static String close = image('close');
  static String notepad = image('notepad');
  static String emptyTransaction = image('empty_transaction');
  static String walletNeutral = image('wallet_neutral');
}
