import 'package:flutter/material.dart';
import '../../models/friend_activity.dart';

class SocialActivityFeed extends StatelessWidget {
  final List<FriendActivity> activities;
  final VoidCallback? onViewAll;

  const SocialActivityFeed({
    super.key,
    required this.activities,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hoạt động bạn bè',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: const Text('Xem tất cả'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(activity.friendAvatar, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: activity.friendName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' ${activity.description}'),
                    ],
                  ),
                ),
                subtitle: Text(
                  activity.timeAgo,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                trailing: Text(activity.icon, style: const TextStyle(fontSize: 20)),
              ),
            );
          },
        ),
      ],
    );
  }
}
