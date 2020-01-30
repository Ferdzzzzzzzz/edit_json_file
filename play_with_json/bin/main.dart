import 'package:edit_json_file/edit_json_file.dart';

void main(List<String> arguments) async {
  var path = '/Users/ferdinandsteenkamp/Desktop/test.json';
  var obj = await EditJsonFile(path, autoSave: true).init();
  await obj.set(['this','will'], 'did this overwrite?');

}
