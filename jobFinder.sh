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
    client="*removed*"
elif [ "$2" = "*removed*" ] || [ "$2" = "*removed*" ] || [ "$2" = "AH" ] || [ "$2" = "ah" ]
then
    client="*removed*"
elif [ "$2" = "*removed*" ] || [ "$2" = "*removed*" ] || [ "$2" = "AP" ] || [ "$2" = "ap" ]
then
    client="*removed*"
elif [ "$2" = "*removed*" ] || [ "$2" = "*removed*" ] || [ "$2" = "Echo" ]
then
    client="*removed*"
elif [ "$2" = "GHW" ] || [ "$2" = "ghw" ]
then
    client="*removed*"
elif [ "$2" = "KBA" ] || [ "$2" = "kba" ]
then
    client="*removed*"
elif [ "$2" = "*removed*" ] || [ "$2" = "*removed*" ] || [ "$2" = "NV" ] || [ "$2" = "nv" ]
then
    client="*removed*"
elif [ "$2" = "TPSC" ] || [ "$2" = "tpsc" ]
then
    client="*removed*"
fi

echo -e "\nCD'ing to /volumes/word_directory/$client"
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
