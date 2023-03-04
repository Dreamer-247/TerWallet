#!/bin/bash

green="\033[1;92m"
black="\033[1;90m"
red="\033[1;91m"
nc="\033[0m"

if [ ! -f .wallet.txt ]
then
echo -e "null" > .wallet.txt
else
return
fi

if [ ! -f .detailsSpend.txt ]
then
echo -e "${black}Null${nc}" > .detailsSpend.txt
else
return
fi

if [ ! -f .detailsAdd.txt ]
then
echo -e "${black}Null${nc}" > .detailsAdd.txt
else
return
fi

clear
echo -e "\n${green}Your Wallet v1.0${nc}\n"

PS3="$(echo -e '\n# What would you like to do: ')"

select opt in New_Balance Check_Balance Deposit Withdraw Balance_History Quit
do
    case $opt in
        "New_Balance")
           echo -e "null" > .wallet.txt
           echo -e "" > .detailsAdd.txt
           echo -e "" > .detailsSpend.txt

if [ $(cat .wallet.txt) -gt 0 2>/dev/null ]
then
echo -e "${black}>>> Balance has been reset\nCurrent balance:${green} $(cat .wallet.txt)${nc}"
else
echo -e "${black}>>> Balance has been reset\nCurrent balance:${red} $(cat .wallet.txt)${nc}"
fi;;

        "Check_Balance")
if [ $(cat .wallet.txt) -gt 0 2>/dev/null ]
then
echo -e "${black}Current balance:${green} $(cat .wallet.txt)${nc}"
else
echo -e "${black}Current balance:${red} $(cat .wallet.txt)${nc}"
fi;;

        "Deposit")
           read -p $'\033[1;90mEnter the amount you want to deposit: \033[0m' add
           newbal="$(($(cat .wallet.txt) + $add))"
           echo -e "$newbal" > .wallet.txt
           read -p $'\033[1;90mEnter the source of deposit: \033[0m' note
           echo -e "\n# $(date +”%d/%m/%Y,%A,%I:%M_%p”) >>> ${add} >>> ${note}\n" >> .detailsAdd.txt  }

if [ $(cat .wallet.txt) -gt 0 2>/dev/null ]
then
echo -e "${black}Current balance:${green} $newbal${nc}"
else
echo -e "${black}Current balance:${red} $newbal${nc}"
fi;;

        "Withdraw")
           read -p $'\033[1;90mEnter the amount you want to withdraw: \033[0m' spend
           newbal="$(($(cat .wallet.txt) - $spend))"
           echo -e "$newbal" > .wallet.txt
           read -p $'\033[1;90mEnter the reason to withdraw: \033[0m' note
           echo -e "\n# $(date +”%d/%m/%Y,%A,%I:%M_%p”) >>> ${spend} >>> ${note}\n" >> .detailsSpend.txt  }

if [ $(cat .wallet.txt) -gt 0 2>/dev/null ]
then
echo -e "${black}Current balance:${green} $newbal${nc}"
else
echo -e "${black}Current balance:${red} $newbal${nc}"
fi;;

        "Balance_History")
if [ $(cat .wallet.txt) != "null" ]
then
           read -p $'\033[1;90mPlease enter the date correctly \n(DD/MM/YYYY): \033[0m' search
           echo -e "${green}\nDeposit list:\n${nc}"
           echo -e "${black}$(grep ${search} .detailsAdd.txt)${nc}"
           echo -e "${green}\nWithdraw list:\n${nc}"
           echo -e "${black}$(grep ${search} .detailsSpend.txt)${nc}"
else
           echo -e "${black}\nNo history${nc}"
fi;;
        "Quit")
           echo -e "${green}\nThank you.\n${nc}"
           break;;
        *)
           echo -e "${red}\nOoops${black}\n(Please give correct input)${nc}";;
    esac
done
