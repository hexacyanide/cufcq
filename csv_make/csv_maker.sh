#!/bin/bash
echo "Enter input file XCEL (include location): "
read input
echo "Enter output file (include location): "
read output

ssconvert -S $input temp.csv
#converts 
tr -d '"' < *.csv.1 | sed 's/Instructor,/Instructor_last,Instructor_first,/g' > $output
rm -r *.csv.?
tail -n +2 "$output" > work.csv
echo 'yearterm,subject,crse,sec,onlineFCQ,bd_continuing_education,instructor_last,instructor_first,forms_requested,forms_returned,percentage_passed,course_overall,course_overall_SD,instructor_overall,instructor_overall_SD,total_hours,prior_interest,effectiveness,availability,challenge,amount_learned,respect,course_title,courseOverall_old,courseOverall_SD_old,instrOverall_old,instrOverall_SD_old,r_Fair,r_Access,workload,r_Divstu,r_Diviss,r_Presnt,r_Explan,r_Assign,r_Motiv,r_Learn,r_Complx,campus,college,aSdiv,level,fcqdept,instructor_group,i_Num' | cat - work.csv > temp.csv 

awk -F, '/,/{gsub(/ /, "", $0); print}' temp.csv > $output
rm temp.csv
rm work.csv