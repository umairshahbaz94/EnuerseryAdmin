import 'dart:io';

import 'package:enersuryadmin/Provider/Prodcut.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


typedef VoidCallback = Function(String value);

class EditDialog extends StatefulWidget {
  const EditDialog(
      {required this.title,
      required this.positiveAction,
      required this.negativeAction,
      required this.submit});
  final String title, positiveAction, negativeAction;
  final Function submit;

  EditDialogState createState() => EditDialogState();
}

class EditDialogState extends State<EditDialog> {
  final picker = ImagePicker();
  late File _image;
  bool _load = false;

  final TextEditingController textFieldController = TextEditingController();
  bool _validateDialog = true;

  @override
  void initState() {
    textFieldController.addListener(_updateDialogTextField);
    super.initState();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: getDialogContent(context),
      actions: <Widget>[
        FlatButton(
          child: Text(widget.positiveAction,
              style: TextStyle(
                color: _validateDialog ? Colors.blueAccent : Colors.grey,
              )),
          onPressed: () {
            if (_validateDialog) {
              widget.submit(
                  textFieldController.text.toString(), context, _image);
              Navigator.of(context).pop();
            }
          },
        ),
        FlatButton(
          child: Text(
            widget.negativeAction,
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget getDialogContent(context) {
    var provider = Provider.of<Productprovider>(context, listen: false);
    return Column(
      children: [
        TextField(
          cursorColor: Theme.of(context).accentColor,
          controller: textFieldController,
          decoration: InputDecoration(
            hintText: 'Enter your Category here',
            errorText: !_validateDialog ? 'Value Can\'t Be Empty' : null,
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () async {
              provider.getImage().then((value) {
                setState(() {
                  _load = true;
                  _image = value;
                });
              });
            },
            child: SizedBox(
              width: 150,
              height: 150,
              child: Card(
                child: Center(
                  child:
                      _load == true ? Image.file(_image) : Text("Select Image"),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _updateDialogTextField() {
    setState(() {
      _validateDialog = textFieldController.text.isNotEmpty;
    });
  }
}
