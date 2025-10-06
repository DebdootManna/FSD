
import 'package:flutter/material.dart';
import 'package:flutter6/models/resume_data.dart';

class PersonalInfoScreen extends StatelessWidget {
  final ResumeData resumeData;
  final VoidCallback onNext;

  const PersonalInfoScreen(
      {super.key, required this.resumeData, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: resumeData.name,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => resumeData.name = value,
            ),
            TextFormField(
              initialValue: resumeData.email,
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => resumeData.email = value,
            ),
            TextFormField(
              initialValue: resumeData.phone,
              decoration: const InputDecoration(labelText: 'Phone'),
              onChanged: (value) => resumeData.phone = value,
            ),
            TextFormField(
              initialValue: resumeData.address,
              decoration: const InputDecoration(labelText: 'Address'),
              onChanged: (value) => resumeData.address = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNext,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
