import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_points_app/config/page_config.dart';
import 'package:reward_points_app/util/single_key.dart';
import 'package:reward_points_app/util/styled_text.dart';

class BaseKeyboard extends StatefulWidget {
  final String initDisplay;
  final String suffix;
  final double displaySize;
  final String displayFormat;
  final bool startZero;
  final int displayLimit;

  const BaseKeyboard({
    super.key,
    required this.initDisplay,
    this.suffix = '',
    this.displaySize = 35.0,
    this.displayFormat = '#,###',
    this.startZero = false,
    this.displayLimit = 8,
  });

  @override
  State<BaseKeyboard> createState() => BaseKeyboardState();
}

class BaseKeyboardState extends State<BaseKeyboard> {
  String amount = '';

  renderText() {
    String display = widget.initDisplay;
    TextStyle style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: widget.displaySize,
    );

    if (amount.isNotEmpty) {
      NumberFormat f = NumberFormat(widget.displayFormat);

      display =
          (amount.startsWith('0'))
              ? amount
              : '${f.format(int.parse(amount))}${widget.suffix}';
      style = style.copyWith(color: Colors.black);
    }

    return Expanded(child: Center(child: Text(display, style: style)));
  }

  final keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    [
      '00',
      '0',
      Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/arrows_sign_left.png', width: 50),
          Container(
            alignment: Alignment(0.03, 0),
            child: const Icon(Icons.close, size: 30),
          ),
        ],
      ),
    ],
  ];

  onNumberPress(val) {
    setState(() {
      if (!widget.startZero && amount.isEmpty && (val == '0' || val == '00')) {
        return;
      }
      if (amount.length + val.length > widget.displayLimit) {
        return;
      }
      amount = amount + val;
    });
  }

  onBackspacePress(val) {
    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children:
                x.map((y) {
                  return Expanded(
                    child: SingleKey(
                      //StatefulWidget
                      label: y,
                      onTap: y is Widget ? onBackspacePress : onNumberPress,
                      value: y,
                    ),
                  );
                }).toList(),
          ),
        )
        .toList();
  }

  disableConfirm() {
    return amount.isEmpty || int.parse(amount) < 20;
  }

  nextPage() {
    return PageConfig().baseKeyboard((int.parse(amount) ~/ 20).toString());
  }

  confirmButtonText() {
    return '확인';
  }

  renderConfirmButton() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            //StatefulWidget
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 33, 117, 243),
              disabledBackgroundColor: Colors.grey[200],
              shape: LinearBorder(),
            ),
            onPressed:
                disableConfirm()
                    ? null
                    : () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => nextPage()),
                    ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: StyledText(
                data: confirmButtonText(),
                color: disableConfirm() ? Colors.grey : Colors.white,
                fontsize: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                renderText(),
                ...renderKeyboard(),
                const SizedBox(height: 16.0),
                renderConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
