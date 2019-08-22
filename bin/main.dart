import 'package:dallang/dallang.dart' as dallang;

main(List<String> arguments) async{
  print('Hello world: ${dallang.calculate()}!');
  print(await dallang.readFile("./dal/test.dal"));
  dallang.parse(await dallang.readFile("./dal/test.dal"));
}
