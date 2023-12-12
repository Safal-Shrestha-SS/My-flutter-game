import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_game/game/game.dart';
import 'package:my_game/l10n/l10n.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  static Route<void> route() {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const TitlePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child.animate().fadeIn();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.titleAppBarTitle),
      ),
      body: const SafeArea(child: TitleView()),
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: SizedBox(
        width: 250,
        height: 64,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push<void>(GamePage.route());
            // Navigator.of(context).pushReplacement<void, void>(GamePage.route());
          },
          child: Center(child: Text(l10n.titleButtonStart)),
        ),
      ),
    );
  }
}
