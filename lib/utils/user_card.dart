import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final String userName;
  final String consumerId;
  final bool isOnline;
  final bool isPowerOn;
  final Function(bool) onPowerToggle;

  const UserCard({
    Key? key,
    required this.userName,
    required this.consumerId,
    required this.isOnline,
    required this.isPowerOn,
    required this.onPowerToggle,
  }) : super(key: key);

  @override
  UserCardState createState() => UserCardState();
}

class UserCardState extends State<UserCard> {
  bool _powerStatus = false;

  @override
  void initState() {
    super.initState();
    _powerStatus = widget.isPowerOn;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Tooltip(
                  message: widget.isOnline ? 'Online' : 'Offline',
                  child: Icon(
                    widget.isOnline
                        ? Icons.online_prediction
                        : Icons.offline_bolt,
                    color: widget.isOnline ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '# ${widget.consumerId}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  _powerStatus ? Icons.lightbulb : Icons.lightbulb_outlined,
                  color: _powerStatus ? Colors.orange : Colors.grey,
                ),
                const SizedBox(width: 16),
                Transform.scale(
                  scale: 0.6,
                  child: Switch(
                    value: _powerStatus,
                    onChanged: (value) {
                      setState(() {
                        _powerStatus = value;
                        widget.onPowerToggle(value);
                      });
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.grey,
                    trackOutlineColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
