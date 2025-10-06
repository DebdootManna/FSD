import 'package:flutter/material.dart';
import 'package:flutter6/models/resume_data.dart';

class EducationScreen extends StatefulWidget {
  final ResumeData resumeData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const EducationScreen(
      {super.key,
      required this.resumeData,
      required this.onNext,
      required this.onBack});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _schoolController = TextEditingController();
  final _degreeController = TextEditingController();
  final _startYearController = TextEditingController();
  final _endYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _schoolController,
                decoration: const InputDecoration(labelText: 'School'),
              ),
              TextFormField(
                controller: _degreeController,
                decoration: const InputDecoration(labelText: 'Degree'),
              ),
              TextFormField(
                controller: _startYearController,
                decoration: const InputDecoration(labelText: 'Start Year'),
              ),
              TextFormField(
                controller: _endYearController,
                decoration: const InputDecoration(labelText: 'End Year'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.resumeData.education.add(Education(
                      school: _schoolController.text,
                      degree: _degreeController.text,
                      startYear: _startYearController.text,
                      endYear: _endYearController.text,
                    ));
                    _schoolController.clear();
                    _degreeController.clear();
                    _startYearController.clear();
                    _endYearController.clear();
                    setState(() {});
                  }
                },
                child: const Text('Add Education'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.resumeData.education.length,
                  itemBuilder: (context, index) {
                    final edu = widget.resumeData.education[index];
                    return ListTile(
                      title: Text(edu.school),
                      subtitle: Text(edu.degree),
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
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}