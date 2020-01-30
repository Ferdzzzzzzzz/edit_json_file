import 'dart:convert';
import 'dart:io';

class EditJsonFile {
  final path;
  final bool autoSave;
  final bool prettyJson;
  Map<String, dynamic> _obj;
  File _file;

  ///
  /// EditJsonFile
  ///
  /// @name EditJsonFile
  /// @function
  /// @param {String} path The path to the JSON file.
  ///
  /// @optionalParam autosave (Boolean): Save the file when setting some data in it. Default false
  ///
  /// @returns {JsonEditor} The `JsonEditor` instance.
  ///
  EditJsonFile(
    this.path, {
    this.autoSave = false,
    this.prettyJson = true,
  });

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  Future<EditJsonFile> init() async {
    await _read(path);
    return this;
  }

  ///
  /// set
  /// set value in map
  ///
  /// @name set
  /// @params List<String> path: object path
  /// @params dynamic val: value to be set
  ///
  void set(List<String> path, dynamic val) {
    var obj = <String, dynamic>{path[path.length - 1]: val};
    for (var i = 1; i < path.length; i++) {
      obj = <String, dynamic>{path[path.length - i - 1]: obj};
    }

    _obj.addAll(obj);

    _autoSave();
  }

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  void update() {}

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  dynamic get(List<String> path) {
    var objKey = _obj[path[0]];
    for (var i = 1; i < path.length; i++) {
      objKey = objKey[path[i]];
    }
    return objKey;
  }

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  void unset(List<String> path) {
    var objKey = _obj[path[0]];

    _autoSave();
  }

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  Future<void> _read(String path) async {
    _file = File(path);
    _obj = await _file
        .readAsString()
        .then((s) => jsonDecode(s))
        .catchError(() => print('File read failed'));
  }

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  void write() {
    _save();
  }

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  void empty() {
    _obj.clear();
    var jsonText = jsonEncode(_obj);
    _file.writeAsString(jsonText);
  }

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  void _save() {
    //var jsonText = jsonEncode(_obj);
    _file.writeAsString(_prettyJson());
  }

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  Map<String, dynamic> toObject() {
    return _obj;
  }

  ///
  /// read
  /// Read the JSON file.
  ///
  /// @name read
  /// @function
  /// @returns {Map<String, dynamic>} The object parsed as map or an empty object by default.
  ///
  void _autoSave() {
    if (autoSave) {
      _save();
    }
  }

  void prettyPrint() {
    print(_prettyJson());
  }

  String _prettyJson() {
    var encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(_obj);
  }
}

//test: set, unset, update
