import 'package:flutter/material.dart';
import '../../models/announcement.dart';

class AnnouncementBanner extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onDismiss;
  final VoidCallback? onTap;

  const AnnouncementBanner({
    super.key,
    required this.announcement,
    this.onDismiss,
    this.onTap,
  });

  Color _getColor() {
    switch (announcement.type) {
      case AnnouncementType.info:
        return Colors.blue;
      case AnnouncementType.update:
        return Colors.green;
      case AnnouncementType.event:
        return Colors.purple;
      case AnnouncementType.warning:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = _getColor();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            baseColor.withOpacity(0.8),
            baseColor.withOpacity(0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: baseColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  announcement.iconUrl,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        announcement.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        announcement.message,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (onDismiss != null)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 20),
                    onPressed: onDismiss,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
