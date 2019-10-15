import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PdfViewer extends StatelessWidget {
  
  PdfViewer({this.file,this.invoiceNo});
  String invoiceNo;
  final File file;

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: const Text('Invoice'),
        ),
        path: file.path);
  }
}