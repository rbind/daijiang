---
title:  Notes about strings handling in R
date: '2013-11-30'
slug: notes-string-in-r
---

Here is just my note about R functions that I do not know/remember for strings handling. 

## Reading tables/text
`read.table()`: main function to read file in table format  
`read.csv()`: reads csv files separated by a comma ","  
`read.csv2()`: reads csv files separated by a semicolon ";"  
`read.delim()`: reads files separated by tabs "\t"  
`read.delim2()`: similar to read.delim()  
`read.fwf()`: read fixed width format files  
`readLines()`:  

## Printing
`print()`: generic printing  
`noquote()`: print with no quotes  
`cat()`: concatenation, it also has `sep=` argument as well as `fill=`.  
`format()`: special formats  
`toString()`: convert to string  
`sprintf()`: printing  

## string manipulations
`nchar()`: number of characters  
`tolower()`: convert to lower case  
`toupper()`: convert to upper case  
`casefold()`: case folding  
`chartr()`: character translation  
`abbreviate()`: abbreviation  
`substring()`: substrings of a character vector  
`substr()`: substrings of a character vector  

## set operations
`union()`: set union  
`intersect()`: intersection  
`setdiff()`: set difference  
`setequal()`: equal sets  
`identical()`: exact equality  
`is.element()`: is element  
`%in%()`: contains  
`sort()`: sorting  
`paste(rep())`: repetition  

## better to know regular expression
`\\d`: match a digit character  
`\\D`: match a non-digit character  
`\\s`: match a space character  
`\\S`: match a non-space character  
`\\w`: match a word character  
`\\W`: match a non-word character  
`\\b`: match a word boundary  
`\\B`: match a non-(word boundary)  
`\\h`: match a horizontal space  
`\\H`: match a non-horizontal space  
`\\v`: match a vertical space  
`\\V`: match a non-vertical space  

`grep()`
`gsub()`

### Escaping special characters in R
`.`: the period or dot.           Esape in R by `\\.`  
`$`: the dollar sign.             Esape in R by `\\$`  
`*`: the asterisk or star.        Esape in R by `\\*`  
`+`: the plus sign.               Esape in R by `\\+`  
`?`: the question mark.           Esape in R by `\\?`  
`|`: the vertical bar.            Esape in R by `\\|`  
`\`: the backslash .            Esape in R by  `\\\\`  
`^`: the caret.                   Esape in R by `\\^`  
`[`: the opening square bracket.  Esape in R by `\\[`  
`]`: the closing square bracket.  Esape in R by `\\]`  
`{`: the opening curly bracket.  Esape in R by  `\\{`  
`}`: the closing curly bracket.  Esape in R by  `\\}`  
`(`: the opening round bracket.  Esape in R by  `\\(`  
`)`: the closing round bracket.  Esape in R by  `\\)`  

## `stringr` package is a must have one


## Examples

```r
data(USArrests)
head(USArrests)
```

```
##            Murder Assault UrbanPop Rape
## Alabama      13.2     236       58 21.2
## Alaska       10.0     263       48 44.5
## Arizona       8.1     294       80 31.0
## Arkansas      8.8     190       50 19.5
## California    9.0     276       91 40.6
## Colorado      7.9     204       78 38.7
```

```r
states=rownames(USArrests)
states
```

```
##  [1] "Alabama"        "Alaska"         "Arizona"        "Arkansas"      
##  [5] "California"     "Colorado"       "Connecticut"    "Delaware"      
##  [9] "Florida"        "Georgia"        "Hawaii"         "Idaho"         
## [13] "Illinois"       "Indiana"        "Iowa"           "Kansas"        
## [17] "Kentucky"       "Louisiana"      "Maine"          "Maryland"      
## [21] "Massachusetts"  "Michigan"       "Minnesota"      "Mississippi"   
## [25] "Missouri"       "Montana"        "Nebraska"       "Nevada"        
## [29] "New Hampshire"  "New Jersey"     "New Mexico"     "New York"      
## [33] "North Carolina" "North Dakota"   "Ohio"           "Oklahoma"      
## [37] "Oregon"         "Pennsylvania"   "Rhode Island"   "South Carolina"
## [41] "South Dakota"   "Tennessee"      "Texas"          "Utah"          
## [45] "Vermont"        "Virginia"       "Washington"     "West Virginia" 
## [49] "Wisconsin"      "Wyoming"
```

```r
noquote(states) # noquote()
```

```
##  [1] Alabama        Alaska         Arizona        Arkansas      
##  [5] California     Colorado       Connecticut    Delaware      
##  [9] Florida        Georgia        Hawaii         Idaho         
## [13] Illinois       Indiana        Iowa           Kansas        
## [17] Kentucky       Louisiana      Maine          Maryland      
## [21] Massachusetts  Michigan       Minnesota      Mississippi   
## [25] Missouri       Montana        Nebraska       Nevada        
## [29] New Hampshire  New Jersey     New Mexico     New York      
## [33] North Carolina North Dakota   Ohio           Oklahoma      
## [37] Oregon         Pennsylvania   Rhode Island   South Carolina
## [41] South Dakota   Tennessee      Texas          Utah          
## [45] Vermont        Virginia       Washington     West Virginia 
## [49] Wisconsin      Wyoming
```

```r
# print without quotes & no line indicators, fill=.
cat(states, sep="-", fill=40) 
```

```
## Alabama-Alaska-Arizona-Arkansas-
## California-Colorado-Connecticut-
## Delaware-Florida-Georgia-Hawaii-Idaho-
## Illinois-Indiana-Iowa-Kansas-Kentucky-
## Louisiana-Maine-Maryland-Massachusetts-
## Michigan-Minnesota-Mississippi-Missouri-
## Montana-Nebraska-Nevada-New Hampshire-
## New Jersey-New Mexico-New York-
## North Carolina-North Dakota-Ohio-
## Oklahoma-Oregon-Pennsylvania-
## Rhode Island-South Carolina-
## South Dakota-Tennessee-Texas-Utah-
## Vermont-Virginia-Washington-
## West Virginia-Wisconsin-Wyoming
```

```r
abbreviate(states,minlength=5) # abbreviate() 
```

```
##        Alabama         Alaska        Arizona       Arkansas     California 
##        "Alabm"        "Alask"        "Arizn"        "Arkns"        "Clfrn" 
##       Colorado    Connecticut       Delaware        Florida        Georgia 
##        "Colrd"        "Cnnct"        "Delwr"        "Flord"        "Georg" 
##         Hawaii          Idaho       Illinois        Indiana           Iowa 
##        "Hawai"        "Idaho"        "Illns"        "Indin"         "Iowa" 
##         Kansas       Kentucky      Louisiana          Maine       Maryland 
##        "Kanss"        "Kntck"        "Lousn"        "Maine"        "Mryln" 
##  Massachusetts       Michigan      Minnesota    Mississippi       Missouri 
##        "Mssch"        "Mchgn"        "Mnnst"        "Mssss"        "Missr" 
##        Montana       Nebraska         Nevada  New Hampshire     New Jersey 
##        "Montn"        "Nbrsk"        "Nevad"        "NwHmp"        "NwJrs" 
##     New Mexico       New York North Carolina   North Dakota           Ohio 
##        "NwMxc"        "NwYrk"        "NrthC"        "NrthD"         "Ohio" 
##       Oklahoma         Oregon   Pennsylvania   Rhode Island South Carolina 
##        "Oklhm"        "Oregn"        "Pnnsy"        "RhdIs"        "SthCr" 
##   South Dakota      Tennessee          Texas           Utah        Vermont 
##        "SthDk"        "Tnnss"        "Texas"         "Utah"        "Vrmnt" 
##       Virginia     Washington  West Virginia      Wisconsin        Wyoming 
##        "Virgn"        "Wshng"        "WstVr"        "Wscns"        "Wymng"
```

```r
month.name # month names
```

```
##  [1] "January"   "February"  "March"     "April"     "May"      
##  [6] "June"      "July"      "August"    "September" "October"  
## [11] "November"  "December"
```

```r
library(stringr)
str_detect(string=states, pattern="k")
```

```
##  [1] FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
## [23] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
## [34]  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [45] FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
positions_a = gregexpr(pattern = "a", text = states, ignore.case = TRUE) # gregexpr()
states[1]
```

```
## [1] "Alabama"
```

```r
positions_a[[1]]
```

```
## [1] 1 3 5 7
## attr(,"match.length")
## [1] 1 1 1 1
## attr(,"useBytes")
## [1] TRUE
```

```r
str_locate_all(string = states, pattern = "[Aa]")[[1]]
```

```
##      start end
## [1,]     1   1
## [2,]     3   3
## [3,]     5   5
## [4,]     7   7
```

```r
str_count(states, "[Aa]")
```

```
##  [1] 4 3 2 3 2 1 0 2 1 1 2 1 0 2 1 2 0 2 1 2 2 1 1 0 0 2 2 2 1 0 0 0 2 2 0
## [36] 2 0 2 1 2 2 0 1 1 0 1 1 1 0 0
```

```r
'The "R" project for statistical computing'
```

```
## [1] "The \"R\" project for statistical computing"
```

```r
length("")  # length 1
```

```
## [1] 1
```

```r
length(character(0)) # length 0
```

```
## [1] 0
```

```r
format(13.7, nsmall=3) # format for pretty print
```

```
## [1] "13.700"
```

```r
format(c(6, 13.1), digits = 2)
```

```
## [1] " 6" "13"
```

```r
format(c(6, 13.1), digits = 2, nsmall = 1)
```

```
## [1] " 6.0" "13.1"
```

```r
format(c("A", "BB", "CCC"), width = 5, justify = "centre") # justify only for char.
```

```
## [1] "  A  " " BB  " " CCC "
```

```r
format(c("A", "BB", "CCC"), width = 5, justify = "left")
```

```
## [1] "A    " "BB   " "CCC  "
```

```r
format(c("A", "BB", "CCC"), width = 5, justify = "none")
```

```
## [1] "A"   "BB"  "CCC"
```

```r
format(123456789, big.mark = ",") # big.mark
```

```
## [1] "123,456,789"
```

```r
crazy = c("Here's to the crazy ones", "The misfits", "The rebels")
chartr("aei", "#!?", crazy)
```

```
## [1] "H!r!'s to th! cr#zy on!s" "Th! m?sf?ts"             
## [3] "Th! r!b!ls"
```

```r
y = c("may", "the", "force", "be", "with", "you")
substr(y, 2, 3) <- ":)"
y
```

```
## [1] "m:)"   "t:)"   "f:)ce" "b:"    "w:)h"  "y:)"
```

```r
str_sub(string = y, start = 2, 3) <- "-("
y
```

```
## [1] "m-(" "t-(" "f-(" "b-(" "w-(" "y-("
```

```r
paste(rep("x", 4), collapse = "")
```

```
## [1] "xxxx"
```

```r
str_pad("hashtag", width = 9, side = "both", pad = "-")
```

```
## [1] "-hashtag-"
```

```r
change = c("Be the change", "you want to be")
word(change, 1)
```

```
## [1] "Be"  "you"
```

```r
word(change, 2, -1)
```

```
## [1] "the change" "want to be"
```


```r
toString(17.04)
```

```
## [1] "17.04"
```

```r
toString(c(17.04, 1978))
```

```
## [1] "17.04, 1978"
```

```r
toString(c("Bonjour", 123, TRUE, NA, log(exp(1))))
```

```
## [1] "Bonjour, 123, TRUE, NA, 1"
```

```r
toString(c("one", "two", "3333333333"), width = 8)
```

```
## [1] "one,...."
```

