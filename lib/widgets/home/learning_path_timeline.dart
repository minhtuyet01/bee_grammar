import 'package:flutter/material.dart';
import '../../models/learning_path.dart';

class LearningPathTimeline extends StatelessWidget {
  final LearningPath path;
  final Function(PathNode)? onNodeTap;

  const LearningPathTimeline({
    super.key,
    required this.path,
    this.onNodeTap,
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
                path.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '${path.completedNodes}/${path.totalNodes}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: path.nodes.length,
            itemBuilder: (context, index) {
              final node = path.nodes[index];
              final isLast = index == path.nodes.length - 1;
              
              return Row(
                children: [
                  _PathNodeWidget(
                    node: node,
                    onTap: () => onNodeTap?.call(node),
                  ),
                  if (!isLast)
                    Container(
                      width: 40,
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 40),
                      color: node.isCompleted
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300],
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PathNodeWidget extends StatelessWidget {
  final PathNode node;
  final VoidCallback? onTap;

  const _PathNodeWidget({
    required this.node,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (node.isCompleted) return Colors.green;
      if (node.isInProgress) return Theme.of(context).colorScheme.primary;
      if (node.isUnlocked) return Colors.orange;
      return Colors.grey;
    }

    return GestureDetector(
      onTap: node.isLocked ? null : onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: getColor().withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: getColor(),
                    width: 3,
                  ),
                ),
                child: Center(
                  child: node.isLocked
                      ? Icon(Icons.lock, color: getColor(), size: 28)
                      : Text(
                          node.iconUrl,
                          style: const TextStyle(fontSize: 32),
                        ),
                ),
              ),
              if (node.isCompleted)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                ),
              if (node.isInProgress)
                Positioned(
                  bottom: -8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${node.progressPercentage}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 70,
            child: Text(
              node.title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: node.isLocked ? Colors.grey : Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
