import 'dart:io';
import 'package:fluttertransoon/dtos/hashtagDTO.dart';

class TransactionDTO {
  final int transactionId;
  final String customerId;
  final String transoonerId;
  final int originalLanguageId;
  final String originalLanguageName;
  final int translatedLanguageId;
  final String translatedLanguageName;
  final int totalPaid;
  final String createdDate;
  final String finishedDate;
  final String title;
  final String description;
  final String deadline;
  final String originalDoc;
  final String transoonedDoc;
  final String status;
  final String feedback;
  final double rating;
  final String feedbackDate;
  final List<HashtagDTO> hashTags;
  TransactionDTO._({
    this.transactionId,
    this.customerId,
    this.transoonerId,
    this.originalLanguageId,
    this.originalLanguageName,
    this.translatedLanguageId,
    this.translatedLanguageName,
    this.totalPaid,
    this.createdDate,
    this.finishedDate,
    this.title,
    this.description,
    this.deadline,
    this.originalDoc,
    this.transoonedDoc,
    this.status,
    this.feedback,
    this.rating,
    this.feedbackDate,
    this.hashTags,
  });
  factory TransactionDTO.fromJson(Map<String, dynamic> json) {
    var list = json['hashTags'] as List;
    List<HashtagDTO> itemsList =
        list.map((i) => HashtagDTO.fromJson(i)).toList();
    return new TransactionDTO._(
      transactionId: json['transactionId'],
      customerId: json['customerId'],
      transoonerId: json['transoonerId'],
      originalLanguageId: json['originalLanguageId'],
      originalLanguageName: json['originalLanguageName'],
      translatedLanguageId: json['translatedLanguageId'],
      translatedLanguageName: json['translatedLanguageName'],
      totalPaid: json['totalPaid'],
      createdDate: json['createdDate'],
      finishedDate: json['finishedDate'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'],
      originalDoc: json['originalDoc'],
      transoonedDoc: json['transoonedDoc'],
      status: json['status'],
      feedback: json['feedback'],
      rating: json['rating'],
      feedbackDate: json['feedbackDate'],
      hashTags: itemsList,
    );
  }
}

class TransactionInfoCreateRequestToTransooner {
  int transactionId;
  final String customerId;
  final String transoonerId;
  final int originalLanguageId;
  final int translatedLanguageId;
  final int totalPaid;
  final String description;
  final String title;
  final DateTime deadline;
  final File originalDoc;
  final List<HashtagDTO> hashTags;
  TransactionInfoCreateRequestToTransooner(
      this.transactionId,
      this.customerId,
      this.transoonerId,
      this.originalLanguageId,
      this.translatedLanguageId,
      this.totalPaid,
      this.description,
      this.title,
      this.deadline,
      this.originalDoc,
      this.hashTags);
  TransactionInfoCreateRequestToTransooner._(
      {this.customerId,
      this.transoonerId,
      this.originalLanguageId,
      this.translatedLanguageId,
      this.totalPaid,
      this.description,
      this.deadline,
      this.originalDoc,
      this.hashTags,
      this.title});
  factory TransactionInfoCreateRequestToTransooner.fromJson(
      Map<String, dynamic> json) {
    var list = json['hashTags'] as List;
    List<HashtagDTO> itemsList =
        list.map((i) => HashtagDTO.fromJson(i)).toList();
    return new TransactionInfoCreateRequestToTransooner._(
        customerId: json['customerId'],
        transoonerId: json['transoonerId'],
        originalLanguageId: json['originalLanguageId'],
        translatedLanguageId: json['translatedLanguageId'],
        totalPaid: json['totalPaid'],
        description: json['description'],
        deadline: json['deadline'],
        originalDoc: json['originalDoc'],
        title: json['title'],
        hashTags: itemsList);
  }
}

class TransactionInfoToUpdate {
  final int transactionId;
  final String customerId;
  final String transoonerId;
  final int originalLanguageId;
  final String originalLanguageName;
  final int translatedLanguageId;
  final String translatedLanguageName;
  final int totalPaid;
  final String title;
  final String description;
  final String deadline;
  final String originalDoc;
  final String status;
  final List<HashtagDTO> hashTags;
  TransactionInfoToUpdate._({
    this.transactionId,
    this.customerId,
    this.transoonerId,
    this.originalLanguageId,
    this.originalLanguageName,
    this.translatedLanguageId,
    this.translatedLanguageName,
    this.totalPaid,
    this.title,
    this.description,
    this.deadline,
    this.originalDoc,
    this.status,
    this.hashTags,
  });
  factory TransactionInfoToUpdate.fromJson(Map<String, dynamic> json) {
    var list = json['hashTags'] as List;
    List<HashtagDTO> itemsList =
        list.map((i) => HashtagDTO.fromJson(i)).toList();
    return new TransactionInfoToUpdate._(
      transactionId: json['transactionId'],
      customerId: json['customerId'],
      transoonerId: json['transoonerId'],
      originalLanguageId: json['originalLanguageId'],
      originalLanguageName: json['originalLanguageName'],
      translatedLanguageId: json['originalLanguageId'],
      translatedLanguageName: json['translatedLanguageName'],
      totalPaid: json['totalPaid'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'],
      originalDoc: json['originalDoc'],
      status: json['status'],
      hashTags: itemsList,
    );
  }
}

class TransactionInfoUpdate {
  final int transactionId;
  final int originalLanguageId;
  final int translatedLanguageId;
  final int totalPaid;
  final String title;
  final String description;
  final String deadline;
  final File originalDoc;
  final List<HashtagDTO> hashTags;
  TransactionInfoUpdate._({
    this.transactionId,
    this.originalLanguageId,
    this.translatedLanguageId,
    this.totalPaid,
    this.title,
    this.description,
    this.deadline,
    this.originalDoc,
    this.hashTags,
  });
  factory TransactionInfoUpdate.fromJson(Map<String, dynamic> json) {
    var list = json['hashTags'] as List;
    List<HashtagDTO> itemsList =
        list.map((i) => HashtagDTO.fromJson(i)).toList();
    return new TransactionInfoUpdate._(
      transactionId: json['transactionId'],
      originalLanguageId: json['originalLanguageId'],
      translatedLanguageId: json['originalLanguageId'],
      totalPaid: json['totalPaid'],
      title: json['title'],
      description: json['description'],
      deadline: json['deadline'],
      originalDoc: json['originalDoc'],
      hashTags: itemsList,
    );
  }
}
