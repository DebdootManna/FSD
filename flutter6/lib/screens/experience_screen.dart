
import 'package:flutter/material.dart';
import 'package:flutter6/models/resume_data.dart';

class ExperienceScreen extends StatefulWidget {
  final ResumeData resumeData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const ExperienceScreen(
      {super.key,
      required this.resumeData,
      required this.onNext,
      required this.onBack});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
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
                controller: _companyController,
                decoration: const InputDecoration(labelText: 'Company'),
              ),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
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
                    widget.resumeData.experience.add(Experience(
                      company: _companyController.text,
                      position: _positionController.text,
                      startYear: _startYearController.text,
                      endYear: _endYearController.text,
                    ));
                    _companyController.clear();
                    _positionController.clear();
                    _startYearController.clear();
                    _endYearController.clear();
                    setState(() {});
                  }
                },
                child: const Text('Add Experience'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.resumeData.experience.length,
                  itemBuilder: (context, index) {
                    final exp = widget.resumeData.experience[index];
                    return ListTile(
                      title: Text(exp.company),
                      subtitle: Text(exp.position),
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
