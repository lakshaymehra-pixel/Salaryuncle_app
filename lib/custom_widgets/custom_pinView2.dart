import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/panCardController.dart';

import '../utils/color_constants.dart';

class PinViewScreen extends StatelessWidget {
  const PinViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom PinView'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomPinView(
            pinLength: 10,
            onCompleted: (pin) {
              if (kDebugMode) {
                print('Entered PIN: $pin');
              }
            },
          ),
        ),
      ),
    );
  }
}

class CustomPinView extends StatefulWidget {
  final int pinLength;
  final ValueChanged<String> onCompleted;

  CustomPinView({
    Key? key,
    required this.pinLength,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _CustomPinViewState createState() => _CustomPinViewState();
}

class _CustomPinViewState extends State<CustomPinView> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _pin = "";
  List value_list = ["", "", "", "", "", "", "", "", "", ""];
  var pre_value_length = 0;
  late KeyEvent current_event;
  PanCardController controller = Get.put(PanCardController());

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.pinLength, (_) => TextEditingController());
    _focusNodes = List.generate(widget.pinLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String value, int index, KeyEvent? current_event) {
    // print("Text Changed: $value, index: $index current_event: $current_event");
    try {
      if (_controllers[index].text.isNotEmpty &&
          current_event!.logicalKey == LogicalKeyboardKey.backspace) {
        _controllers[index].clear();

        if (kDebugMode) {
          print(
            "Text Changed: $value, index: $index current_event: $current_event");
        }
        return;
      }

      if (current_event!.logicalKey == LogicalKeyboardKey.backspace &&
          _controllers[index].text.isEmpty) {
        _onBackspacePressed(index);
        return;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    // If a digit is entered, move to the next field
    if (value.isNotEmpty && index < widget.pinLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      if (_controllers[index].text.isEmpty) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
        value_list[index] = _controllers[index].text;
      }

      _pin = _controllers.map((controller) => controller.text).join();
      return null;
    }
    // value_list[index] = _controllers[index].text;

    // Update the PIN value
    _pin = _controllers.map((controller) => controller.text).join();

    // If all boxes are filled, call the onCompleted callback
    if (_pin.length == widget.pinLength && !_pin.contains("")) {
      widget.onCompleted(_pin);
      FocusScope.of(context).unfocus(); // Dismiss the keyboard
    }
    if (index == 4 && controller.keyboardType.value != TextInputType.number) {
      _controllers[index].value = TextEditingValue(
          text: value.toUpperCase(), selection: _controllers[index].selection);
      controller.keyboardType.value = TextInputType.number;
      _focusNodes[index].unfocus();

      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        _focusNodes[index + 1].requestFocus();
      });
    }
    // else if (value.length <= 5 &&
    //     controller.keyboardType.value != TextInputType.number) {
    //   print(value);
    //   controller.panNoController.value.value = TextEditingValue(
    //       text: isNumeric(value)
    //           ? value.substring(0, value.length - 1)
    //           : value.toUpperCase(),
    //       selection: controller.panNoController.value.selection);
    // }
    else if (index < 5 &&
        controller.keyboardType.value == TextInputType.number) {
      _controllers[index].value = TextEditingValue(
          text: value.toUpperCase(), selection: _controllers[index].selection);
      controller.keyboardType.value = TextInputType.name;
      _focusNodes[index].unfocus();
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        _focusNodes[index + 1].requestFocus();
      });
    } else if (index == 7 &&
        controller.keyboardType.value != TextInputType.number) {
      controller.keyboardType.value = TextInputType.number;
      _focusNodes[index].unfocus();
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        _focusNodes[index + 1].requestFocus();
      });
    } else if (index == 8 &&
        controller.keyboardType.value != TextInputType.name) {
      _controllers[index].value = TextEditingValue(
          text: value.toUpperCase(),
          selection: _controllers[index].value.selection);
      controller.keyboardType.value = TextInputType.name;
      _focusNodes[index].unfocus();
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        _focusNodes[index + 1].requestFocus();
      });
    } else {
      _controllers[index].value = TextEditingValue(
          text: value.toUpperCase(), selection: _controllers[index].selection);
    }
  }

  void _onBackspacePressed(int index) {
    if (index > 0 && _controllers[index].text.isEmpty) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.pinLength, (index) {
          return SizedBox(
            width: 25.sp,
            child: Focus(
              onKeyEvent: (node, event) {
                // current_event = event;
                if (event.logicalKey == LogicalKeyboardKey.backspace) {
                  _onTextChanged(event.logicalKey.keyLabel, index, event);
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              },
              child: TextFormField(
                cursorHeight: 20.sp,
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: controller.keyboardType.value,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.ink),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: ColorConstants.cardTintLight,
                  counter: const Offstage(),
                  counterText: "",
                  // Hides the counter
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: const BorderSide(
                        color: ColorConstants.border, width: 1.2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: const BorderSide(
                        color: ColorConstants.primary, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                    borderSide: const BorderSide(
                        color: ColorConstants.border, width: 1.2),
                  ),
                ),
                onChanged: (value) => _onTextChanged(value, index, null),
                onTap: () {
                  _controllers[index].selection = TextSelection.fromPosition(
                    TextPosition(offset: _controllers[index].text.length),
                  );
                },
                onEditingComplete: () {},
                // Prevents submission on enter
                inputFormatters: const [], // You can use `FilteringTextInputFormatter` for further control
              ),
            ),
          );
        }),
      );
    });
  }
}
