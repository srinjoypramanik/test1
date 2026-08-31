import 'package:flutter/material.dart';
import 'homepage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {     // AnimationController needs vsync given by this

  late AnimationController logoController;


  late Animation<double> logoScale;
  late Animation<double> logoOpacity;

  @override
  void initState() {
    super.initState();



// LOGO ANIMATION

    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    );

    logoScale = Tween<double>(
      begin: 0.50,      //Starting size
      end: 1.0,         //Final size
      ).animate(
      CurvedAnimation(
        parent: logoController,
        curve: Curves.easeOutCubic,
      ),
    );

    logoOpacity = Tween<double>(
      begin: 0.0,     //Starting transparency
      end: 1.0,       //Final transparency
    ).animate(
      CurvedAnimation(
        parent: logoController,
        curve: Curves.easeInOut,
      ),
    );




    logoController.forward();




    Future.delayed(
       Duration(seconds: 10),
          () {
        if (!mounted){
          return;}
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );

  }




  @override
  void dispose() {
    logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [

          Center(
            child: AnimatedBuilder(
              animation: logoController,

              builder: (context, child) {
                return Opacity(
                  opacity: logoOpacity.value,

                  child: Transform.scale(
                    scale: logoScale.value,

                    child: Image.asset('assets/images/logo1.jpg',
                          height: 600,
                          width: 600,
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 140,

            child: Center(
              child: SizedBox(
                width: 30,
                height: 30,

                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.white24,
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),

          // BOTTOM LABEL

          Positioned(
            left: 0,
            right: 0,
            bottom: 50,

            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,  //Fix column size vertically

                children: [

                  Text('POWERED BY ANDROID STUDIO',
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.0,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text('DESIGNED BY FLUTTER',
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.0,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text('BUILT WITH DART',
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );


  }
}