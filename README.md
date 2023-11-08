## What is this.

A simple package to encode and decode Weakauras2 strings.

Note the Weakauras2 format isn't something specified, and the Weakauras team don't promise they won't change it (and hence break this tool).

I use this to update weakaura packs with my customisations in an automated way that doesn't involve clicking through a lot of GUI options.

## Installation

1. You need a working standalone implementation of [lua](https://www.lua.org/) on your computer.
2. Extract this project to a directory.

## Usage

1. In the directory you extracted it, create a file with the weakauras contents, for example `my_weakaura.txt`.
2. At a command line, run `lua --decode <path_to_wa_string>`, to print the weakaura in a human readable format to standard out.
3. At a command line, run `lua --encode <path_to_human_readable_file>`, to print the weakaura string to standard out.

## Example

Using the contents of testdata, this does a full cycle. It takes a weakaura, converts it to a readable format and then back to a weakaura string again. Finally it turns that new weakaura string back into a readable format and shows they are identical.

```
$ lua --decode testdata/no_pet_wa_string.txt > testdata/no_pet_wa_readable.txt
$ lua --encode testdata/no_pet_wa_readable.txt > testdata/no_pet_wa_string2.txt
$ lua --decode testdata/no_pet_wa_string2.txt > testdata/no_pet_wa_readable2.txt
$ diff -s testdata/no_pet_wa_readable.txt testdata/no_pet_wa_readable2.txt 
Files testdata/no_pet_wa_readable.txt and testdata/no_pet_wa_readable2.txt are identical
```

## Fully worked example.

To take the contents of the TEMS ICC pack, and change all instances of the font "KMT-GothamXN_Ultra" to "Fira Sans Black".

```
$ lua --decode testdata/tems_wa.txt | sed 's/KMT-GothamXN_Ultra/Fira Sans Black/g | lua --encode - > testdata/tems_wa_font_changed_string.txt
$ lua --encode testdata/tems_wa_font_changed_string.txt > tems_wa_font_changed_string.txt
$ cat tems_wa_font_changed_string.txt
```

## Bugs

A string taken from wago or in game, converted to human readable format and then back again, is changed in the process. 

This is almost certainly due to LibInspect adding human readable spacing, tabs etc, but I have not yet had time to prove this. As this program is sufficient for my purposes I am unlikely to do so without sufficient motivation.
