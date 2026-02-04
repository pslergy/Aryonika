import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PortalCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onClick;
  final Widget? previewContent;

  const PortalCard({
    required this.icon, required this.title, required this.subtitle,
    required this.onClick, this.previewContent
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.withOpacity(0.3),
                Colors.black.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, size: 40, color: Colors.yellow[700]),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.8))),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                ],
              ),
              if (previewContent != null) ...[
                const Divider(height: 32, color: Colors.white24, indent: 16, endIndent: 16),
                previewContent!,
              ]
            ],
          ),
        ),
      ),
    );
  }
}