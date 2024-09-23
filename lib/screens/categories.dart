import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import your existing home screen

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  // Static list of categories

  final List<String> categories = const [
    'Math',
    'Science',
    'History',
    'Geography',//you can add here any category you need
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a Category',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFF674188),
        centerTitle: true,
        elevation: 8.0,
        shadowColor: Colors.black.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Explore Categories:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF674188),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Pass the selected category to the HomeScreen
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => HomeScreen(category: categories[index]),
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder: (_, anim, __, child) {

                            return SlideTransition(
                              position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                                  .animate(anim),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        gradient: const LinearGradient(
                          colors: [Color(0xFF674188), Color(0xFFA084CA)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.category_rounded,
                              color: Colors.white.withOpacity(0.85),
                              size: 32.0,
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Text(
                                categories[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.4,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
