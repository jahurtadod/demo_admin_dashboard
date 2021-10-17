import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class IconsView extends StatelessWidget {
  const IconsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Icons View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: const [
              WhiteCard(
                title: 'ac_unit_outlined',
                child: Center(
                  child: Icon(Icons.ac_unit_outlined),
                ),
                width: 170,
              ),
              WhiteCard(
                title: 'access_alarm_outlined',
                child: Center(
                  child: Icon(Icons.access_alarm_outlined),
                ),
                width: 170,
              ),
              WhiteCard(
                title: 'headphones_battery_outlined',
                child: Center(
                  child: Icon(Icons.headphones_battery_outlined),
                ),
                width: 170,
              ),
              WhiteCard(
                title: 'g_translate_sharp',
                child: Center(
                  child: Icon(Icons.g_translate_sharp),
                ),
                width: 170,
              ),
              WhiteCard(
                title: 'g_translate_sharp',
                child: Center(
                  child: Icon(Icons.g_translate_sharp),
                ),
                width: 170,
              ),
              WhiteCard(
                title: 'add_circle_sharp',
                child: Center(
                  child: Icon(Icons.add_circle_sharp),
                ),
                width: 170,
              )
            ],
          )
        ],
      ),
    );
  }
}
