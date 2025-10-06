
import 'package:flutter/material.dart';
import 'package:flutter6/models/resume_data.dart';

class SkillsScreen extends StatefulWidget {
  final ResumeData resumeData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const SkillsScreen(
      {super.key,
      required this.resumeData,
      required this.onNext,
      required this.onBack});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final _skillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _skillController,
              decoration: const InputDecoration(labelText: 'Skill'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_skillController.text.isNotEmpty) {
                  widget.resumeData.skills.add(_skillController.text);
                  _skillController.clear();
                  setState(() {});
                }
              },
              child: const Text('Add Skill'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.resumeData.skills.length,
                itemBuilder: (context, index) {
                  final skill = widget.resumeData.skills[index];
                  return ListTile(
                    title: Text(skill),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: widget.onBack,
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: widget.onNext,
                  child: const Text('Preview'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
