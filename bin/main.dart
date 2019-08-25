import 'package:conciseparser/dallang.dart' as conciseparser;

main(List<String> arguments) async{  
  print(await conciseparser.readFile("./dal/test.dal"));
  conciseparser.parse(await conciseparser.readFile("./dal/test.dal"));
}
