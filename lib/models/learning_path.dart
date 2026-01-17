enum PathNodeStatus {
  locked,
  unlocked,
  inProgress,
  completed,
}

class PathNode {
  final String id;
  final String title;
  final String iconUrl;
  final PathNodeStatus status;
  final int progressPercentage;
  final List<String> dependencies; // IDs of nodes that must be completed first

  PathNode({
    required this.id,
    required this.title,
    required this.iconUrl,
    required this.status,
    this.progressPercentage = 0,
    this.dependencies = const [],
  });

  bool get isLocked => status == PathNodeStatus.locked;
  bool get isCompleted => status == PathNodeStatus.completed;
  bool get isInProgress => status == PathNodeStatus.inProgress;
  bool get isUnlocked => status == PathNodeStatus.unlocked || isInProgress;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'iconUrl': iconUrl,
        'status': status.name,
        'progressPercentage': progressPercentage,
        'dependencies': dependencies,
      };

  factory PathNode.fromJson(Map<String, dynamic> json) => PathNode(
        id: json['id'] as String,
        title: json['title'] as String,
        iconUrl: json['iconUrl'] as String,
        status: PathNodeStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => PathNodeStatus.locked,
        ),
        progressPercentage: json['progressPercentage'] as int? ?? 0,
        dependencies: (json['dependencies'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
      );
}

class LearningPath {
  final List<PathNode> nodes;
  final String title;

  LearningPath({
    required this.nodes,
    this.title = 'Lộ trình học tập',
  });

  int get totalNodes => nodes.length;
  int get completedNodes => nodes.where((n) => n.isCompleted).length;
  double get overallProgress =>
      totalNodes > 0 ? completedNodes / totalNodes : 0.0;

  PathNode? get currentNode =>
      nodes.firstWhere((n) => n.isInProgress, orElse: () => nodes.first);

  Map<String, dynamic> toJson() => {
        'title': title,
        'nodes': nodes.map((n) => n.toJson()).toList(),
      };

  factory LearningPath.fromJson(Map<String, dynamic> json) => LearningPath(
        title: json['title'] as String? ?? 'Lộ trình học tập',
        nodes: (json['nodes'] as List<dynamic>)
            .map((e) => PathNode.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
