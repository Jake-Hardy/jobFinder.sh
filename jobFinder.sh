#! /bin/bash

# echo "setting defaults"
route="F"
ext="indd"

### getopts code starts here ###

# If an option should be followed by an argument, it should be followed by a ':'
# Leading ':' suppresses error messages

while getopts :r:e: FLAG; do
    echo "Processing flags..."
    case $FLAG in
        r)
            route=$OPTARG
            echo "r flag set: $OPTARG"
            ;;
        e)
            ext=$OPTARG
            echo "e flag set: $OPTARG"
            ;;
    esac
done

#shift tells getopts to move on to the next argument.
shift $((OPTIND-1))

### getopts code ends here ###

job_num=$1

if [ "$2" = "ABFS" ] || [ "$2" = "abfs" ]
then
    client="Advance Benefit Funding Sources (ABFS)"
elif [ "$2" = "Avidia" ] || [ "$2" = "avidia" ] || [ "$2" = "AH" ] || [ "$2" = "ah" ]
then
    client="Avidia Health (AH)"
elif [ "$2" = "AmeraPlan" ] || [ "$2" = "ameraplan" ] || [ "$2" = "AP" ] || [ "$2" = "ap" ]
then
    client="AmeraPlan (AP)"
elif [ "$2" = "ECHO" ] || [ "$2" = "echo" ] || [ "$2" = "Echo" ]
then
    client="ECHO Health (ECHO)"
elif [ "$2" = "GHW" ] || [ "$2" = "ghw" ]
then
    client="GPA HealthWatch (GHW)"
elif [ "$2" = "KBA" ] || [ "$2" = "kba" ]
then
    client="Key Benefit Administrators (KBA)"
elif [ "$2" = "Nova" ] || [ "$2" = "nova" ] || [ "$2" = "NV" ] || [ "$2" = "nv" ]
then
    client="Nova (NV)"
elif [ "$2" = "TPSC" ] || [ "$2" = "tpsc" ]
then
    client="Trusteed Plans Service Corporation (TPSC)"
fi

echo -e "\nCD'ing to /volumes/Ocozzio_Workflow/$client"
echo -e "\nclient: $client"
echo -e "job: $job_num\n"
cd /
cd volumes/Ocozzio_Workflow/"$client"

declare -a files
ind=0
IFS=$'\n'
for r in `find . -name "*$job_num*_$route.$ext"`
do
    files[$ind]=$r
    ((ind+=1))
done
unset IFS

if [ "${#files[@]}" -gt 1 ]
then
    ind=0
    for f in "${files[@]}"
    do
        echo "$ind - $f"
        ((ind+=1))
    done


    echo -e "\nRun which file? "
    read sel

    echo -e "Opening ${files[$sel]}\n"
    open "${files[$sel]}"
elif [ "${#files[@]}" -eq 0 ]
then
    echo -e "No files were found. Exiting script...\n"
else
    echo -e "Opening ${files[0]}\n"
    open "${files[0]}"
fi
