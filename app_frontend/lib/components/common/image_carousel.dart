import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const double carouselAspectRatio = 16 / 9;
const double carouselViewPortFraction = 1;
const double paginationDotRadius = 3.5;

// TODO: Image still loading case
// TODO: What happens if image aspect ratio is not 16/9
// TODO: Textbox with eliipsis is not occupying full width
class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key, required this.images, required this.bottomInfoWidget});

  final List<String> images;
  final Widget bottomInfoWidget;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _activePage = 0;
  bool _showBottomInfoWidget = true;

  Widget _getCarouselItem(String image) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(image))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: carouselAspectRatio,
                      viewportFraction: carouselViewPortFraction,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (newPage, reason) {
                        setState(() {
                          _activePage = newPage;
                          _showBottomInfoWidget = (newPage == 0);
                        });
                      },
                    ),
                    items: widget.images.map((i) => _getCarouselItem(i)).toList(),
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: paginationDotRadius),
                      child: AnimatedSmoothIndicator(
                        count: widget.images.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 2 * paginationDotRadius,
                          dotWidth: 2 * paginationDotRadius,
                          spacing: paginationDotRadius,
                          expansionFactor: 2,
                          dotColor: Colors.white.withOpacity(0.5),
                          activeDotColor: Colors.white.withOpacity(0.9),
                        ),
                        activeIndex: _activePage,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            child: AnimatedOpacity(
              opacity: _showBottomInfoWidget ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: widget.bottomInfoWidget,
            ),
          ),
        ),
      ],
    );
  }
}
