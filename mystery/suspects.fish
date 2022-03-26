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
    function suspects_from_height_gender
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
    for i in (suspects_from_height_gender)
        set car_license (grep -B 3 $i vehicles | grep -o 'Plate.*' | awk {'print $2'})
        set car_colour (grep -B 3 $i vehicles | grep -o 'Color.*' | awk {'print $2'})
        set car_make (grep -B 3 $i vehicles | grep -o 'Make.*' | awk {'print $2'})
        set car_license_check (grep -B 3 $i vehicles | grep -o 'Plate.*' | awk {'print $2'} | grep '^L337.*9$')
        if test $car_colour = Blue -a $car_make = Honda
            if test $car_license_check
                echo $i
            end
        end
    end
end

#Call Function

suspects

#Sanity check

for i in (suspects)
    bash /home/ewan/becode/clmystery/test.sh $i
end
