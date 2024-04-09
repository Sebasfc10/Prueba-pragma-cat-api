import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final String labelName;
  final String labelCountry;
  final String img;
  final String description;
  final String inteligence;
  final String adaptabilidad;

  const DetailPage({
    Key? key,
    required this.labelName,
    required this.labelCountry,
    required this.img,
    required this.description,
    required this.inteligence,
    required this.adaptabilidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          labelName,
          style: GoogleFonts.alike(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey.shade200,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: img.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: img,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/path.jpg'),
                    )
                  : Image.asset('assets/path.jpg'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          labelName,
                          style: GoogleFonts.alike(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            fontWeight: FontWeight.bold,
                            textStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Description: $description',
                        style: GoogleFonts.alike(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.normal,
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Country of Origin: $labelCountry',
                        style: GoogleFonts.alike(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Intelligence: $inteligence',
                        style: GoogleFonts.alike(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.normal,
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Adaptability: $adaptabilidad',
                        style: GoogleFonts.alike(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.normal,
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
