#!/usr/bin/fish

cd $HOME/becode/clmystery/mystery

# Return sorted list of suspects

function suspects
    function suspects_from_members
        for i in (cat people | tail -n 5021 | awk {'print $1 " " $2'})
            set -l in_club (cat memberships/AAA memberships/Delta_SkyMiles memberships/Terminal_City_Library memberships/Museum_of_Bash_History | grep -c $i)
            if test $in_club -eq 4
                echo $i
            end
        end
    end
    for i in (suspects_from_members)
        set gender (grep $i people | awk {'print $3'})
        set suspect_height (grep -A 5 $i vehicles | grep -no 'Height.*' | awk {'print substr($2,1,1)'})
        if test $gender = M
            if test $suspect_height -eq 6
                echo $i
            end
        end
    end
end

#Print Information for assessing who the murderer is 

for i in (suspects)
    set suspect_line_no (grep $i people | grep -no 'line.*' | awk '{ print $2 }')
    set suspect_street (grep $i people | awk {'print $5 "_" $6'} | sed s/,//)
    set car_license (grep -B 3 $i vehicles | grep -o 'Plate.*' | awk {'print $2'})
    #name of suspect
    tput bold smul
    echo $i
    tput sgr0
    echo \n
    #car info
    grep -A 2 $car_license vehicles
    echo \n
    #check for interview and print
    if test $i = "Brian Boyer"
        cat interviews/interview-628618
        echo \n
    end
    if test -e streets/$suspect_street
        echo "Interview: " \n
        set interview (head -n $suspect_line_no streets/$suspect_street | tail -n 1)
        set interview_no (echo $interview | awk {'print $3'} | sed s/#//)
        cat interviews/interview-$interview_no
        echo \n
    end
end


#Sanity check

for i in (suspects)
    bash /home/ewan/becode/clmystery/test.sh $i
end
