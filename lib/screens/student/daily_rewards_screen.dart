import 'package:flutter/material.dart';
import '../../models/daily_reward.dart';

class DailyRewardsScreen extends StatefulWidget {
  final DailyRewardCalendar calendar;

  const DailyRewardsScreen({
    super.key,
    required this.calendar,
  });

  @override
  State<DailyRewardsScreen> createState() => _DailyRewardsScreenState();
}

class _DailyRewardsScreenState extends State<DailyRewardsScreen> {
  bool _isClaiming = false;

  Future<void> _claimReward() async {
    if (!widget.calendar.canClaimToday) return;

    setState(() => _isClaiming = true);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => _isClaiming = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ Đã nhận ${widget.calendar.todayReward?.displayText}'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phần thưởng hàng ngày'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Streak info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.deepOrange.shade400],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Text(
                        '${widget.calendar.currentStreak}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Chuỗi học',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Rewards calendar
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: widget.calendar.rewards.length,
              itemBuilder: (context, index) {
                final reward = widget.calendar.rewards[index];
                return _RewardDayCard(reward: reward);
              },
            ),
            const SizedBox(height: 24),

            // Claim button
            if (widget.calendar.canClaimToday)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isClaiming ? null : _claimReward,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isClaiming
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Nhận phần thưởng hôm nay',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Bạn đã nhận phần thưởng hôm nay. Quay lại vào ngày mai!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RewardDayCard extends StatelessWidget {
  final DailyReward reward;

  const _RewardDayCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: reward.isClaimed ? Colors.green.withOpacity(0.1) : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: reward.isStreakBonus
              ? Colors.orange
              : reward.isClaimed
                  ? Colors.green
                  : Colors.grey[300]!,
          width: reward.isStreakBonus ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ngày ${reward.day}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            reward.displayText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (reward.isClaimed)
            const Icon(Icons.check_circle, color: Colors.green, size: 16),
        ],
      ),
    );
  }
}
