import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testim_view/view_model.dart';
import 'package:http/http.dart' as http;

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController nameController = TextEditingController();
  //final TextEditingController viewController = TextEditingController();
  final TextEditingController feedback = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  DataModel? _dataModel;
  String? checkStatus;

  @override
  void dispose() {
    feedback.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: feedback,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Enter your feedback here',
            filled: true,
          ),
          maxLines: 5,
          maxLength: 5000,
          textInputAction: TextInputAction.done,
          validator: (String? text) {
            if (text == null || text.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Send'),
          onPressed: () {
            submitData;
            //DataModel? data = await submitData(feedback);
          },
        )
      ],
    );
  }

  Future<DataModel?> submitData(TextEditingController viewController) async {
    var response = await http.post(
        Uri.http('gbv-beta.herokuapp.com', '/post/'),
        body: {
          "feedback": viewController.text,
          //"status": checkStatus.toString(),
        });
    var data = response.body;
    print(data);
    if (response.statusCode == 200) {
      String responseString = response.body;
      dataModeFromJson(responseString);
    } else
      return null;
  }
}
