#!/bin/bash
changelog_file="./bin/CHANG.md"
#changelog_file="CHANG.md"
temp_file_ext=".temp"
regex="^#+\s*[0-9]+\.[0-9]+\.[0-9]+ \([0-9]{4}-[0-9]{2}-[0-9]{2}\)"
start_line=$(grep -n -m 1 -E "$regex" "$changelog_file" | cut -d ':' -f 1)
# second_line=$(grep -n -m 2 -E "$regex" "$changelog_file" | tail -n 1 | cut -d ':' -f 1)

function rmiTempFile {
  rm "$changelog_file$temp_file_ext"
}

function fillChanges {
  if [ -z "$1" ]
  then
      echo "Значение $2 не установлено"
  elif [ $# == 3 ]
    # Тут будет логика по заполнению файла ↓
   then sed
     sed -i"$temp_file_ext" "\$a\\
     $2\\
     $1" "$3"


    #then info="$2$1"; sed -i"$temp_file_ext" -e "a\\
    #        $info" "$3" # && sed -i"$temp_file_ext" 's/\//\n- /g' "$3"

    # Тут будет логика по заполнению файла ↑
  fi
}

# sed -i"$temp_file_ext" "$((start_line+1)),$((second_line-1))d" "$changelog_file" && rmiTempFile

# sed -i"$temp_file_ext" "$((start_line))G" "$changelog_file" && rmiTempFile

#touch "changelog$temp_file_ext"
fillChanges "$FEATURES_ENV" "### Features" "changelog$temp_file_ext"
fillChanges "$BREAKING_ENV" "### Bug Fixes" "changelog$temp_file_ext"
fillChanges "$BUGFIX_ENV" "### ⚠ BREAKING CHANGES" "changelog$temp_file_ext"
#rm "changelog$temp_file_ext"
#rm "changelog$temp_file_ext$temp_file_ext"
