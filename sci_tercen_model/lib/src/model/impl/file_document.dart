part of sci_model;

class FileDocument extends FileDocumentBase {
  static const String META_TEMP = 'temp.file';

  FileDocument() : super();
  FileDocument.json(Map m) : super.json(m);

  bool get isTemp => hasMeta(META_TEMP);
  set isTemp(bool b) {
    if (b)
      addMeta(META_TEMP, 'true');
    else
      removeMeta(META_TEMP);
  }

  bool get isHidden => hasMetaFlag('hidden');
  set isHidden(bool flag) => addMetaFlag('hidden', flag);
}
