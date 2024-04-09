import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_api_prueba_pragma_jeant/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPreviewresponse extends StatefulWidget {
  final String labelName;
  final String labelCountry;
  final String img;
  final String inteligent;
  final String adaptabilidad;
  final String descripcion;

  const CardPreviewresponse({
    Key? key,
    required this.labelName,
    required this.labelCountry,
    required this.inteligent,
    required this.img,
    required this.adaptabilidad,
    required this.descripcion,
  }) : super(key: key);

  @override
  _CardPreviewresponseState createState() => _CardPreviewresponseState();
}

class _CardPreviewresponseState extends State<CardPreviewresponse> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    inteligence: widget.inteligent,
                    adaptabilidad: widget.adaptabilidad,
                    description: widget.descripcion,
                    img: widget.img,
                    labelCountry: widget.labelCountry,
                    labelName: widget.labelName,
                  )),
        );
      },
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.labelName,
                  style: GoogleFonts.alike(
                    fontWeight: FontWeight.bold,
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  inteligence: widget.inteligent,
                                  adaptabilidad: widget.adaptabilidad,
                                  description: widget.descripcion,
                                  img: widget.img,
                                  labelCountry: widget.labelCountry,
                                  labelName: widget.labelName,
                                )),
                      );
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black, // Color de la línea
                            width: 1.0, // Ancho de la línea
                          ),
                        ),
                      ),
                      child: Text(
                        'More...',
                        style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ))
              ],
            ),
            widget.img.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.img,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/path.jpg'),
                  )
                //Image.network(widget.img)
                : Image.asset('assets/path.jpg'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.labelCountry,
                  style: GoogleFonts.alike(
                    fontWeight: FontWeight.bold,
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  widget.inteligent,
                  style: GoogleFonts.alike(
                    fontWeight: FontWeight.bold,
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
