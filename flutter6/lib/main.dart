import 'package:flutter/material.dart';
import 'package:flutter6/models/resume_data.dart';
import 'package:flutter6/screens/education_screen.dart';
import 'package:flutter6/screens/experience_screen.dart';
import 'package:flutter6/screens/personal_info_screen.dart';
import 'package:flutter6/screens/preview_screen.dart';
import 'package:flutter6/screens/skills_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Maker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ResumeForm(),
    );
  }
}

class ResumeForm extends StatefulWidget {
  const ResumeForm({super.key});

  @override
  State<ResumeForm> createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  final PageController _pageController = PageController();
  final ResumeData _resumeData = ResumeData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Maker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewScreen(resumeData: _resumeData),
                ),
              );
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PersonalInfoScreen(
            resumeData: _resumeData,
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          ),
          EducationScreen(
            resumeData: _resumeData,
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
            onBack: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          ),
          ExperienceScreen(
            resumeData: _resumeData,
            onNext: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
            onBack: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          ),
          SkillsScreen(
            resumeData: _resumeData,
            onNext: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviewScreen(resumeData: _resumeData),
                ),
              );
            },
            onBack: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          ),
        ],
      ),
    );
  }
}