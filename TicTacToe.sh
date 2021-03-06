#!/bin/bash -x
echo "Weclome to Tic Tac Toe Game"
#constant

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
#reset
#display
function assignLetter() {
	toss=$((RANDOM % 2))
	if [ $toss -eq 0 ]
	then
		player=x
		computer=o
	fi
}

function whoPlayFirst() {
	turn=$((RANDOM % 2))
	if [ $turn -eq 0 ]
	then
		playerSwitch=0
		echo "Player plays first"
	fi
}
function display() {
	echo "		***TicTacToe gameBoard***"
	echo
	echo
	echo "		     ${gameBoard[0,0]}  |  ${gameBoard[0,1]}  |  ${gameBoard[0,2]}  "
	echo "		   -----------------"
	echo "		     ${gameBoard[1,0]}  |  ${gameBoard[1,1]}  |  ${gameBoard[1,2]}  "
	echo "		   -----------------"
	echo "	 	     ${gameBoard[2,0]}  |  ${gameBoard[2,1]}  |  ${gameBoard[2,2]}  "
	echo
	echo
	echo "		*************************"
}


function playerTurn() {
	echo "Players turn "
	read -p "Enter number between 1 to 9 :" position
	changeTurn=$player
	isEmpty
		case $position in
		1)
			row=0
			column=0
		;;
		2)
			row=0
			column=1
		;;
		3)
			row=0
			column=2
		;;
		4)
			row=1
			column=0
		;;
		5)
			row=1
			column=1
		;;
		6)
			row=1
			column=2
		;;
		7)
			row=2
			column=0
		;;
		8)
			row=2
			column=1
		;;
		9)
			row=2
			column=2
		;;
		*)
		echo "Wrong input"
		;;
	esac
	gameBoard[$row,$column]=$player
	playerSwitch=1
	
}
function computerPlaying() {
 echo "Computers turn:"
 computingToWin
 toBlock
 if [[ $block == 0 ]]
 then
		corners
 fi
 playerSwitch=0
}

function playerSwitch() {
	echo "Player letter is: $player || Computer letter is : $computer"
	if [[ $playerSwitch == 0 ]]
	then
		playerTurn
	else
		computerPlaying
	fi
	echo "Checking winner"
	winningCheck $changeTurn
}


function isEmpty() {
	if [[ $position -ge 1 && $position -le 9 ]]
	then
		row=$(($position / $rowSize))
		if [[ $(($position % $rowSize)) -eq 0 ]]
		then
			row=$(($row-1))
		fi

	
	       column=$(( $position %  $columnSize ))
               if [ $column -eq 0 ]
               then
                  column=$(( $column + 2 ))
               else
                  column=$(( $column - 1 ))
               fi
		if [[ ${gameBoard[$row,$column]} == "." ]]
		then
			echo "		$changeTurn is now at $position"
			((count++))
		else
			echo "Already placed value"
			playerSwitch
		fi
	else
		echo "Invalid value"
		playerSwitch
	fi
}

function winningCheck() {
	local checker=$1
if [[ ${gameBoard[0,0]} == ${gameBoard[1,1]} ]]
	then
		if [[ ${gameBoard[0,0]} == ${gameBoard[2,2]} ]]
		then
			if [[ ${gameBoard[0,0]} == $checker ]]
			then
				winner=1
			fi
		fi
	fi
	if [[ ${gameBoard[0,2]} == ${gameBoard[1,1]} ]]
	then
		if [[ ${gameBoard[0,2]} == ${gameBoard[2,0]} ]]
		then
			if [[ ${gameBoard[0,2]} == $checker ]]
			then
				winner=1
			fi
		fi
	fi
	for (( place=0; place<rowSize; place++ ))
	do
	if [[ ${gameBoard[$place,0]} == ${gameBoard[$place,1]} ]]
	then
		if [[ ${gameBoard[$place,0]} == ${gameBoard[$place,2]} ]]
		then
			if [[ ${gameBoard[$place,0]} == $checker ]]
			then
				winner=1
			fi
		fi
	fi
	if [[ ${gameBoard[0,$place]} == ${gameBoard[1,$place]} ]]
	then
		if [[ ${gameBoard[0,$place]} == ${gameBoard[2,$place]} ]]
		then
			if [[ ${gameBoard[0,$place]} == $checker ]]
			then
				winner=1
			fi
		fi
	fi
	done
}


function computingToWin() {
	for (( row=0;row<rowSize;row++ ))
	do
		for (( col=0;col<columnSize; col++ ))
		do
			if [[ ${gameBoard[$row,$col]} == "." ]]
			then
				gameBoard[$row,$col]=$computer
				winningCheck $computer
				if [[ $winner -eq 1 ]]
				then
					display
					echo "Winner is $computer"
					exit
				else
					gameBoard[$row,$col]="."
					block=0
				fi
			fi
		done
	done
}
function toBlock() {
	for (( row=0;row<rowSize;row++ ))
	do
		for (( col=0;col<columnSize; col++ ))
		do
			if [[ ${gameBoard[$row,$col]} == . ]]
			then
				gameBoard[$row,$col]=$player
				winningCheck $player
				if [[ $winner -eq 1 ]]
				then
					gameBoard[$row,$col]=$computer
					winner=0
					block=1
					((count++))
					display
					break
				else
					gameBoard[$row,$col]="."
				fi
			fi
		done
	done
}

function corners() {
	if [[ ${gameBoard[0,0]} == . ]]
	then
		gameBoard[0,0]=$computer
		local center=1
		((count++))
		break
	elif [[ ${gameBoard[0,2]} == . ]]
	then
		gameBoard[0,2]=$computer
		local center=1
		((count++))
		break
	elif [[ ${gameBoard[2,0]} == . ]]
	then
		gameBoard[2,0]=$computer
		local center=1
		((count++))
		break
	elif [[ ${gameBoard[2,2]} == . ]]
	then
		gameBoard[2,2]=$computer
		local center=1
		((count++))
		break
	fi
	checkCenter

}

function checkCenter() {
		if [[ $center -ne 1 ]]
		then
			if [[ ${gameBoard[1,1]} == . ]]
			then
				gameBoard[1,1]=$computer
				((count++))
			else
				takeSides
			fi
		fi
}

function takeSides() {
	if [[ ${gameBoard[0,1]} == . ]]
	then
		gameBoard[0,1]=$computer
		((count++))
		break
	elif [[ ${gameBoard[1,0]} == . ]]
	then
		gameBoard[1,0]=$computer
		((count++))
		break
	elif [[ ${gameBoard[1,1]} == . ]]
	then
		gameBoard[1,1]=$computer
		((count++))
		break
	elif [[ ${gameBoard[2,1]} == . ]]
	then
		gameBoard[2,1]=$computer
		((count++))
		break
	fi
}

function gameStatus() {
	if [[ $winner -eq 1 ]]
	then
		echo "Winner is $changeTurn"
		exit
	elif [[ $count -ge 9 ]]
	then
		echo "Tie"
	fi	
}

reset
assignLetter
whoPlayFirst
display
while [[ $count -ne 9 ]]
do
	playerSwitch
	#clear
	display
	gameStatus
done
