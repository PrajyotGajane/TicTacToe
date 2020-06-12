#!/bin/bash -x
echo "Weclome to Tic Tac Toe Game"
#variables
block=0
count=0
player=0
computer=x
changeTurn=$player
winner=0
playerSwitch=1
position=1
#array declaration
rowSize=3
columnSize=3
declare -A gameBoard
function reset() {
	for (( row=0; row<$rowSize; row++ ))
	do
		for(( column=0; column<$columnSize; column++ ))
		do
			#echo $row
			#echo $column
			gameBoard[$row,$column]="."
		done
	done
}
function whoPlayFirst() {
	turn=$((RANDOM % 2))
	if [ $turn -eq 0 ]
	then
		playerSwitch=0
		echo "Player plays first"
	fi
}
function assignLetter() {
	toss=$((RANDOM % 2))
	if [ $toss -eq 0 ]
	then
		player=x
		computer=o
	fi
}
reset
whoPlayFirst
assignLetter
