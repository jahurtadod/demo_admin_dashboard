import 'package:flutter/material.dart';

import 'package:admin_dashboard/models/user.dart';
import 'package:admin_dashboard/services/navigation_service.dart';

class UsersDataSource extends DataTableSource {
  final List<Usuario> users;

  UsersDataSource(this.users);

  @override
  DataRow getRow(int index) {
    final user = users[index];

    final image = (user.img == null)
        ? const Image(
            image: AssetImage('assets/no-image.jpg'),
            width: 35,
            height: 35,
          )
        : FadeInImage.assetNetwork(
            placeholder: 'assets/loader.gif',
            image: user.img!,
            width: 35,
            height: 35,
          );

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(ClipOval(
          child: image,
        )),
        DataCell(Text(user.nombre)),
        DataCell(Text(user.correo)),
        DataCell(Text(user.uid)),
        DataCell(
          IconButton(
            onPressed: () {
              NavigationService.naviageTo('/dashboard/users/${user.uid}');
            },
            icon: Icon(Icons.edit_outlined),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
