import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
 // List list = [];

  stt.SpeechToText _speechToTextDesc = stt.SpeechToText();
  TextEditingController descController = TextEditingController();
  bool _titleSpeechEnabled = false;
  bool _descSpeechEnabled = false;
  String _lastWords = '';
  String _secondWords = "";
  bool isClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    _initSpeechDesc();
    super.initState();
  }

  void _initSpeechDesc() async {
    _descSpeechEnabled = await _speechToTextDesc.initialize();
    setState(() {});
  }

  void _onSpeechResultDesc(SpeechRecognitionResult result) {
    setState(() {
      descController.text = result.recognizedWords;
    });
  }

  void _startListeningDesc() async {
    await _speechToTextDesc.listen(onResult: _onSpeechResultDesc);
    setState(() {});
  }

  void stopListeningDesc() async {
    await _speechToTextDesc.stop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: const Text('Add Task')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (e) {
                        setState(() {
                          _lastWords = e;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Enter Title",
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        fillColor: Colors.blueGrey[100],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: descController,
                      onChanged: (e) {
                        setState(() {
                          _secondWords = e;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Discription",
                          hintText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          fillColor: Colors.blueGrey[100],
                          filled: true,
                          suffixIcon: InkWell(
                              onTap: _speechToTextDesc.isNotListening
                                  ? _startListeningDesc
                                  : stopListeningDesc,
                              child: (Icon(
                                _speechToTextDesc.isNotListening
                                    ? Icons.mic_off
                                    : Icons.mic,
                                size: 40,
                                color: Colors.black,
                              )))),
                      validator: (value) {
                        print("line 196 ${(value)}");
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () {
                            var data = {
                              "name": _lastWords,
                              "desc": descController.text,
                              "isClicked": false
                            };print("Line147: $data");
                            Navigator.of(context).pop(data);
                            setState(() {
                              _lastWords = "";
                              _secondWords = "";
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 13, bottom: 13, left: 18, right: 18),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
