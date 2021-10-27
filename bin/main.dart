import 'package:concisely/src/dallang.dart' as concisely;

main(List<String> arguments) async{  
  print(await concisely.readFile('./dal/test.dal'));
  concisely.parse(await concisely.readFile('./dal/test.dal'));
}
