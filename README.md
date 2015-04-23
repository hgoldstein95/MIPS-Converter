# MIPS-Converter
A simple converter from MIPS Assembly instructions to bytecode (in binary).

## Usage
Simply run:
```
ruby mips_convert.rb [filename]
```

Optionally, add an output file:
```
ruby mips_convert.rb [filename] > [output file]
```

## Output
The output, consisting of 16-bit binary strings, takes two forms.

### Register-To-Register Instructions
| 15:12 | 11:9 | 8:6 | 5:3 | 2:0 |
|-------|------|-----|-----|-----|
| OP    | RS   |  RT | RD  |FUNCT|

### Immediate Instructions
| 15:12 | 11:9 | 8:6 | 5:0 |
|-------|------|-----|-----|
| OP    | RS   |  RT | IMM |

## Disclaimer
This is simply a test tool I threw together for one of my classes. I make no guarantees that it does not have bugs. Also, this has **not** been tested with BRANCH operations yet.
