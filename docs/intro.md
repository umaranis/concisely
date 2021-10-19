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
| char(c) | parses a character based on the given pattern | `char('a')` - parses 'a' <br/> `char('ab')` - parses character 'a' or 'b' <br/> `char('a-z')` or `lowercase` - parsers any character from 'a' to 'z' <br/> `char('A-Z')` or `uppercase` - parses any character from 'A' to 'Z' <br/> `char('a-zA-z')` or `letter` - parses any alphabet character <br/> `char('0-9')` or `digit` - parses any character from '0' to '9' <br/> |
| except(c) | parses a character if it doesn't match the given pattern | `except('a')` - parses any character expcet 'a' <br/> `except('a-c')` - parses any character except 'a', 'b' and 'c' <br/> <code>except('a-c' &#124; newline)</code> - parses any character except 'a', 'b', 'c' and newline |
| newline | parses a new line | `newline` - parses '\n', '\r' or '\r\n' |
| whitespace | parses space, tab or newline | `whitespace` - parses ' ', '\t' or newline |

**String parsers**: match a string of characters from the input

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| text(t) | parses any string of characters exactly matching the given string | `text('hello world!')` - parses 'hello world!' <br/> `'hello world!'.p`  - same as above (.p converts text into a parser)  |

**Combining parsers**: combine parsers to create more complex parsers

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| & | combines parsers in a sequence | `char('a') & char('b')` - parses 'ab' <br/> `'item'.p & digit` - parser 'item1', 'item2', 'item3' etc. |
| &#124; | combines parsers with Choice operator. <br/>Returns the result of first parser if it's successful otherwise second. | <code>'hello'.p &#124; 'welcome'.p</code> - parses 'hello' or 'welcome' |
| + | same as '&' but trim any whitespace between the two parsers  | `'Hello' && 'World!'` - parsers 'Hello World!' (also 'HelloWorld!')

**Repeating parsers**: repeat a parser a number of times

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| .many | repeat a parser one or more times | `char('a').many` - parses one or more a's like 'a' or 'aaa' |
| .zeroOrMore | repeat a parser zero or more times | `char('a').zeroOrMore` - parses zero or more a's like 'a' or 'aaa' or empty string |
| .optional | parses zero or one time  | `char('a').optional` - parses zero or one 'a' like 'a' or empty string |
| .times(t) | repeat a parser given number of times  | `char('a').times(4)` - parses 'aaaa' |
| .repeat(min, max) | repeat a parser between min and max times (both inclusive)  | `char('a').repeat(2,4)` - parses 'aa' or 'aaa' or 'aaaa' |
| .repeat(t) | repeat a parser at least given number of times  | `char('a').repeat(2)` - parses 'a' two or more times like 'aa' or 'aaaaa' |
| .separatedBy(s) | parsers a list of item separated by the given separator. <br/> Igonres whitespace on either side of the separator  | `digit.many.separatedBy(',')` - parses '1, 2, 3' to a list of 3 digits

**Lookahead parsers**: match a parser without comsuming input

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| if(p) | doesn't consume any input, successful if able to parse p | `if('a') & letter.many` - parses a word if it starts with 'a' like 'aero' (it is equivalent to char('a') & letter.zeroOrMore <br/> `char('a') & if('b')` - parses 'a' if the next character is 'b' <br/> `'http'.p & if('://')` - parses http if succeeded by '://' <br/> `char('a') & if(char('a-f))` - parses 'a' if next character is between 'a' and 'f' |
| ifNot(p) | doesn't consume any input, successful if not able to parse p | `ifNot('a') & letter.many` - parses a word if it doesn't start with 'a' like 'bake' <br/> `char('a') & ifNot('b')` - parses 'a' if the next character is not 'b' |

**Tranforming parsers**: transform result of a parser

| Parser | Description | Examples |
| ------ | ----------  | -------- |
| \> string | transform the result into a string | `char('a').many > string` - parses 'aaaa' into ['a','a','a','a'] which string transformer will transform to 'aaaa' <br/> `char('a').many & char('b').many > string` - parses 'aabb' into [['a','a'],['b','b']] which list transformer will transform to 'aabb'  |
| \> list | transform the result into a list from a tree | `char('a').many & char('b').many > list` - parses 'aabb' into [['a','a'],['b','b']] which list transformer will transform to ['a','a','b','b'] |

# Parsing Examples

| Example | Parser | Sample Text |
| ------ | ----------  | -------- |
| Sql Select | 'select'.p && column.separatedBy(',') & 'from'.p tablename & 'where'.p <br/> text('select') & column.separatedBy(',') & text('from') tablename & text('where') | select name, age, title, address from person |
