#! /bin/sh


# Variables

# Define variable without any spaces between the = sign
var="Hello World"
echo $var

# To get the user input use read 'variable' name
echo "what is your name?"
#read name
echo "How do you do, $name?"
#read remark
echo "I am $remark too!"

# We can use \ to escape special characters and use ${} to avoid ambiguity
APPLE_COST=5

echo "Cost for the apple is \$ $APPLE_COST"
echo "Cost for the apple is \$ ${APPLE_COST}"

# Encapsulating the variable name with "" will preserve any white space values
greetings="Hello      World!"
echo "$greetings"

# Variables can be assigned with the value of a command output. This is referred to as substitution.
# Substitution can be done by encapsulating the command with `` (known as back-ticks) or with $()
FILELIST=`ls`
#FileWithTimeStamp=/tmp/my-dir/file_$(/bin/date +%Y-%m-%d).txt
echo $FILELIST

# To get the date
date
echo `date -d "$date1" +%A`

#Arguments can be passed to the script when it is executed, by writing them as a space-delimited list following the script file name.
#Inside the script, the $1 variable references the first argument in the command line, $2 the second argument and so forth. 
#The variable $0 references to the current script. In the following example, the script name is followed by 6 arguments.
echo "This will print the first argument: ${1} with the file run command: ${0}"


# Arrays


my_array=(apple banana "Fruit Basket" orange 1 2 3 5)
echo "${my_array[*]} or to get the size: ${#my_array[@]}"
my_array[4]="carrot" # assign values to the index
echo ${my_array[*]}
echo ${my_array[6]}


# Mathematical Operations

a=10
b=20
echo $(($a + $b * 20 + 20))
echo $(($a % $b))
echo $(($a / $b))
echo $(($a ** $b))
echo $(($a - $b))

 

# String operations

STRING="this is a string"
echo ${#STRING}  # get the no. of chars in the string

STRING="this is a string"
SUBSTRING="g"
expr index "$STRING" "$SUBSTRING"     # 1 is the position of the first 't' in $STRING

# Substring extraction
STRING="this is a string"
POS=6
LEN=16
echo ${STRING:$POS:$LEN} # its like the python slicing of strings. 

# If :$LEN is omitted, extract substring from $POS to end of line
STRING="this is a string"
echo ${STRING:1}           # $STRING contents without leading character
echo ${STRING:12}          # ring

# Substring Replacement
STRING="to be or not to be"

STRING="to be or not to be"
echo ${STRING[@]/be/eat}        # to eat or not to be

# replace all occurances
STRING="to be or not to be"
echo ${STRING[@]//be/eat}        # to eat or not to eat

# and lot more other string operations.... google the shit if needed


# if else 

# Syntax: if [ expression ]; then
a=25
b=20
if [[ $a -gt $b && $a -eq 25 ]]  ; then # there is also || for or and ! for not equal to, etc. 
    echo "The value of a is greater than 10 which is ${a}"
elif [ $a -eq 25 ]; then
    echo "Same bro"
else
    echo "Man oh man"
fi


# Switch case

echo "Choose between 1-4, 5 to exit: "
read mycase
case $mycase in
    1) echo "You selected bash";;
    2) echo "You selected perl";;
    3) echo "You selected phyton";;
    4) echo "You selected c++";;
    5) exit
esac


# Loops

# For loop
NAMES=(Joe Jenny Sara Tony 5 6 9)
for N in ${NAMES[*]} ; do
  echo "My name is $N"
done

# While loop
COUNT=4
while [ $COUNT -gt 0 ]; do
  echo "Value of count is: $COUNT"
  COUNT=$(($COUNT - 1))
done

# Untill loop opposite of while
COUNT=1
until [ $COUNT -gt 5 ]; do
  echo "Value of count is: $COUNT"
  COUNT=$(($COUNT + 1))
done


# break and continue statement

COUNT=0
while [ $COUNT -ge 0 ]; do
  echo "Value of COUNT is: $COUNT"
  COUNT=$((COUNT+1))
  if [ $COUNT -ge 5 ] ; then
    break
  fi
done

# Prints out only odd numbers - 1,3,5,7,9
COUNT=0
while [ $COUNT -lt 10 ]; do
  COUNT=$((COUNT+1))
  # Check if COUNT is even
  if [ $(($COUNT % 2)) = 0 ] ; then
    continue
  fi
  echo $COUNT
done


# Functions

function function_B {
  echo "Function B"
}
function function_A {
  echo "$1" # $1 implies first argument and so on...
}
function adder {
  echo "$(($1 + $2))" 
}

# FUNCTION CALLS
# Pass parameter to function A
function_A "Function A"     # Function A.
function_B                   # Function B.
# Pass two parameters to function adder
adder 12 56                  # 68

# Special Variables
# $0 - The filename of the current script.|
# $n - The Nth argument passed to script was invoked or function was called.|
# $# - The number of argument passed to script or function.|
# $@ - All arguments passed to script or function.|
# $* - All arguments passed to script or function.|
# $? - The exit status of the last command executed.|
# $$ - The process ID of the current shell. For shell scripts, this is the process ID under which they are executing.|
# $! - The process number of the last background command.


echo $# 
echo $0
echo $$

echo "Script Name: $0"
function func {
    for var in $*
    do
        let i=i+1
        echo "The \$${i} argument is: ${var}"
    done
    echo "Total count of arguments: $#"
}

func we are argument

# $@ and $* have different behavior when they were enclosed in double quotes.
function func {
    echo "--- \"\$*\""
    for ARG in "$*"
    do
        echo $ARG
    done

    echo "--- \"\$@\""
    for ARG in "$@"
    do
        echo $ARG
    done
}
func We are argument


# Bash# traptest.sh
# notice you cannot make Ctrl-C work in this shell, 
# try with your local one, also remeber to chmod +x 
# your local .sh file so you can execute it!

# trap "echo  Ctrl+Z to quit!" SIGINT SIGTERM
# echo "it's going to run until you hit Ctrl+Z"
# echo "hit Ctrl+C to be blown away!"

# a=1
# while [ $a -eq 1 ]; do        
#     sleep 60       
# done 

function booh {
    echo "ctrl + z to quit"
}

trap booh SIGINT SIGTERM

# check out all signal types by entering the following command
kill -l
# SIGINT: user sends an interrupt signal (Ctrl + C)
# SIGQUIT: user sends a quit signal (Ctrl + C)
# SIGFPE: attempted an illegal mathematical operation

#2 corresponds to SIGINT and 15 corresponds to SIGTERM
trap booh 2 15

#one of the common usage of trap is to do cleanup temporary files:
trap "rm -f folder; exit" 2

# File Testing

# use "-e" to test if file exist
filename="sample.md"

if [ -e "$filename" ]; then
    echo "$filename exists as a file"
fi

# use "-d" to test if directory exists
directory_name="test_directory"
if [ -d "$directory_name" ]; then
    echo "$directory_name exists as a directory"
fi

# use "-r" to test if file has read permission for the user running the script/test
filename="sample.md"
if [ ! -f "$filename" ]; then
    touch "$filename"
fi
if [ -r "$filename" ]; then
    echo "you are allowed to read $filename"
else
    echo "you are not allowed to read $filename"
fi

