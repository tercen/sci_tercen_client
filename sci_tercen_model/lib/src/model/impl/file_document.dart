part of sci_model;

class FileDocument extends FileDocumentBase {
  static const String META_TEMP = 'temp.file';

  FileDocument() : super();
  FileDocument.json(super.m) : super.json();

  bool get isTemp => hasMeta(META_TEMP);
  set isTemp(bool b) {
    if (b) {
      addMeta(META_TEMP, 'true');
    } else {
      removeMeta(META_TEMP);
    }
  }

  @override
  bool get isHidden => hasMetaFlag('hidden');
  @override
  set isHidden(bool flag) => addMetaFlag('hidden', flag);
}
