
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter6/models/resume_data.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PreviewScreen extends StatelessWidget {
  final ResumeData resumeData;

  const PreviewScreen({super.key, required this.resumeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveAsPdf(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(resumeData.name, style: Theme.of(context).textTheme.headlineMedium),
            Text(resumeData.email),
            Text(resumeData.phone),
            Text(resumeData.address),
            const SizedBox(height: 20),
            const Text('Education', style: TextStyle(fontWeight: FontWeight.bold)),
            ...resumeData.education.map((e) => ListTile(
              title: Text(e.school),
              subtitle: Text('${e.degree} (${e.startYear} - ${e.endYear})'),
            )),
            const SizedBox(height: 20),
            const Text('Experience', style: TextStyle(fontWeight: FontWeight.bold)),
            ...resumeData.experience.map((e) => ListTile(
              title: Text(e.company),
              subtitle: Text('${e.position} (${e.startYear} - ${e.endYear})'),
            )),
            const SizedBox(height: 20),
            const Text('Skills', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: resumeData.skills.map((s) => Chip(label: Text(s))).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAsPdf(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(resumeData.name, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.Text(resumeData.email),
              pw.Text(resumeData.phone),
              pw.Text(resumeData.address),
              pw.SizedBox(height: 20),
              pw.Text('Education', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ...resumeData.education.map((e) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(e.school, style: const pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('${e.degree} (${e.startYear} - ${e.endYear})'),
                  pw.SizedBox(height: 5),
                ]
              )),
              pw.SizedBox(height: 20),
              pw.Text('Experience', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ...resumeData.experience.map((e) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(e.company, style: const pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('${e.position} (${e.startYear} - ${e.endYear})'),
                  pw.SizedBox(height: 5),
                ]
              )),
              pw.SizedBox(height: 20),
              pw.Text('Skills', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Wrap(
                spacing: 8.0,
                children: resumeData.skills.map((s) => pw.Chip(label: pw.Text(s))).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
