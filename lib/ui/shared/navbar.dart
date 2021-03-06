import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/widgets/navbar_avatar.dart';
import 'package:admin_dashboard/ui/shared/widgets/notification_indicator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/shared/widgets/search_text.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (size.width <= 700)
            IconButton(
              onPressed: () => SideMenuProvider.openMenu(),
              icon: const Icon(Icons.menu_outlined),
            ),

          const SizedBox(width: 5),

          // TODO: Hamburger menu
          if (size.width > 400)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: const SearchText(),
            ),

          const Spacer(),

          NotificationInficator(),

          const SizedBox(width: 10),

          NavbarAvatar(),

          const SizedBox(width: 10),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
        )
      ]);
}
