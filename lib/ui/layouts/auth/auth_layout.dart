import 'package:admin_dashboard/ui/layouts/auth/widgets/background_twitter.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/custom_title.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/links_bar.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Desktop
          _DesktopBody(child: child),
          //Mobile

          //LinksBar
          const LinksBar(),
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.95,
      color: Colors.red,
      child: Row(children: [
        // Twitter Background
        const BackgroundTwitter(),
        // View COntainer
        Container(
          width: 600,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CustomTitle(),
              const SizedBox(height: 50),
              Expanded(child: child),
            ],
          ),
        ),
      ]),
    );
  }
}
