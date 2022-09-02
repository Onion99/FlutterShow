class DefaultConfig{
  static Map advanceConfig = {
    'DefaultLanguage': 'en'
  };

  static Map splashScreen = {
    'enable': true,
    'type': 'flare',
    'image': 'assets/images/splashscreen.flr',
    'boxFit': 'contain',
    'backgroundColor': '#ffffff',
    'paddingTop': 0,
    'paddingBottom': 0,
    'paddingLeft': 0,
    'paddingRight': 0,
    'animationName': 'fluxstore',
    'duration': 2000,
  };

  static List onBoardingData = [
    {
      'title': 'Welcome to FluxStore',
      'image': 'assets/images/fogg-delivery-1.png',
      'desc': 'Fluxstore is on the way to serve you. '
    },
    {
      'title': 'Connect Surrounding World',
      'image': 'assets/images/fogg-uploading-1.png',
      'desc':
      'See all things happening around you just by a click in your phone. Fast, convenient and clean.'
    },
    {
      'title': "Let's Get Started",
      'image': 'assets/images/fogg-order-completed.png',
      'desc': "Waiting no more, let's see what we get!"
    }
  ];

  static Map? loadingIcon;
}