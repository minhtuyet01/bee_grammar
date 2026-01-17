import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../data/service_locator.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng xếp hạng'),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tuần này'),
            Tab(text: 'Tháng này'),
            Tab(text: 'Tất cả'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLeaderboardList('week'),
          _buildLeaderboardList('month'),
          _buildLeaderboardList('all'),
        ],
      ),
    );
  }

  Widget _buildLeaderboardList(String period) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ServiceLocator().firebaseSocialService.streamLeaderboard(limit: 50),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final leaderboardData = snapshot.data ?? [];
        final currentUserId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
        
        // Mark current user
        for (var user in leaderboardData) {
          user['isCurrentUser'] = user['userId'] == currentUserId;
        }

        return Column(
          children: [
            // Trophy Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTrophyIcon('🏆', Colors.amber, true),
                  _buildTrophyIcon('🏆', Colors.blue, true),
                  _buildTrophyIcon('🏆', Colors.deepOrange, true),
                  _buildTrophyIcon('🔒', Colors.grey.shade400, false),
                  _buildTrophyIcon('🔒', Colors.grey.shade400, false),
                ],
              ),
            ),

            // Leaderboard List
            Expanded(
              child: leaderboardData.isEmpty
                  ? const Center(child: Text('No data yet'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: leaderboardData.length,
                      itemBuilder: (context, index) {
                        final user = leaderboardData[index];
                        final isCurrentUser = user['isCurrentUser'] == true;
                        return _buildLeaderboardItem(
                          rank: user['rank'] ?? (index + 1),
                          name: user['name'] ?? 'Unknown',
                          xp: user['xp'] ?? 0,
                          avatar: user['avatar'] ?? 'U',
                          flag: user['flag'] ?? '',
                          isCurrentUser: isCurrentUser,
                          hasGreenDot: user['hasGreenDot'] ?? false,
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrophyIcon(String emoji, Color color, bool isUnlocked) {
    return Container(
      width: 60,
      height: 70,
      decoration: BoxDecoration(
        color: isUnlocked ? color.withOpacity(0.15) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? color.withOpacity(0.3) : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            emoji,
            style: TextStyle(
              fontSize: 32,
              color: isUnlocked ? null : Colors.grey.shade400,
            ),
          ),
          if (isUnlocked)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 30,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem({
    required int rank,
    required String name,
    required int xp,
    required String avatar,
    required String flag,
    required bool isCurrentUser,
    required bool hasGreenDot,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color rankColor;
    Color rankBgColor;

    if (rank == 1) {
      rankColor = Colors.amber.shade700;
      rankBgColor = Colors.amber.shade100;
    } else if (rank == 2) {
      rankColor = Colors.grey.shade600;
      rankBgColor = Colors.grey.shade200;
    } else if (rank == 3) {
      rankColor = Colors.deepOrange.shade700;
      rankBgColor = Colors.deepOrange.shade100;
    } else {
      rankColor = Colors.green.shade700;
      rankBgColor = Colors.green.shade100;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
            : (isDark ? Colors.grey.shade800 : Colors.grey.shade50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentUser
              ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
              : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: rankBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$rank',
                style: TextStyle(
                  color: rankColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Avatar with flag
          Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getAvatarColor(rank),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    avatar,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              if (hasGreenDot)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Name
          Expanded(
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : null,
                  ),
                ),
                if (isCurrentUser) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'You',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // PNT
          Text(
            '$xp PNT',
            style: TextStyle(
              color: Colors.orange.shade700,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getAvatarColor(int rank) {
    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.purple,
      Colors.purple,
      Colors.blue,
      Colors.orange,
      Colors.blue,
    ];
    return colors[(rank - 1) % colors.length];
  }

  // Removed mock data - now using Firebase realtime data
}
