import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/shared/widgets/logo.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      // color: Colors.red,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          Logo(),
          SizedBox(height: 50),
          
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xff092044),
          Color(0xff092042),
        ],
      ),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
