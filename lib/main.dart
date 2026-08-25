import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const UberStyleSplashDemo());
}

class UberStyleSplashDemo extends StatelessWidget {
  const UberStyleSplashDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _loaderController;
  late AnimationController _fadeController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _fadeOpacity;

  @override
  void initState() {
    super.initState();


    // LOGO APPEAR ANIMATION


    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoScale = Tween<double>(
      begin: 0.65,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutCubic,
      ),
    );

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeInOut,
      ),
    );


    // LOADING RING


    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _loaderController.repeat();


    // OVERALL FADE


    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeOpacity = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    // Start animations
    _logoController.forward();
    _fadeController.forward();


    // KEEP SPLASH FOR 10 SECONDS
    // CLOSE APP AFTER 10 SECONDS

    Future.delayed(
      const Duration(seconds: 10),
          () {
        if (!mounted) return;

        _loaderController.stop();

        SystemNavigator.pop();
      },
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _loaderController.dispose();
    _fadeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: AnimatedBuilder(
        animation: _fadeOpacity,

        builder: (context, child) {
          return Opacity(
            opacity: _fadeOpacity.value,
            child: child,
          );
        },

        child: Stack(
          children: [

            // CENTER LOGO

            Center(
              child: AnimatedBuilder(
                animation: _logoController,

                builder: (context, child) {
                  return Opacity(
                    opacity: _logoOpacity.value,

                    child: Transform.scale(
                      scale: _logoScale.value,

                      child: const Text('ANDROID APPLICATION',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -1.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),


            // SMALL LOADING RING

            Positioned(
              left: 0,
              right: 0,
              bottom: 140,

              child: Center(
                child: AnimatedBuilder(
                  animation: _loaderController,

                  builder: (context, child) {
                    return CustomPaint(
                      size: const Size(32, 32),

                      painter: LoaderPainter(
                        progress: _loaderController.value,
                      ),
                    );
                  },
                ),
              ),
            ),


            // BOTTOM LABEL

            const Positioned(
              left: 0,
              right: 0,
              bottom: 50,

              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text('POWERED BY FLUTTER',

                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3.0,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text('POWERED BY ANDROID STUDIO',

                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3.0,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text('BUILT WITH DART',
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// LOADING RING ANIMATION

class LoaderPainter extends CustomPainter {
  final double progress;

  LoaderPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width / 2 - 2;


    // BACKGROUND RING


    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(
      center,
      radius,
      backgroundPaint,
    );


    // MOVING WHITE ARC

    final foregroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;

    const sweepAngle = math.pi * 1.35;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      startAngle + (progress * math.pi * 2),
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant LoaderPainter oldDelegate,
      ) {
    return oldDelegate.progress != progress;
  }
}