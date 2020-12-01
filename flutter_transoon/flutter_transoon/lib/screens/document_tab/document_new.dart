import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/getnewdocfield/getNewDocField_bloc.dart';
import 'package:fluttertransoon/dtos/hashtagDTO.dart';
import 'package:fluttertransoon/dtos/languageDTO.dart';
import 'package:fluttertransoon/dtos/transactionDTO.dart';
import 'package:fluttertransoon/repositories/document_repository.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/account_tab/account_component/opacity_line.dart';
import 'package:fluttertransoon/screens/document_tab/document_component/input_file_info_component.dart';
import 'package:fluttertransoon/screens/document_tab/document_title.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertransoon/screens/document_tab/list_hashtag.dart';
import 'package:fluttertransoon/screens/document_tab/list_language.dart';
import 'package:fluttertransoon/screens/document_tab/transaction_view.dart';
import 'package:fluttertransoon/screens/document_tab/view_list_active_transooner.dart';
import 'package:fluttertransoon/screens/login/components/documentpage/daytime_picker_formfield.dart';
import 'package:fluttertransoon/screens/transooner_loader_scafford.dart';
import 'package:fluttertransoon/util/flutter_constants.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class DocumentNew extends StatefulWidget {
  final UserRepository userRepository;
  final String displayName;
  DocumentNew({Key key, this.userRepository, this.displayName})
      : assert(true),
        super(key: key);
  State<DocumentNew> createState() => DocumentNewState();
}

class DocumentNewState extends State<DocumentNew> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetNewDocFieldBloc _getNewField = GetNewDocFieldBloc();
    _getNewField.add(GetNewDocField());
    return BlocProvider(
      create: (context) => _getNewField,
      child: BlocBuilder<GetNewDocFieldBloc, GetNewDocFieldState>(
        builder: (context, state) {
          if (state is GetNewDocFieldLoading) {
            return TransoonLoaderScafford();
          } else if (state is GetNewDocFieldSuccess) {
            return MyStatefulWidget(
              listLanguage: state.listLanguage,
              listHashTag: state.listHashTag,
              userId: state.userId,
              userRepository: widget.userRepository,
              displayName: widget.displayName,
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
  final UserRepository userRepository;
  final String displayName;
  final String userId;
  MyStatefulWidget(
      {Key key,
      this.listHashTag,
      this.listLanguage,
      this.userId,
      this.userRepository,
      this.displayName})
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
  final titleField = TextEditingController();
  final descriptionField = TextEditingController();
  File file;
  int price = 0;
  int count = 0;
  bool isUpload = false;
  bool isValidate = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("New Document"),
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
      body: SingleChildScrollView(
          child: Container(
              height: 480,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    //File
                    Container(
                      child: Row(
                        children: <Widget>[
                          InputFileInformation(),
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 25),
                            child: RaisedButton(
                                onPressed: () async {
                                  count = 0;
                                  file = await FilePicker.getFile(
                                      type: FileType.custom,
                                      allowedExtensions: ["txt"]);
                                  final fileOpen = new File(file.path);
                                  Stream<List<int>> inputStream =
                                      fileOpen.openRead();
                                  inputStream.transform(utf8.decoder).listen(
                                      (String line) {
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
                                    width:
                                        MediaQuery.of(context).size.width / 2.9,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color:
                                          isUpload ? Colors.grey : Colors.blue,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: isUpload
                                          ? Text(file.path.split("/").last,
                                              style: const TextStyle(
                                                  color:
                                                      const Color(0xffffffff),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "SVN-ProductSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13),
                                              textAlign: TextAlign.center)
                                          : Text("Upload",
                                              style: const TextStyle(
                                                  color:
                                                      const Color(0xffffffff),
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
                    //Title
                    Container(
                        child: Column(
                      children: <Widget>[
                        DocTitle(
                          title: "Short name of your doc",
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 25, right: 25),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 17,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: const Color(0xff7a7a7a), width: 0.3),
                                color: const Color(0xffffffff)),
                            child: Container(
                                margin: EdgeInsets.only(left: 15),
                                child: TextFormField(
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          bottom: 11, top: 11, right: 15),
                                      hintText: 'Enter text'),
                                  onTap: () => {},
                                  validator: (value) {
                                    if (value.isEmpty && !isValidate) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _formKey.currentState.validate();
                                    });
                                  },
                                  controller: titleField,
                                )))
                      ],
                    )),
                    //Description
                    Container(
                        child: Column(
                      children: <Widget>[
                        DocTitle(
                          title: "Short name of your doc",
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 25, right: 25),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 6,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: const Color(0xff7a7a7a), width: 0.3),
                                color: const Color(0xffffffff)),
                            child: Container(
                                margin: EdgeInsets.only(left: 15),
                                child: TextFormField(
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          bottom: 11, top: 11, right: 15),
                                      hintText: 'Enter description'),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onTap: () => {},
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _formKey.currentState.validate();
                                    });
                                  },
                                  controller: descriptionField,
                                )))
                      ],
                    )),

                    //Hastag
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: const Color(0xff7a7a7a), width: 0.1),
                          color: const Color(0xffffffff)),
                      child: MultiSelect(
                          autovalidate: false,
                          titleText: "Hashtag",
                          validator: (value) {
                            if (value == null) {
                              return 'Please select one or more option(s)';
                            }
                            return "";
                          },
                          errorText: 'Please select one or more option(s)',
                          dataSource: hashTagItems
                              .map((e) =>
                                  {"display": e.tagName, "value": e.hashTagId})
                              .toList(),
                          textField: 'display',
                          valueField: 'value',
                          filterable: true,
                          required: true,
                          value: null,
                          onSaved: (value) {
                            print('The value is $value');
                          }),
                    ),
                    OpacityLine(),
                    //Date Time
                    dateTime = GetDayTimePicker(
                      formKey: _formKey,
                    ),
                    //Language Of Doc
                    OpacityLine(),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: 180,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 15, left: 30, bottom: 5),
                                      width: MediaQuery.of(context).size.width,
                                      child: Text("Your Doc's language",
                                          style: const TextStyle(
                                              color: const Color(0xff393939),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SVN-ProductSans",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16),
                                          textAlign: TextAlign.left)),
                                  firstLanguage = GetLanguageList(
                                    listDTO: languageItems,
                                    firstValue: languageItems[0].languageName,
                                  ),
                                ],
                              )),
                          Container(
                              width: 180,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 15, left: 30, bottom: 5),
                                      width: MediaQuery.of(context).size.width,
                                      child: Text("Transooned to",
                                          style: const TextStyle(
                                              color: const Color(0xff393939),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SVN-ProductSans",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16),
                                          textAlign: TextAlign.left)),
                                  secondLanguage = GetLanguageList(
                                    listDTO: languageItems,
                                    firstValue: languageItems[0].languageName,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
      bottomSheet: Container(
          color: Colors.black87,
          height: 120,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 30, bottom: 5),
                      child: Text(
                        "Word count : $count",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "SVN-ProductSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40, bottom: 5),
                      child: Text(
                        "$price VND",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "SVN-ProductSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 30, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[180],
                        ),
                        width: 130,
                        child: RaisedButton(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          onPressed: () {},
                          child: Text(
                            'Reset',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[180],
                        ),
                        width: 130,
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
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK',
                                              style: TextStyle(
                                                  color: Colors.white)),
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Container(
                                        height: 300.0,
                                        width: 300.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(15.0),
                                              child: Text(
                                                'Choose your way',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                      DocumentRepository
                                                          docRepo =
                                                          DocumentRepository();
                                                      List<HashtagDTO>
                                                          listHashTagDTO =
                                                          List<HashtagDTO>();
                                                      listHashTagDTO
                                                          .add(hashTagItems[0]);
                                                      String deadline =
                                                          dateTime.dueDate +
                                                              " " +
                                                              dateTime.time;
                                                      TransactionInfoCreateRequestToTransooner
                                                          dto =
                                                          new TransactionInfoCreateRequestToTransooner(
                                                              null,
                                                              userId,
                                                              null,
                                                              firstLanguage
                                                                  .selectedValue
                                                                  .languageId,
                                                              secondLanguage
                                                                  .selectedValue
                                                                  .languageId,
                                                              price,
                                                              descriptionField
                                                                  .text,
                                                              titleField.text,
                                                              DateTime.parse(
                                                                  deadline),
                                                              file,
                                                              listHashTagDTO);
                                                      bool check = await docRepo
                                                          .requestPublic(dto);
                                                      if (check) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TransactionView(
                                                                        transactionDTO:
                                                                            dto)));
                                                      }
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: Colors.blue),
                                                    ),
                                                    color: Colors.white,
                                                    onPressed: () async {
                                                      DocumentRepository
                                                          docRepo =
                                                          DocumentRepository();
                                                      List<HashtagDTO>
                                                          listHashTagDTO =
                                                          List<HashtagDTO>();
                                                      listHashTagDTO
                                                          .add(hashTagItems[0]);
                                                      String deadline =
                                                          dateTime.dueDate +
                                                              " " +
                                                              dateTime.time;
                                                      TransactionInfoCreateRequestToTransooner
                                                          dto =
                                                          new TransactionInfoCreateRequestToTransooner(
                                                              null,
                                                              userId,
                                                              null,
                                                              firstLanguage
                                                                  .selectedValue
                                                                  .languageId,
                                                              secondLanguage
                                                                  .selectedValue
                                                                  .languageId,
                                                              price,
                                                              descriptionField
                                                                  .text,
                                                              titleField.text,
                                                              DateTime.parse(
                                                                  deadline),
                                                              file,
                                                              listHashTagDTO);

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ViewListActiveTransooner(
                                                                    transactionDTO:
                                                                        dto,
                                                                    displayName:
                                                                        widget
                                                                            .displayName,
                                                                    userRepository:
                                                                        widget
                                                                            .userRepository,
                                                                  )));
                                                    },
                                                    child: Text(
                                                      'Request to Transooner!',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.blue),
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
