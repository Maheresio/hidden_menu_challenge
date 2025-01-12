import 'package:flutter/material.dart';
import 'package:hidden_menu_challenge/presentation/controller/menu_provider.dart';

abstract class AppConstants {
  static const List<({String label, IconData icon, ItemStatus itemStatus})>
      itemsList = [
    (
      label: 'Lights',
      icon: Icons.lightbulb_outline,
      itemStatus: ItemStatus.lights
    ),
    (label: 'Aircon', icon: Icons.ac_unit, itemStatus: ItemStatus.aircon),
    (label: 'Heating', icon: Icons.whatshot, itemStatus: ItemStatus.heating),
    (label: 'Speakers', icon: Icons.speaker, itemStatus: ItemStatus.speakers),
    (label: 'Fridge', icon: Icons.crop_square, itemStatus: ItemStatus.fridge),
    (
      label: 'Calendar',
      icon: Icons.calendar_today,
      itemStatus: ItemStatus.calendar
    ),
  ];
}
