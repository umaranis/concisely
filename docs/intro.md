<span style="color:red">*Work in progress*</span>

Parser combinator library for Dart language which is powerful and easy to use.

Some key features are:

- Null Safety
- Code coverage

# Parsers

**Character parsers**: match a single character from the input

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| any    | parses any character except end of input | `any` - parses 'a', '1', '@' etc.|
| char(c) | parses a character based on the given pattern | `char('a')` - parses 'a' <br/> `char('ab')` or `anyOf('ab')` - parses character 'a' or 'b' <br/> `char('a-z')` or `lowercase` - parsers any character from 'a' to 'z' <br/> `char('A-Z')` or `uppercase` - parses any character from 'A' to 'Z' <br/> `char('a-zA-z')` or `letter` - parses any alphabet character <br/> `char('0-9')` or `digit` - parses any character from '0' to '9' <br/> |
| except(c) | parses a character if it doesn't match the given pattern | `except('a')` - parses any character expect 'a' <br/> `except('ab')` or `noneOf('ab')` - parses any character expect 'a' or 'b' <br/> `except('a-c')` - parses any character except 'a', 'b' and 'c' <br/> <code>except('a-c' &#124; newline)</code> - parses any character except 'a', 'b', 'c' and newline |

**String parsers**: match a string of characters from the input

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| text(t) | parses any string of characters exactly matching the given string | `text('hello world!')` - parses 'hello world!' <br/> `'hello world!'.p`  - same as above (.p converts text into a parser)  |

**Combining parsers**: combine parsers to create more complex parsers

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| & | combines parsers in a sequence | `char('a') & char('b')` - parses 'ab' <br/> `'item'.p & digit` - parser 'item1', 'item2', 'item3' etc. |
| &#124; | combines parsers with Choice operator. <br/>Returns the result of first parser if it's successful otherwise second. | <code>'hello'.p &#124; 'welcome'.p</code> - parses 'hello' or 'welcome' |
| + | same as '&' but trim any whitespace between the two parsers  | `'Hello' + 'World!'` - parsers 'Hello World!' (also 'HelloWorld!')

**Repeating parsers**: repeat a parser a number of times

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| p.many | repeat a parser one or more times | `char('a').many` - parses one or more a's like 'a' or 'aaa' |
| p.zeroOrMore | repeat a parser zero or more times | `char('a').zeroOrMore` - parses zero or more a's like 'a' or 'aaa' or empty string |
| p.optional | parses zero or one time  | `char('a').optional` - parses zero or one 'a' like 'a' or empty string |
| p.times(t) | repeat a parser given number of times  | `char('a').times(4)` - parses 'aaaa' |
| p.repeat(min, max) | repeat a parser between min and max times (both inclusive)  | `char('a').repeat(2,4)` - parses 'aa' or 'aaa' or 'aaaa' |
| p.repeat(t) | repeat a parser at least given number of times  | `char('a').repeat(2)` - parses 'a' two or more times like 'aa' or 'aaaaa' |
| p.separatedBy(s) | parsers a list of item separated by the given separator. <br/> Igonres whitespace on either side of the separator  | `digit.many.separatedBy(',')` - parses '1, 2, 3' to a list of 3 digits

**Whitespace parsers**: dealing with whitespace

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| newline | parses a new line | `newline` - parses '\n', '\r' or '\r\n' |
| whitespace | parses space, tab or newline | `whitespace` - parses ' ', '\t' or newline |
| p.trim | trims whitespace around a parser | `digit.trim` - parses '1' and ' 1 ' |
| + | same as '&' but trim any whitespace between the two parsers  | `'Hello' + 'World!'` - parsers 'Hello World!' (also 'HelloWorld!')

**Transforming parsers**: transform result of a parser

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| p \> type.string | transform the result into a string | `char('a').many > string` - parses 'aaaa' into ['a','a','a','a'] which string transformer will transform to 'aaaa' <br/> `char('a').many & char('b').many > string` - parses 'aabb' into [['a','a'],['b','b']] which list transformer will transform to 'aabb'  |
| p \> type.list | transform the result into a list from a tree | `char('a').many & char('b').many > list` - parses 'aabb' into [['a','a'],['b','b']] which list transformer will transform to ['a','a','b','b'] |
| p \> type.int | transform the result into a integer | `digit.many > type.int` - parses '1234' into ['1','2','3','4'] which int transformer will transform to 1234 |
| p \> type.float | transform the result into a floating point number (double) | `digit.many & char('.') & digit.many > type.float` - parses '12.34' into [['1','2'],'.',['3','4']] which float transformer will transform to 12.34 |
| p \> type.bool | transform the result into a boolean value | `text('false') > type.bool` - parses 'false' into a string which boolean transformer will transform to false |
| p \> pick(n) | pick an element from the result list | `char('<') & char('a') & char('>') > pick(1)` - parses '\<a>' into [ '<', 'a', '>' ] which is transformed to 'a' |
| p \> pick(n,n,..) | pick elements from the result list | `char('<') & char('a') & char('>') > pick(0,2)` - parses '\<a>' into [ '<', 'a', '>' ] which is transformed to [ '<', '>' ] |
| p \> map((r) => {}) | transform the results using custom delegate | `letter > map((r) => (r as String).toUpperCase())` - parses 'a' and transforms it to 'A' |
| p \> consume((r) => {}) | consumes the results | `letter > map((r) => print(r)` - parses 'a' and prints it. Parse is successful with blank results. <br/> <br/> Using `consume`, we can create multiple streams of parse results. For instance, in parsing code, comments can go to a separate object using consume and actual code can be part of the regular parse tree. |

**Lookahead parsers**: match a parser without consuming input

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| if(p) | doesn't consume any input, successful if able to parse p | `if('a') & letter.many` - parses a word if it starts with 'a' like 'aero' (it is equivalent to char('a') & letter.zeroOrMore <br/> `char('a') & if('b')` - parses 'a' if the next character is 'b' <br/> `'http'.p & if('://')` - parses http if succeeded by '://' <br/> `char('a') & if(char('a-f))` - parses 'a' if next character is between 'a' and 'f' |
| ifNot(p) | doesn't consume any input, successful if not able to parse p | `ifNot('a') & letter.many` - parses a word if it doesn't start with 'a' like 'bake' <br/> `char('a') & ifNot('b')` - parses 'a' if the next character is not 'b' |

# Parsing Examples

| Example | Parser | Sample Text |
| ------ | ----------  | -------- |
| Sql Select | 'select'.p + column.separatedBy(',') + 'from'.p tablename + 'where'.p <br/> text('select') & column.separatedBy(',') & text('from') tablename & text('where') | select name, age, title, address from person |
