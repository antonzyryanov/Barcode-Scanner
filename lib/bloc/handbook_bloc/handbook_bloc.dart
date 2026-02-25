import '../../models/handbook/hanbook_section.dart';
import 'repositories/hanbook_data_repository.dart';
import 'repositories/local_hanbook_data_repository.dart';
import '../../services/app_logger.dart';

class HandbookBloc {
  HanbookSection? firstSectionModel;
  HanbookSection? secondSectionModel;
  HanbookSection? thirdSectionModel;
  HanbookSection? fourthSectionModel;
  HanbookSection? fifthSectionModel;

  final HanbookDataRepository repository;
  final AppLogger logger;

  HandbookBloc({HanbookDataRepository? repository, required this.logger})
    : repository = repository ?? LocalHanbookDataRepository(logger: logger);

  void fetchAllSections(void Function() onComplete) {
    logger.log('HandbookBloc: fetchAllSections called', tag: 'HandbookBloc');
    int loaded = 0;
    void checkComplete() {
      loaded++;
      if (loaded == 5) onComplete();
    }

    repository.fetchSection(1, (section) {
      if (section.name == 'Error') {
        logger.error('Error loading section 1', tag: 'HandbookBloc');
      } else {
        logger.log('Section 1 loaded', tag: 'HandbookBloc');
      }
      firstSectionModel = section;
      checkComplete();
    });
    repository.fetchSection(2, (section) {
      if (section.name == 'Error') {
        logger.error('Error loading section 2', tag: 'HandbookBloc');
      } else {
        logger.log('Section 2 loaded', tag: 'HandbookBloc');
      }
      secondSectionModel = section;
      checkComplete();
    });
    repository.fetchSection(3, (section) {
      if (section.name == 'Error') {
        logger.error('Error loading section 3', tag: 'HandbookBloc');
      } else {
        logger.log('Section 3 loaded', tag: 'HandbookBloc');
      }
      thirdSectionModel = section;
      checkComplete();
    });
    repository.fetchSection(4, (section) {
      if (section.name == 'Error') {
        logger.error('Error loading section 4', tag: 'HandbookBloc');
      } else {
        logger.log('Section 4 loaded', tag: 'HandbookBloc');
      }
      fourthSectionModel = section;
      checkComplete();
    });
    repository.fetchSection(5, (section) {
      if (section.name == 'Error') {
        logger.error('Error loading section 5', tag: 'HandbookBloc');
      } else {
        logger.log('Section 5 loaded', tag: 'HandbookBloc');
      }
      fifthSectionModel = section;
      checkComplete();
    });
  }
}
