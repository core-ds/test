#!/bin/bash

is_feature_info="Какие-то правки для фича-правок"

# Переменная с ссылкой на файл CHANGELOG
changelog_file="../CHANGELOG.md"

# Переменная с regEx для поиска строки вида  ## X.X.X (ГГГГ-ММ-ДД)
regex="^#+\s*[0-9]+\.[0-9]+\.[0-9]+ \([0-9]{4}-[0-9]{2}-[0-9]{2}\)"

# Переменная с ссылкой на номер строки с первым вхождением строки формата ## X.X.X (ГГГГ-ММ-ДД)
start_line=$(grep -n -m 1 -E "$regex" "$changelog_file" | cut -d ':' -f 1)

# Переменная с ссылкой на номер строки со вторым вхождением строки формата ## X.X.X (ГГГГ-ММ-ДД)
second_line=$(grep -n -m 2 -E "$regex" "$changelog_file" | tail -n 1 | cut -d ':' -f 1)

changelog_info=""

if [ -z "$is_feature_info" ]
then
  echo "feature_info не объявлены"
else
  changelog_info+="### Features\n$is_feature_info"
fi

#sed "s/${is_feature_info}/g" > temp.md;

#changelog_info=$(echo -e "$changelog_info")

sed "$((start_line+1)),$((second_line-1))c\\
$changelog_info
" "$changelog_file" > tmp_file.txt && mv tmp_file.txt "$changelog_file"



echo "$start_line"
echo "$second_line"
echo -e "$changelog_info"
