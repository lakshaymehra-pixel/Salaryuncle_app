import 'package:flutter/material.dart';
import 'package:tejas_loan/utils/color_constants.dart';

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final double min_value;
  final double max_value;

  final int division;
  final fullWidth;
  final currentValue;
  final type;
  final Function(double) onChanged;

  const SliderWidget(
      {this.sliderHeight = 48,
      this.max = 10,
      this.division = 10,
      this.min = 0,
      this.min_value = 0.0,
      this.max_value = 1.0,
      required this.currentValue,
      required this.onChanged,
      required this.type,
      this.fullWidth = false});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    return Container(
      width: double.infinity,
      height: (widget.sliderHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular((widget.sliderHeight * .3)),
        ),
        gradient: ColorConstants.brandGradient,
        boxShadow: ColorConstants.softShadow,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(widget.sliderHeight * paddingFactor,
            2, widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              '${widget.min}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(.35),
                    trackHeight: 10.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: widget.sliderHeight * .4,
                      min: widget.min,
                      max: widget.max,
                    ),
                    overlayColor: Colors.white.withOpacity(.25),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.white.withOpacity(.4),
                  ),
                  child: Slider(
                      min: widget.min_value.toDouble(),
                      max: widget.max_value.toDouble(),
                      divisions: widget.division,
                      value: widget.currentValue,
                      onChanged: widget.onChanged),
                ),
              ),
            ),
            SizedBox(
              width: widget.sliderHeight * .1,
            ),
            Text(
              '${widget.max} ${widget.type}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.white //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor, //Text Color of Value on Thumb
      ),
      text: getValue(value),
    );

    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
