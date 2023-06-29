import 'package:flutter/material.dart';
import 'package:todo_list_app/themes/text_themes.dart';

class InputField extends StatelessWidget {
  final String title;
  final String placeholder;
  final TextEditingController? textEditingController;
  final Widget? widget;

  const InputField(
      {super.key,
      required this.title,
      required this.placeholder,
      this.textEditingController,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getTitleTextStyle(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(left: 15),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white30,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  cursorColor: Colors.white30,
                  controller: textEditingController,
                  style: getInputTextStyle(),
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: getPlaceholderTextStyle(),
                    border: InputBorder.none,
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget,)
              ]
            ),
          )
        ]),
    );
  }
}
