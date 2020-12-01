import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/getnewdocfield/getNewDocField_bloc.dart';
import 'package:fluttertransoon/dtos/hashtagDTO.dart';
import 'package:fluttertransoon/dtos/languageDTO.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/screens/document_tab/document_title.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertransoon/screens/document_tab/list_hashtag.dart';
import 'package:fluttertransoon/screens/document_tab/list_language.dart';
import 'package:fluttertransoon/screens/login/components/documentpage/daytime_picker_formfield.dart';
import 'package:fluttertransoon/util/flutter_constants.dart';

class DocumentEdit extends StatefulWidget {
  final TransactionInfoToUpdate transactionInfoToUpdate;
  const DocumentEdit({Key key, this.transactionInfoToUpdate}) : super(key: key);
  State<DocumentEdit> createState() => DocumentEditState();
}

class DocumentEditState extends State<DocumentEdit> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetNewDocFieldBloc _getNewField = GetNewDocFieldBloc();
    _getNewField.add(GetNewDocField());
    return BlocProvider(
      create: (context) => _getNewField,
      child: BlocBuilder<GetNewDocFieldBloc, GetNewDocFieldState>(
        builder: (context, state) {
          if (state is GetNewDocFieldLoading) {
            return Container();
          } else if (state is GetNewDocFieldSuccess) {
            return MyStatefulWidget(
              listLanguage: state.listLanguage,
              listHashTag: state.listHashTag,
              userId: state.userId,
              transactionInfoToUpdate: widget.transactionInfoToUpdate,
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final List<HashtagDTO> listHashTag;
  final List<LanguageDTO> listLanguage;
  final String userId;
  final TransactionInfoToUpdate transactionInfoToUpdate;
  MyStatefulWidget(
      {Key key,
      this.listHashTag,
      this.listLanguage,
      this.userId,
      this.transactionInfoToUpdate})
      : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<HashtagDTO> get hashTagItems => widget.listHashTag;
  List<LanguageDTO> get languageItems => widget.listLanguage;
  String get userId => widget.userId;
  GetHashTagList hashTag;
  GetLanguageList firstLanguage;
  GetLanguageList secondLanguage;
  GetDayTimePicker dateTime;
  TextEditingController titleField = TextEditingController();
  TextEditingController descriptionField = TextEditingController();
  File file;
  bool isUpload = false;
  bool isValidate = false;
  int count = 0;
  int price = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    titleField.text = widget.transactionInfoToUpdate.title;
    descriptionField.text = widget.transactionInfoToUpdate.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Edit Document"),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 30,
              ),
              onPressed: null)
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            //Title
            Container(
                child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, left: 30),
                  width: MediaQuery.of(context).size.width,
                  child: Text("Title",
                      style: const TextStyle(
                          color: const Color(0xff393939),
                          fontWeight: FontWeight.w400,
                          fontFamily: "SVN-ProductSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 17),
                      textAlign: TextAlign.left),
                ),
                Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: const Color(0xff7a7a7a), width: 2),
                        color: const Color(0xffffffff)),
                    child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: TextFormField(
                          onTap: () => {},
                          validator: (value) {
                            if (value.isEmpty && !isValidate) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: titleField,
                        )))
              ],
            )),
            //Description
            Container(
                child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 15, left: 30),
                    width: MediaQuery.of(context).size.width,
                    child: Text("Description",
                        style: const TextStyle(
                            color: const Color(0xff393939),
                            fontWeight: FontWeight.w400,
                            fontFamily: "SVN-ProductSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 17),
                        textAlign: TextAlign.left)),
                Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 14,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: const Color(0xff7a7a7a), width: 2),
                        color: const Color(0xffffffff)),
                    child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: TextFormField(
                          maxLines: null,
                          onTap: () => {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: descriptionField,
                        )))
              ],
            )),
            //Hastag
            Container(
                child: Column(
              children: <Widget>[
                DocTitle(title: "Hashtag"),
                Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: const Color(0xff7a7a7a), width: 2),
                        color: const Color(0xffffffff)),
                    child: Row(
                      children: <Widget>[
                        Container(
                            child: hashTag = GetHashTagList(
                          listDTO: hashTagItems,
                        )),
                      ],
                    ))
              ],
            )),
            //File
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 30),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("File",
                                style: const TextStyle(
                                    color: const Color(0xff393939),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SVN-ProductSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 17),
                                textAlign: TextAlign.left)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                style: const TextStyle(
                                    color: const Color(0xff595959),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10),
                                text: "Allow only specific file type: \ntxt"),
                          ])),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 25),
                    child: RaisedButton(
                        onPressed: () async {
                          count = 0;
                          file = await FilePicker.getFile(
                              type: FileType.custom,
                              allowedExtensions: ["txt"]);
                          // documentRepository.upload(File(file));
                          final fileOpen = new File(file.path);
                          Stream<List<int>> inputStream = fileOpen.openRead();
                          inputStream.transform(utf8.decoder)
                              // .transform(new LineSplitter())
                              .listen((String line) {
                            List<String> parts = line.split(" ");
                            setState(() {
                              count = count + parts.length;
                              price = count * WORD_PRICE;
                            });
                          }, onDone: () {
                            print('File is now closed.');
                          }, onError: (e) {
                            print(e.toString());
                          });
                          setState(() {
                            isUpload = true;
                          });
                        },
                        color: Colors.white70,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                            padding: const EdgeInsets.all(0.0),
                            width: MediaQuery.of(context).size.width / 2.9,
                            height: MediaQuery.of(context).size.height / 17,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Colors.black38),
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: isUpload
                                  ? Text(file.path.split("/").last,
                                      style: const TextStyle(
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SVN-ProductSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 13),
                                      textAlign: TextAlign.center)
                                  : Text(
                                      widget
                                          .transactionInfoToUpdate.originalDoc,
                                      style: const TextStyle(
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SVN-ProductSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 13),
                                      textAlign: TextAlign.center),
                            ))),
                  )
                ],
              ),
            ),
            //Date Time
            dateTime = GetDayTimePicker(
              formKey: _formKey,
              deadline: widget.transactionInfoToUpdate.deadline,
            ),
            //Language Of Doc
            Container(
                child: Column(
              children: <Widget>[
                DocTitle(title: "Language of your doc"),
                firstLanguage = GetLanguageList(
                  listDTO: languageItems,
                  firstValue:
                      widget.transactionInfoToUpdate.originalLanguageName,
                ),
              ],
            )),
            //Language Transoon
            Container(
                child: Column(
              children: <Widget>[
                DocTitle(title: "Language you want to transoon to"),
                secondLanguage = GetLanguageList(
                  listDTO: languageItems,
                  firstValue:
                      widget.transactionInfoToUpdate.translatedLanguageName,
                )
              ],
            )),
            Container(
                margin:
                    EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey[180],
                ),
                child: RaisedButton(
                  color: Colors.blue,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  onPressed: () {
                    if (firstLanguage.selectedValue == null) {
                      firstLanguage.selectedValue = languageItems[0];
                    }
                    if (secondLanguage.selectedValue == null) {
                      secondLanguage.selectedValue = languageItems[0];
                    }
                    if (hashTag.selectedValue == null) {
                      hashTag.selectedValue = hashTagItems[0];
                    } else if (_formKey.currentState.validate()) {
                      if (firstLanguage.selectedValue ==
                              secondLanguage.selectedValue ||
                          file == null) {
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.blue,
                              title: Text(
                                'Input fail !!!',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        file != null
                                            ? 'Please select translation language different from original language!!'
                                            : 'Please input valid file!!',
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                height: 300.0,
                                width: 300.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text(
                                        'Choose your way',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 25),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 50),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          RaisedButton(
                                            color: Colors.blue,
                                            onPressed: () async {
                                              DocumentRepository docRepo =
                                                  DocumentRepository();
                                              List<HashtagDTO> listHashTagDTO =
                                                  List<HashtagDTO>();
                                              listHashTagDTO
                                                  .add(hashTagItems[0]);
                                              String deadline = widget
                                                  .transactionInfoToUpdate
                                                  .deadline;
                                              TransactionInfoCreateRequestToTransooner
                                                  dto =
                                                  new TransactionInfoCreateRequestToTransooner(
                                                      widget
                                                          .transactionInfoToUpdate
                                                          .transactionId,
                                                      userId,
                                                      null,
                                                      firstLanguage.selectedValue
                                                          .languageId,
                                                      secondLanguage
                                                          .selectedValue
                                                          .languageId,
                                                      1000,
                                                      descriptionField.text,
                                                      titleField.text,
                                                      DateTime.parse(deadline),
                                                      file,
                                                      listHashTagDTO);
                                              bool check = await docRepo
                                                  .updateTransaction(dto);
                                            },
                                            child: Text(
                                              '      Request to Public    ',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          RaisedButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Request to Transooner!',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
