import '../../../models/handbook/hanbook_section.dart';

abstract class HanbookDataRepository {
  void fetchSection(int sectionNumber, void Function(HanbookSection) callback);
}
