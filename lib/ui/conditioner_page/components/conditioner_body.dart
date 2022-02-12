import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_cooling_android/domain/view_model/settings_view_model.dart';
import 'package:remote_cooling_android/entities/conditioner.dart';
import 'package:remote_cooling_android/ui/conditioner_page/components/conditioner_header.dart';

import 'conditioner_footer.dart';
import 'conditioner_mode_switcher.dart';

class ConditionerBody extends StatelessWidget {
  late final bool isLoading;
  late final Conditioner conditioner;
  late final Function setMode;
  late final Function setOnOff;

  ConditionerBody({
    required this.isLoading,
    required this.conditioner,
    required this.setMode,
    required this.setOnOff,
  });

  @override
  Widget build(BuildContext context) {
    bool isDeveloper =
        Provider.of<SettingsViewModel>(context, listen: false).isDeveloper;
    return Column(
        children: [
                ConditionerHeader(
                    conditioner: conditioner,
                    isLoading: isLoading),
                Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                ConditionerModeSwitcher(
                    conditioner: conditioner,
                    onSetMode: setMode,
                    onSwitchPower: setOnOff,
                    isLoading: isLoading,
                ),
                Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                Spacer(),
                ConditionerFooter(
                    conditioner: conditioner,
                    isDeveloper: isDeveloper,
                    isLoading: isLoading,
                )
              ]);
  }
}
