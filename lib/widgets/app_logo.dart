import 'package:flutter/material.dart';

/// Logo personnalisé de l'application Cuisine Ivoirienne
/// Dégradé aux couleurs du drapeau ivoirien : orange → blanc → vert
class AppLogo extends StatelessWidget {
  final double size;
  final bool showLabel;

  const AppLogo({super.key, this.size = 36, this.showLabel = false});

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF77F00), // Orange ivoirien
            Color(0xFFFFB347), // Ambre chaud
            Color(0xFF4CAF73), // Vert doux
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF77F00).withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.soup_kitchen_rounded,
          color: Colors.white,
          size: size * 0.55,
          shadows: const [
            Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 1)),
          ],
        ),
      ),
    );

    if (!showLabel) return logo;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logo,
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cuisine',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFFF77F00),
                height: 1.0,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              'Ivoirienne',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D7D46),
                height: 1.1,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
