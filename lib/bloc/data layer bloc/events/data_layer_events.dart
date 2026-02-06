abstract class DataLayerEvent {}

class RetrieveDataEvent extends DataLayerEvent {
  final String scannedString;
  RetrieveDataEvent(this.scannedString);
}
