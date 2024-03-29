import 'package:flare_flutter/base/animation/actor_animation.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as Http;

/// ------------------------------------------------------------------------
/// Rive动画开屏
/// ------------------------------------------------------------------------
class RiveSplashScreen extends StatefulWidget {
  final Function onSuccess;
  final String imageUrl;
  final Color? color;
  final String animationName;
  final int duration;
  final Color backgroundColor;
  final BoxFit boxFit;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;

  const RiveSplashScreen({
    Key? key,
    required this.onSuccess,
    required this.imageUrl,
    required this.animationName,
    this.color,
    this.duration = 1000,
    this.backgroundColor = Colors.white,
    this.boxFit = BoxFit.contain,
    this.paddingTop = 0.0,
    this.paddingBottom = 0.0,
    this.paddingLeft = 0.0,
    this.paddingRight = 0.0,
  }) : super(key: key);

  @override
  State<RiveSplashScreen> createState() => _RiveSplashScreenState();
}

class _RiveSplashScreenState extends State<RiveSplashScreen> {
  Artboard? _riveArtBoard;
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then((_) async {
      if (mounted) {
        var data;
        if (widget.imageUrl.startsWith('http')) {
          var readBytes = await Http.readBytes(Uri.parse(widget.imageUrl));
          data = ByteData.sublistView(readBytes);
        } else {
          data = await rootBundle.load(widget.imageUrl);
        }
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation(widget.animationName));
        setState(() {
          _riveArtBoard = artboard;
        });
        _controller?.isActiveChanged.addListener(() {
          if (!(_controller?.isActive ?? true)) {
            Future.delayed(Duration(milliseconds: widget.duration))
                .then((value) => widget.onSuccess());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: widget.backgroundColor,
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
        left: widget.paddingLeft,
        right: widget.paddingRight,
      ),
      child: Center(
        child: _riveArtBoard == null
            ? const SizedBox()
            : Rive(
                artboard: _riveArtBoard!,
                fit: widget.boxFit,
              ),
      ),
    );
  }
}

/// ------------------------------------------------------------------------
/// Lottie动画开屏
/// ------------------------------------------------------------------------
///
class LottieSplashScreen extends StatefulWidget {
  final String imageUrl;
  final int duration;
  final Function? onSuccess;
  final Color backgroundColor;
  final BoxFit boxFit;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;

  const LottieSplashScreen({
    required this.imageUrl,
    this.duration = 1000,
    this.onSuccess,
    this.backgroundColor = Colors.white,
    this.boxFit = BoxFit.contain,
    this.paddingTop = 0.0,
    this.paddingBottom = 0.0,
    this.paddingLeft = 0.0,
    this.paddingRight = 0.0,
  });

  @override
  State<LottieSplashScreen> createState() => _StateLottieSplashScreen();
}

class _StateLottieSplashScreen extends State<LottieSplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) {
        Future.delayed(Duration(milliseconds: widget.duration), () {
          widget.onSuccess?.call();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: widget.backgroundColor,
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
        left: widget.paddingLeft,
        right: widget.paddingRight,
      ),
      child: Center(
        child: widget.imageUrl.startsWith('http')
            ? Lottie.network(
                widget.imageUrl,
                errorBuilder: (_, __, ___) {
                  return const SizedBox();
                },
                fit: widget.boxFit,
              )
            : Lottie.asset(
                widget.imageUrl,
                fit: widget.boxFit,
                errorBuilder: (_, __, ___) {
                  return const SizedBox();
                },
              ),
      ),
    );
  }
}

/// ------------------------------------------------------------------------
/// Flare动画开屏
/// ------------------------------------------------------------------------
class FlareSplashScreen extends StatelessWidget {
  final String? name;
  final Function? next;
  final Function(dynamic data)? onSuccess;
  final Function(dynamic error, dynamic stacktrace)? onError;
  final double? width;
  final double? height;
  final Alignment alignment;
  final Future<void> Function()? until;
  final String? loopAnimation;
  final String? endAnimation;
  final String? startAnimation;
  final RouteTransitionsBuilder? transitionsBuilder;
  final bool? isLoading;
  final Color backgroundColor;
  final BoxFit boxFit;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;

  factory FlareSplashScreen.callback({
    required String name,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error, dynamic stacktrace) onError,
    Key? key,
    Future Function()? until,
    bool? isLoading,
    String? loopAnimation,
    Alignment alignment = Alignment.center,
    double? width,
    double? height,
    String? endAnimation,
    RouteTransitionsBuilder? transitionsBuilder,
    String? startAnimation,
    BoxFit boxFit = BoxFit.contain,
    Color backgroundColor = Colors.white,
    double paddingTop = 0.0,
    double paddingBottom = 0.0,
    double paddingLeft = 0.0,
    double paddingRight = 0.0,
  }) {
    return FlareSplashScreen(
      name,
      null,
      until: until,
      loopAnimation: loopAnimation,
      startAnimation: startAnimation,
      isLoading: isLoading,
      endAnimation: endAnimation,
      width: width,
      height: height,
      transitionsBuilder: transitionsBuilder,
      onSuccess: onSuccess,
      onError: onError,
      alignment: alignment,
      backgroundColor: backgroundColor,
      boxFit: boxFit,
      paddingTop: paddingTop,
      paddingBottom: paddingBottom,
      paddingLeft: paddingLeft,
      paddingRight: paddingRight,
    );
  }

  factory FlareSplashScreen.navigate({
    required String? name,
    required Function next,
    Key? key,
    bool? isLoading,
    Future Function()? until,
    String? loopAnimation,
    Alignment alignment = Alignment.center,
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
    String? endAnimation,
    RouteTransitionsBuilder? transitionsBuilder,
    String? startAnimation,
    BoxFit boxFit = BoxFit.contain,
    Color backgroundColor = Colors.white,
    double paddingTop = 0.0,
    double paddingBottom = 0.0,
    double paddingLeft = 0.0,
    double paddingRight = 0.0,
  }) {
    return FlareSplashScreen(
      name,
      next,
      until: until,
      isLoading: isLoading,
      loopAnimation: loopAnimation,
      startAnimation: startAnimation,
      endAnimation: endAnimation,
      width: width,
      height: height,
      transitionsBuilder: transitionsBuilder,
      onSuccess: (_) {},
      onError: (_, __) {},
      alignment: alignment,
      backgroundColor: backgroundColor,
      boxFit: boxFit,
      paddingTop: paddingTop,
      paddingBottom: paddingBottom,
      paddingLeft: paddingLeft,
      paddingRight: paddingRight,
    );
  }

  const FlareSplashScreen(
      this.name,
      this.next, {
        this.loopAnimation,
        Key? key,
        this.isLoading,
        this.until,
        this.alignment = Alignment.center,
        this.width,
        this.height,
        this.transitionsBuilder,
        this.endAnimation,
        this.startAnimation,
        this.onSuccess,
        this.onError,
        this.backgroundColor = Colors.white,
        this.boxFit = BoxFit.contain,
        this.paddingTop = 0.0,
        this.paddingBottom = 0.0,
        this.paddingLeft = 0.0,
        this.paddingRight = 0.0,
      })  : assert(!(isLoading != null && until != null),
  'isLoading and until are exclusive, pick one ;)'),
        assert(!(isLoading == null && until == null),
        'isLoading and until are null, pick one ;)'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: FlareLoading(
        endAnimation: endAnimation,
        startAnimation: startAnimation,
        loopAnimation: loopAnimation,
        width: width,
        height: height,
        fit: boxFit,
        onSuccess: (data) {
          _goToNext(context, data);
        },
        onError: onError!,
        name: name!,
        alignment: alignment,
        until: until,
        isLoading: isLoading,
      ),
    );
  }

  void _goToNext(BuildContext context, data) {
    if (next == null) {
      onSuccess!(data);
    } else {
      next!();
    }
  }
}

class FlareLoading extends StatefulWidget {
  final String name;
  final Function(dynamic data) onSuccess;
  final Function(dynamic error, dynamic stacktrace) onError;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final Future Function()? until;
  final String? loopAnimation;
  final String? endAnimation;
  final String? startAnimation;
  final bool? isLoading;

  const FlareLoading({
    Key? key,
    required this.name,
    required this.onSuccess,
    required this.onError,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.until,
    this.loopAnimation,
    this.endAnimation,
    this.startAnimation,
    this.isLoading,
  }) : super(key: key);

  @override
  FlareLoadingState createState() => FlareLoadingState();
}

class FlareLoadingState extends State<FlareLoading> with FlareController {
  ActorAnimation? _start, _loading, _complete;
  double _animationTime = 0.0;
  dynamic _data; //save data from the future for the callback
  dynamic _error; //save error from the future for the callback
  dynamic _stack; //save stack from the future for the callback
  bool _isLoading = true; //bool to know if we're still processing
  bool _isSuccessful = false; //bool to know if the until future is successful
  bool _isCompleted = false; //bool to know if endAnimation is finished
  bool _isIntroFinished = false; //bool to know if startAnimation is finished

  @override
  void initState() {
    _isLoading = widget.isLoading ?? true;
    _processCallback();
    super.initState();
  }

  @override
  void didUpdateWidget(FlareLoading oldWidget) {
    if (widget.isLoading != null && widget.isLoading != oldWidget.isLoading) {
      setState(() {
        _isLoading = widget.isLoading!;
        if (_isLoading) {
          _isCompleted = false;
          isActive.value = true;
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: FlareActor(
          widget.name,
          controller: this,
          fit: widget.fit,
          callback: (_) => {},
        ),
      ),
    );
  }

  Future _processCallback() async {
    if (widget.until == null) {
      _isSuccessful = true; //based on boolean field we're always sucessful
    } else {
      try {
        _data = await widget.until!();
        _isSuccessful = true;
      } catch (err, stack) {
        _error = err;
        _stack = stack;
        _isSuccessful = false;
      }
      setState(() {
        _isLoading = false;
      });
      if (_loading == null && _complete == null && _isIntroFinished ||
          _isCompleted) {
        _finished();
      }
    }
  }

  void _finished() {
    if (!_isLoading) {
      WidgetsBinding.instance.endOfFrame.then((_) {
        if (mounted) {
          if (_isSuccessful) {
            widget.onSuccess(_data);
          } else {
            widget.onError(_error, _stack);
          }
        }
      });
    }
  }

  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _animationTime += elapsed;

    if (!_isIntroFinished && _start != null) {
      if (_animationTime < _start!.duration) {
        // finish start animation
        _start!.apply(_animationTime, artboard, 1.0);
        return true;
      } else {
        //start animation finished
        _isIntroFinished = true;
        if (_loading == null && _complete == null) {
          _isLoading = false;
          _finished();
          return false; // if there another animation to continue to return false
        }
      }
    }

    if (_isLoading && _loading != null) {
      // Still loading...
      _animationTime %= _loading!.duration;
      _loading!.apply(_animationTime, artboard, 1.0);
    } else if (_loading != null && _animationTime < _loading!.duration) {
      // Complete, but need to finish loading animation...
      _loading!.apply(_animationTime, artboard, 1.0);
    } else if (_complete == null) {
      _isLoading = false;
      _finished();
      return false;
    } else if (!_isCompleted) {
      // Chain completion animation
      var completeTime = _animationTime - (_loading ?? _start)!.duration;
      _complete!.apply(completeTime, artboard, 1.0);
      if (completeTime >= _complete!.duration) {
        // Notify we're done and stop advancing.
        _isCompleted = true;
        _isLoading = false;
        _finished();
        return false;
      }
    }
    return true;
  }

  void initialize(FlutterActorArtboard artboard) {
    if (widget.startAnimation != null) {
      _start = artboard.getAnimation(widget.startAnimation!);
    }
    if (widget.loopAnimation != null) {
      _loading = artboard.getAnimation(widget.loopAnimation!);
    }
    if (widget.endAnimation != null) {
      _complete = artboard.getAnimation(widget.endAnimation!);
    }
  }

  void setViewTransform(viewTransform) {
    //nothing to do
  }
}

