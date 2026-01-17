import 'package:flutter/material.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Bạn Bè'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Bạn Bè', icon: Icon(Icons.people)),
            Tab(text: 'Yêu Cầu', icon: Icon(Icons.person_add)),
            Tab(text: 'Tìm Kiếm', icon: Icon(Icons.search)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFriendsTab(),
          _buildRequestsTab(),
          _buildSearchTab(),
        ],
      ),
    );
  }

  // Tab 1: Friends List
  Widget _buildFriendsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5, // Placeholder
      itemBuilder: (context, index) {
        return _buildFriendCard(
          name: 'Người dùng ${index + 1}',
          level: 5 + index,
          lastActive: '2 giờ trước',
          avatarUrl: null,
        );
      },
    );
  }

  // Tab 2: Friend Requests
  Widget _buildRequestsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3, // Placeholder
      itemBuilder: (context, index) {
        return _buildRequestCard(
          name: 'Người dùng ${index + 1}',
          level: 3 + index,
          mutualFriends: index * 2,
        );
      },
    );
  }

  // Tab 3: Search Users
  Widget _buildSearchTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm bạn bè...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 8, // Placeholder
            itemBuilder: (context, index) {
              return _buildSearchResultCard(
                name: 'Người dùng ${index + 1}',
                level: 2 + index,
                isFriend: index % 3 == 0,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFriendCard({
    required String name,
    required int level,
    required String lastActive,
    String? avatarUrl,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            name[0],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Level $level • $lastActive'),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.person, size: 20),
                  SizedBox(width: 8),
                  Text('Xem hồ sơ'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'remove',
              child: Row(
                children: [
                  Icon(Icons.person_remove, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Xóa bạn', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard({
    required String name,
    required int level,
    required int mutualFriends,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                name[0],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level $level • $mutualFriends bạn chung',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Accept friend request
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã chấp nhận lời mời kết bạn từ $name')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('Chấp nhận', style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(height: 4),
                OutlinedButton(
                  onPressed: () {
                    // Reject friend request
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã từ chối lời mời kết bạn từ $name')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(80, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('Từ chối', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultCard({
    required String name,
    required int level,
    required bool isFriend,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            name[0],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Level $level'),
        trailing: isFriend
            ? const Chip(
                label: Text('Bạn bè', style: TextStyle(fontSize: 12)),
                backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white),
              )
            : ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã gửi lời mời kết bạn đến $name')),
                  );
                },
                icon: const Icon(Icons.person_add, size: 16),
                label: const Text('Kết bạn', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 32),
                ),
              ),
      ),
    );
  }
}
