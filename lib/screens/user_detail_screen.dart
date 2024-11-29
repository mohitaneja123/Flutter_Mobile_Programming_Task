import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
            Text('Phone: ${user.phone}', style: TextStyle(fontSize: 18)),
            Text('Website: ${user.website}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Address:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('${user.address.suite}, ${user.address.street}', style: TextStyle(fontSize: 16)),
            Text('${user.address.city}, ${user.address.zipcode}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Company:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('${user.company.name}', style: TextStyle(fontSize: 16)),
            Text('${user.company.catchPhrase}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
