import 'package:flutter/material.dart';
import 'package:pemo/core/localStorageManager/local_storage_manager.dart';

import '../../../../core/baseRepo/bearer_token_repo.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // List of users
  final List<User> users = [
    User(id: 'user1', name: 'User 1'),
    User(id: 'user2', name: 'User 2'),
  ];

  // Currently selected user ID
  String? selectedUserId;

  @override
  void initState() {
    selectedUserId = BearerTokenRepo.getBearerToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Switch User',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(user.name[
                            0]), // Display the first letter of the user's name
                      ),
                      title: Text(user.name),
                      trailing: Switch(
                        value: selectedUserId == user.id,
                        onChanged: (value) {
                          setState(() {
                            selectedUserId = user.id;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Set button color
                foregroundColor: Colors.white, // Set text color
              ),
              onPressed: () async {
                if (selectedUserId != null) {
                  // Save the selected user (you can add your logic here)
                  final selectedUser =
                      users.firstWhere((user) => user.id == selectedUserId);
                  await LocalStorageManager.clearAll();
                  await BearerTokenRepo.setBearerToken(selectedUser.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Selected User: ${selectedUser.name}')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a user')),
                  );
                }
              },
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: Center(
                      child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ))),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});
}
