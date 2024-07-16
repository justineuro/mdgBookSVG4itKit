#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg42midit+svg.sh (minuets)
#
#	USAGE:	mdg42midit+svg.sh.sh n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 
#
#		where n1-n16 are any of the 11 possible outcomes of a toss of
#		two ordinary six-sided dice, e.g., n1-n16 are 16 integers, not necessarily 
#		unique, chosen from the set {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
#
# DESCRIPTION:	Used for generating ABC, MIDI, and SVG files of a particular 
#		Musical Dice Game (MDG) minuet based on Joseph Haydn's
#		"Gioco Filarmonico" arranged for a trio of instruments
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.0
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2024/07/03 15:49:37
#    REVISION:	
#==================================================================================

#----------------------------------------------------------------------------------
# declare the variables "diceS" and "measNR" as arrays
# diceS - array containing the 16 outcomes from input line
# measNR - array of all possible measure notes for a specific outcome
#----------------------------------------------------------------------------------
declare -a diceS measNR
#----------------------------------------------------------------------------------
# input 16-sequence of tosses as given in the command line
#----------------------------------------------------------------------------------
diceS=( $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} )

#----------------------------------------------------------------------------------
# input rule table to determine corresponding G/F measures for each toss outcome
#----------------------------------------------------------------------------------
ruletab() {
	case $1 in
	2) measNR=(96 22 141 41 105 122 11 30 70 121 26 9 112 49 109 14);;
	3) measNR=(32 06 128 63 146 46 134 81 117 39 126 56 174 18 116 83);;
	4) measNR=(69 95 158 13 153 55 110 24 66 139 15 132 73 58 145 79);;
	5) measNR=(40 17 113 85 161 2 159 100 90 176 7 34 67 160 52 170);;
	6) measNR=(148 74 163 45 80 97 36 107 25 143 64 125 76 136 1 93);;
	7) measNR=(104 157 27 167 154 68 118 91 138 71 150 29 101 162 23 151);;
	8) measNR=(152 60 171 53 99 133 21 127 16 155 57 175 43 168 89 172);;
	9) measNR=(119 84 114 50 140 86 169 94 120 88 48 166 51 115 72 111);;
	10) measNR=(98 142 42 156 75 129 62 123 65 77 19 82 137 38 149 8);;
	11) measNR=(3 87 165 61 135 47 147 33 102 4 31 164 144 59 173 78);;
	12) measNR=(54 130 10 103 28 37 106 5 35 20 108 92 12 124 44 131);;
	esac
}

#----------------------------------------------------------------------------------
# input notes
# declare variables "notesG" and "notesF" as arrays
# notesG - array that contains the possible treble clef notes per measure
# notesF - array that contains the possible bass clef notes per measure
#----------------------------------------------------------------------------------
declare -a notesGf notesGv notesF

#----------------------------------------------------------------------------------
# define notesGf, array of 176 possible treble clef notes for flute1/violin1
#----------------------------------------------------------------------------------
notesGf=( "afegce" "z !wedge!E(^GA)(ce)" "d2d2d2" "e3/B/A3/B/ G2" "A6" "gdbg a2" "(_BA) A3a" "d6" " aAgGf2" "G2 ge {g/}fe/d/" "fe/d/ c2!trill!B2" "{B}b2b/a/g/f/ e/d/c/B/" "a3gf2" "d6" "A/B/c/B/ A a2 c" "B4 b/a/g/f/" " (^d/e3/) (a/c3/)(d/A3/)" "(a/f/)(c/d/) A2 z2" "(ce)z !wedge!e (d/c/B/A/)" "(ef)(=ga)b2" "BfedcB" "!trill!g3/f/4g/4 ef f2" "B/b/a/g/ f2!trill!e2" "A6" " A2 a/=g/f/e/ ^d2" "g3/b/ e3/g/ c3/e/" "Bbgfed" "fd^ABcd" "(de) (fg)a2" "A6" "c4d2" "f3/g/ e3/f/ d2" " A6" "ad c/d/e/c/ d2" "a3/=c'/ f3/a/ ^d3/f/" "f/a/f/d/ c2 !trill!B2" "e3/a/ c3/e/ A3/a/" "afgefd" "z!wedge!b z !wedge!^d z !wedge!e" "d4 b/a/^g/a/" " !wedge!c2!wedge!e2!wedge!a2" "B3/d/ c3/e/ d3/f/" "B/d/c/B/ ce d2" "A3/d/ f2!trill!e2" "c/e/d/c/ {e/}dc/B/ c2" "cdef^ga" "c/d/B/^G/ Ed c2" "G2g2e2" " A2c'2d'2" "cd e/d/e/f/ d2" "B3/d/ g3/d/ b2" "b/f/g/e/ d2!trill!c2" "(dc) !wedge!e!wedge!cd2" "DA Fd Af" "zcdefe" "d2 e/d/e/g/ f2" " G2 g/f/e/d/ c2" "(a2a/)g/f/g/ f2" "Aa!trill!ag!trill!gf" "A3/c/e3/g/f2" "A2G2F2" "(3ea^g (3fed (3cdB" "c2e/d/B/^G/A2" "A4 a/=g/f/e/" " B/c/^d/c/ Bb2^d" "(^df) z!wedge!f (e/d/)(!wedge!c/!wedge!B/)" "(B/c3/) !trill!d4" "(E2E/)F/^G/A/ B/c/d/e/" "a4 g/f/e/d/" "b4f2" "bBaB =g2" "Bbagfe" " G2 Bdgb" " dcac d2" "| f3/a/ d3/f/ A3/f/" "z b z g z e" "eB A=G FE" "d6" "d6" "(d2 (3d)fe (3dcB" " A6" "z!wedge!a z!wedge!c z!wedge!d" "d6" "a3/b/ g3/a/ f2" "(d2c/)B/c/d/e2" "d3/f/2 B3/d/ c2" "a2 a/g/f/e/ f2" "be ^d/e/f/d/ e2" " z !wedge!^d(eg)(ce)" "A2a2f2" "A6" "d3/f/ e3/g/ f2" "d6" "A6" "d2 e/f/g/2e/ f2" "a3/d'/ f3/a/ d3/f/" " z/E/F/^G/ A/B/c/d/ e/f/g/a/" "d2(c/d3/)(c/d3/)" "f2 {e}d2 {c}B2" "A6" "(3bfg (3bfg (3bge" "a4 gf" "ce^GB A2" "d'2 d'/c'/b/a/ g/f/e/d/" " (3^gab d2d2" "a/f/e/d/ c2!trill!B2" "A6" "a4c2" "(3Bgb (3agf (3edc" "(3Ace g2 f3/d/" "d6" "d3/g/ !trill!g3/f/4g/4 b2" " e/f/g/e/ fa{g/}f{e/}d" "!trill!a3/g/4a/4 bGge" "A3/d/f3/d/ a2" "(3gbg f2!trill!e2" "^d4d2" "z!wedge!^A(Bd)(^GB)" "d4c/d/e/c/" "(=cB)c3b" " e3/=g/f3/a/ g2" "e3/a/ f3/a/ e3/a/" "A6" "A/B/c/d/ e/f/g/e/ f2" "ef d4" "g4fe" "A6" "z!wedge!B(^de)(gb)" " ae{f/}ed{e/}dc" "(3e^ga A2z2" "d6" "d/A/B/c/ d/e/f/g/ a2" "(3ea^g (3fed (3cBA" "a2 !trill!=gf!trill!ed" "^G3/B/ e3/B/ ^g3/e/" "(A2A/)B/c/d/ e/f/g/a/" " z!wedge!B(^de)(gb)" "Aa=gfe^d" "f/e/^d/e/ B4" "d4bd" "z2 (3fag (3fed" "!trill!a3/g/4a/4 b3/g/ f2" "(3eBe (3geg b2" "e/d/c/d/ B2 z2" " f/e/g/e/ d2c2" "z!wedge!F(^AB)(df)" "(3Ace =g3/e/ f3/d/" "d2 e/d/e/f/ d2" "B/^d/e/g/ b2c2" "Ggfedc" "d6" "(3afd A2d2" " ^GddccB" "zf{g/}fe{f/}ed" "e2f/e/f/a/ g2" "(d2c2)d2" "(Bd)!wedge!g!wedge!ba2" "B2(3bag (3fed" "c/B/d/B/ A2^G2" "(3Gge (3ceG F2" " (3dcd (3b^ge (3bgd" "cgfe {e/}dc/d/" "d2 !trill!e3/d/4e/4 f2" "d3/A/G3/A/ F2" "a2a2 g/f/e/d/" "!wedge!d!wedge!A!wedge!G!wedge!F!wedge!E!wedge!D" "aAgG F2" "z!wedge!A(cd)(fa)" " E3/A/ c2!trill!B2" "d6" "g2 {a/}gf/e/ {g/}fe/d/" "d6" "(B/e/)!wedge!g/!wedge!e/ a2!trill!c2" "z d!trill!dc!trill!cB" "e/d/c/d/ A4" "f=g e4" )

#----------------------------------------------------------------------------------
# define notesGv, array of 176 possible treble clef notes for flute2/violin2
#----------------------------------------------------------------------------------
notesGv=( "d2B2G2" "z2 E2A2 " "F2F2F2" "E2^D2E2" "A6" "d4d2" "z2 E2E2" "d6" " d2c2d2" "E2A2A2" "dc/B/ A2!trill!^G2" "d2d2 z2" "f3ed2" "d6" "z2E2E2" "(3^DFB (3^DFB (3^DFB " " z2 A4" "z2 (3 FAd(3 FAd" "z2 A2A2" "(e^d) (ed) e2" "BdcBA^G" "A2A2A2" "d2d2!trill!c2" "A6" " ^D2z2F2" "z2B2G2" "d6" "A2F2z2" "(dc) (dc)d2" "A6" "E4F2" "A3/B/2G3/A/ F2" "A6" "A6" "=c2A2F2" "dB A2^G2" "c2A2c2" "d2c2B2" "GzAzBz" "(3DFA (3DFA (3DFA" " (3zEA (3zEA (3zEA" "E2G2A2" "G2E2F2" "F2d2!trill!c2" "A/c/B/A/ {c}BA/^G/ A2" "ABcdBc" "z2E2E2" "E2e2c2" " A2e2f2" "GF G/F/G/A/ F2" "d4d2" "d3/e/ d2!trill!c2" "z2G2F2" "DF DA Fd" "zABcdc" "z2c2d2" " E2z2E2" "z2c2d2" "d2c2d2" "A4A2" "F2E2D2" "(3cce (3dcB (3AB^G" "E2^G2A2" "(3zEA (3zEA (3zEA" " z2^D2F2" "z2B2B2" "(3GBd (3GBd (3GBd" "z2E2E2" "F2D2F2" "^d4d2" "e2^d2e2" "Bgfedc" " G3 Bdg" "A4A2" "F2A2F2" "zB zG zE" "eB AG FE" "d6" "d6" "(B2(3B)dc (3BA^G" " A6" "Fz Gz Az" "d6" "f3/g/ e3/f/ d2" "(B2A/)^G/A/B/ c2" "E4E2" "(3zEA (3zEA (3zEA" "B6" "B4G2" "F2f2^d2" "A6" "A4A2" "d6" "A6" "A4A2" "A3/d/ F3/A/ D3/F/" "E2z2z2" "F2A2A2" "(3DFB (3DFB (3DFB" "A6" "e2z2z2" "f4 e^d" "AcB^G A2" "f2a2z2" " z2 B2B2" "A4!trill!^G2" "A6" "c4c2" "(3GBG (3FGA (3GFE" "z2 A2A2" "d6" "dz dz dz" " A2A2z2" "d2d2z2" "D3/F/A3/F/ f2" "(3Bge d2 !trill!c2" "F4F2" "F4D^G" "F4 E/F/G/E/" "z2F2F2" "B4B2" "A4A2" "A6" "z2A2A2" "(3DFA (3DFA (3DFA" "e4dc" "A6" "E4(BG)" 
"A2^G2A2" "z2E2E2" "d6" "d/F/G/A/ B/c/d/e/ f2" "A2z2z2" "A2!trill!gf!trill!ed" "z2^G2B2" "z2E2D2" " z2B2e2" "z2=c2c2" "z2 (3=GBe (3GBe" 
"B,2^G2dB" "(3FAd z2z2" "E2g3/c/ d2" "B2B2G2" "z2(3GBd (3GBd" "A3/G/ F2E2" "z2F2B2" "z2A2A2" "F2G2F2" "B2G2E2" "z2_B2B2" "d6" "F2D2F2" 
"z2D2D2" "A4F2" "z2^d2e2" "(F2E2)F2" "d4d2" "D4z2" "c/B/d/B/ A2^G2" "z2E2D2" 
"^G2B2d2" "BEAG F2" "A2A2A2" "A4A2" "DAFADA" "!wedge!F,!wedge!A,!wedge!G,!wedge!F,!wedge!E,!wedge!E," "d2c2d2" "z2A2B2" 
"E3/A/A2^G2" "d6" "d2e2A2" "d6" "B3/g/ f2!trill!e2" "D4D2" "z2(3FAd (3FAd" "(3E=GB (3EGB (3EGB" )

#----------------------------------------------------------------------------------
# define notesF, array of 176 possible bass clef notes
#----------------------------------------------------------------------------------
notesF=( "F,2G,2A,2" "C,6" "D,2 F,A, D2" "G,2F,2E,2" "A,,C,E,A,A,,2" "B,2G,2F,2" "z2 C2C2" "z D,A,,F,,D,,2" 
"F,F,E,E,D,D," "E,2C,2D,2" "D,2E,2E,,2" "G,,2G,2 z2" "z2 A,2D,2" " D,2A,,2D,,2" "z2 G,2G,2" "^D2D2D2" 
"z2 G,2F,2" "D,2F,2D,2" "z2G,2G,2" "z2 E,F, G,2" "D,2E,2E,,2" "G,2A,2A,,2" "G,2A,2A,,2" "A,2 E,3/C,/ A,,2" 
"F,2z2B,2" "z2G,2A,2" "G,2B,2G,2" "D,2D2z2" "z2 (D,E,)F,2" "A,2E,2A,,2" "z _B,A,G,F,E," "D,6" 
"zA,E,C, A,,2" "F,2G,2F,2" "A,2z2B,2" "D,2E,2E,,2" "C,2A,,2z2" "F,2E,2D,2" "E,z F,z G,z" "D,2D,2D,2" 
"A,,2C,2A,,2" "G,2E,2F,2" "D,4D,2" "z2 A,,A,A,,A," "A,,2E,2A,2" "A,2A,,2A,2" "z2^G,2A,2" "(3A,,E,A, (3A,,E,A, (3A,,E,A," 
"A,,2G,2F,2" "A,4D,2" "G,2B,2G,2" "G,2A,2A,,2" "A,4D2" "D,2D,2D,2" "A,,2z2z2" "z2A,2D,2" 
"C2z2A,2" "z2A,2B,2" "F,2E,2D,2" "C,2A,,2D,2" "z2A,,2D,2" "A,,2D,2E,2" "A,2E,2A,,2" "C,z C,z C,z" 
"z2 A,2A,2" "z2A,2A,2" "G,,2G,2G,,2" "z2D,2C,2" "D,A,F,A,D,A," "zB,,^D,F,B,B,," "=G,G, F,F, E,E," "G,2A,2A,,2" 
"B,4G,2" "G,4F,2" "D,2F,2D,2" "G,z E,z C,z" "=G,B,A,G,F,E," "D,2 F,3/A,/ D2" "z D,F,A, D2" "^G,4E,2" 
"A,,2E,2A,2" "D,z E,z F,z" "D,F,A,D D,2" "z2A,2D2" "A,2E,2A,,2" "B,2^G,2A,2" "C,z C,z D,z" "G,2A,2G,2" 
"G,4A,2" "(3D,F,A, (3D,F,A, (3B,,F,B," "A,,A,E,C, A,,2" "F,2C,2D,2" "D,2 F,A, D2" "A,2 E,C, A,,2" "F,2C,2D,2" "A,2F,2D,2" 
"C,2z2z2" "D,2F,2F,2" "D,2D,2D,2" "A,E,C,E, A,,2" "G,2z2z2" "D,A,F,A,B,,B," "A,,2B,,2C,2" "D,2F,2z2" 
"z2 (3E,^G,B, (3E,G,B," "D,2E,2E,,2" "zA,E,C,A,,2" "zA,,C,E,A,A,," "G,2A,2A,,2" "z2 C,2 D,3/F,/" "D,DA,F, D,2" "B,D B,D G,D" 
"C,2D,2z2" "F,2G,2z2" "F,2D,2zF," "G,2F,2A,,2" "z=CB,A,=G,F," "D,4E,2" "D,2F,2A,2" "z2 ^D,2D,2" 
"=G,2^D,2E,2" "C,2D,2C,2" "A,2E,2A,,2" "z2C2D2" "D,2D,2D,2" "A,,A,C,A,A,,A," "A,A,,C,E,A,2" "G,4E,2" 
"C2B,2A,2" "z2C2C2" "D,A,,F,,A,, D,,2" "F,2z2z2" "C2z2z2" "A,2 =G,F,E,D," "z2D,2D,2" "z2G,2F,2" 
"G,6" "z2A,2A,2" "z2 E,2E,2" "^G,EB,EG,E" "D,2D2D,2" "C,A,E,A,D,A," "G,2z2z2" "G,2G,2G,2" 
"G,2A,2A,,2" "D,6" "z2C,2D,2" "D2A,2D,2" "G,4A,2" "G,2G,,2z2" "D,2A,,3/F,,/D,,2" "z2F,2D,2" 
"z2B,2B,2" "D,2C,2B,,2" "z2B,2E,2" "A,4D,2" "G,4F,2" "G,2G,,2z2" "D,2E,2E,,2" "z2A,2B,2" 
"B,2^G,2E,2" "A,,4B,,2" "F,A,C,A,D,A," "F,2E,2D,2" "D,2D,2D,2" "!wedge!F,!wedge!A,!wedge!G,!wedge!F,!wedge!E,!wedge!D," "F,2E,2D,2" "F,6" 
"z2E,2E,,2" "D,2A,2D2" "B,2C2D2" "D,2 A,,3/F,,/ D,,2" "G,2z2A,2" "B,2A,2G,2" "z2D,2D,2" "E,2E,2E,2" )

#----------------------------------------------------------------------------------
# create cat-to-output-file function
#----------------------------------------------------------------------------------
catToFile(){
	cat >> $filen << EOT
$1
EOT
}

#----------------------------------------------------------------------------------
# create empty ABC file
# set header info: generic index number, filename
# Total MDGs: 45,949,729,863,572,161	= 11^16
# Unique MDGs: 3,797,498,335,8324,100	= (11^14)*(10^2)
# meas#/same for tosses: VIII/2=10; XVI/7=8; 
#----------------------------------------------------------------------------------
fileInd=$1-$2-$3-$4-$5-$6-$7-$8-$9-${10}-${11}-${12}-${13}-${14}-${15}-${16}
filen="gfmit-$fileInd.abc"
if [ "${diceS[7]}" = "10" ]; then diceS[7]=2; fi
if [ "${diceS[7]}" = "11" ]; then diceS[7]=10; fi
if [ "${diceS[7]}" = "12" ]; then diceS[7]=11; fi
if [ "${diceS[15]}" = "8" ]; then diceS[15]=7; fi
if [ "${diceS[15]}" = "9" ]; then diceS[15]=8; fi
if [ "${diceS[15]}" = "10" ]; then diceS[15]=9; fi
if [ "${diceS[15]}" = "11" ]; then diceS[15]=10; fi
if [ "${diceS[15]}" = "12" ]; then diceS[15]=11; fi
#dbNum=$(( ${diceS[0]}-1 + (${diceS[1]}-2)*11 + (${diceS[2]}-2)*11**2 + (${diceS[3]}-2)*11**3 + (${diceS[4]}-2)*11**4 + (${diceS[5]}-2)*11**5 + (${diceS[6]}-2)*11**6 + (${diceS[7]}-2)*11**7 + (${diceS[8]}-2)*10*11**7 + (${diceS[9]}-2)*10*11**8 + (${diceS[10]}-2)*10*11**9 + (${diceS[11]}-2)*10*11**10 + (${diceS[12]}-2)*10*11**11 + (${diceS[13]}-2)*10*11**12 + (${diceS[14]}-2)*10*11**13 + (${diceS[15]}-2)*10*11**14 ))
#echo "${diceS[0]}-1 + (${diceS[1]}-2)*11 + (${diceS[2]}-2)*11**2 + (${diceS[3]}-2)*11**3 + (${diceS[4]}-2)*11**4 + (${diceS[5]}-2)*11**5 + (${diceS[6]}-2)*11**6 + (${diceS[7]}-2)*11**7 + (${diceS[8]}-2)*10*11**7 + (${diceS[9]}-2)*10*11**8 + (${diceS[10]}-2)*10*11**9 + (${diceS[11]}-2)*10*11**10 + (${diceS[12]}-2)*10*11**11 + (${diceS[13]}-2)*10*11**12 + (${diceS[14]}-2)*10*11**13 + (${diceS[15]}-2)*10*11**14"

# Use maxima for calculation
cat > /tmp/001.mac << EOF
with_stdout("/tmp/001.txt",print(${diceS[0]}-1 + (${diceS[1]}-2)*11 + (${diceS[2]}-2)*11**2 + (${diceS[3]}-2)*11**3 + (${diceS[4]}-2)*11**4 + (${diceS[5]}-2)*11**5 + (${diceS[6]}-2)*11**6 + (${diceS[7]}-2)*11**7 + (${diceS[8]}-2)*10*11**7 + (${diceS[9]}-2)*10*11**8 + (${diceS[10]}-2)*10*11**9 + (${diceS[11]}-2)*10*11**10 + (${diceS[12]}-2)*10*11**11 + (${diceS[13]}-2)*10*11**12 + (${diceS[14]}-2)*10*11**13 + (${diceS[15]}-2)*10*11**14))$
printfile("/tmp/001.txt")$
quit();
EOF
maxima < /tmp/001.mac >/dev/null
dbNum=`cat /tmp/001.txt`

# restore original toss values
diceS[7]=$8; diceS[15]=$16; 

#----------------------------------------------------------------------------------
# calculate permutation for the current dice toss (from 11^14 possibilities)
#----------------------------------------------------------------------------------
currMeas=0
for measj in ${diceS[*]} ; do
	currMeas=`expr $currMeas + 1`
	ruletab $measj
	measPerm="$measPerm${measNR[$currMeas-1]}:"
done
measPerm="$measPerm:"

#----------------------------------------------------------------------------------
# if output abc file already exists, then make a back-up copy
#----------------------------------------------------------------------------------
if [ -f $filen ]; then 
	mv $filen $filen."bak"
fi


#----------------------------------------------------------------------------------
# generate the header of the ABC file
#----------------------------------------------------------------------------------
catToFile "%%scale 0.65
%%pagewidth 21.10cm
%%bgcolor white
%%topspace 0
%%composerspace 0
%%leftmargin 0.80cm
%%rightmargin 0.80cm
X:$dbNum
T:$fileInd
%%setfont-1 Courier-Bold 8
T:\$1gfmit::$measPerm\$0
T:\$1Perm. No.: $dbNum\$0
M:3/4
L:1/8
Q:1/4=90
%%staves [1 2 3]
V:1 clef=treble
V:2 clef=treble
V:3 clef=bass
K:D
%
%%MIDI program 1 73
%%MIDI program 2 73
%%MIDI program 3 32"

#----------------------------------------------------------------------------------
# write the notes of the ABC file
#----------------------------------------------------------------------------------
currMeas=0
for measj in ${diceS[*]} ; do
	currMeas=`expr $currMeas + 1`
	ruletab $measj
	measN=${measNR[$currMeas-1]}
	phrGf=${notesGf[$measN-1]}
	phrGv=${notesGv[$measN-1]}
	phrF=${notesF[$measN-1]}
	if [ "${currMeas}" == "1" ]; then
		catToFile "%1 $measN
[V:1]|: $phrGf |\\
[V:2]|: $phrGv |\\
[V:3]|: $phrF |\\"
		continue
	elif [ "$currMeas" = "8" ]; then
		catToFile "%8 $measN
[V:1] $phrGf :|
[V:2] $phrGv :|
[V:3] $phrF :|"
		continue
	elif [ "$currMeas" = "9" ]; then 
		catToFile "%9 $measN
[V:1]|: $phrGf |\\
[V:2]|: $phrGv |\\
[V:3]|: $phrF |\\"
		continue
	elif [ "$currMeas" = "16" ]; then
		catToFile "%16 $measN
[V:1] $phrGf :|]
[V:2] $phrGv :|]
[V:3] $phrF :|]"
		continue
	else
		catToFile "%$currMeas $measN
[V:1] $phrGf |\\
[V:2] $phrGv |\\
[V:3] $phrF |\\"
	fi
done

# create SVG
abcm2ps ./$filen -O ./"gfmit-$fileInd.svg" -g

# create MIDI
abc2midi ./$filen -quiet -silent -o ./"gfmit-$fileInd.mid"
#
##
###
