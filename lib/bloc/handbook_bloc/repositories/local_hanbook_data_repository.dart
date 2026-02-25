import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../models/handbook/hanbook_section.dart';
import 'hanbook_data_repository.dart';

class LocalHanbookDataRepository implements HanbookDataRepository {
  final dynamic logger;
  LocalHanbookDataRepository({this.logger});

  @override
  void fetchSection(int sectionId, void Function(HanbookSection) callback) {
    try {
      logger?.log(
        'Fetching section $sectionId',
        tag: 'LocalHanbookDataRepository',
      );
      rootBundle
          .loadString('assets/data/$sectionId/section.json')
          .then((content) {
            final jsonData = json.decode(content);
            final section = HanbookSection.fromJson(jsonData);
            logger?.log(
              'Section $sectionId loaded successfully',
              tag: 'LocalHanbookDataRepository',
            );
            callback(section);
          })
          .catchError((error) {
            logger?.error(
              'Error reading section $sectionId',
              tag: 'LocalHanbookDataRepository',
              error: error,
            );
            callback(HanbookSection(id: sectionId, name: 'Error', items: []));
          });
    } catch (e) {
      logger?.error(
        'Exception fetching section $sectionId',
        tag: 'LocalHanbookDataRepository',
        error: e,
      );
      callback(HanbookSection(id: sectionId, name: 'Error', items: []));
    }
  }
}
