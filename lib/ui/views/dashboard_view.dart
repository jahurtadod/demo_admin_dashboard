import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class DashboarView extends StatelessWidget {
  const DashboarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Text(
          'Dashboard View',
          style: CustomLabels.h1,
        ),
        const SizedBox(height: 10),
        const WhiteCard(
          title: 'Sakes Statistics',
          child: Text('Hola Mundo'),
        )
      ],
    );
  }
}
