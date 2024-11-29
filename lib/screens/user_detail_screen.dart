import 'package:flutter/material.dart';
import '../models/user_model.dart';

import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Name', user.name),
            _buildDetailRow('Email', user.email),
            _buildDetailRow('Phone', user.phone),
            _buildDetailRow('Website', user.website),
             SizedBox(height: 16),
            _buildSectionHeader('Address'),
            _buildAddress(user.address),
             SizedBox(height: 16),
            _buildSectionHeader('Company'),
            _buildCompany(user.company),
             SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAddress(Address address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${address.suite}, ${address.street}', style: const TextStyle(fontSize: 16)),
        Text('${address.city}, ${address.zipcode}', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildCompany(Company company) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(company.name, style: const TextStyle(fontSize: 16)),
        Text(company.catchPhrase, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

