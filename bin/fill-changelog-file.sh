#!/bin/bash
changelog_file="CHANGELOG.md";
new_line="
";
separator="
- ";

# Генерирует title для записи в changelog в формате: # 2.2.8 (01.01.2024)
function generateTitle {
  if [[ $SEMANTIC_VERSION == "patch" ]]
    then caption="###"
  elif [[ $SEMANTIC_VERSION == "minor" ]]
    then caption="##"
  elif [[ $SEMANTIC_VERSION == "major" ]]
    then caption="#"
  fi

  gmt_time=$(TZ="GMT+3" date +%d-%m-%Y);

  echo "$caption $VERSION $gmt_time"
};

# Возвращает строку в markdown разметке о Features, Bug Fixes, BREAKING CHANGES (если что-то из этого отсутствует, то в не попадет на выход)
function generateChangelogInfo {
  local ChangelogInfo="";

  if [ ${#FEATURES} -gt 0 ]
    then ChangelogInfo+="$new_line### Features${FEATURES//\//$separator}"
  fi

  if [ ${#BUGFIXES} -gt 0 ]
    then ChangelogInfo+="$new_line### Bug Fixes${BUGFIXES//\//$separator}"
  fi

  if [ ${#BREAKING_CHANGES} -gt 0 ]
    then ChangelogInfo+="$new_line### BREAKING CHANGES${BREAKING_CHANGES//\//$separator}"
  fi

  echo "$ChangelogInfo$new_line"
};

# Проверяет передана ли информация о Features, Bug Fixes, BREAKING CHANGES, если нет то пишет об этом
function checkAvailabilityInformationForChangelog {
  if [[ ${#FEATURES} -eq 0 && ${#BUGFIXES} -eq 0 && ${#BREAKING_CHANGES} -eq 0  ]]
    then echo "Не указана информация об изменениях для заполнения $changelog_file файла."
  fi
}

checkAvailabilityInformationForChangelog

Title=$(generateTitle)
Changelog=$(generateChangelogInfo)

fullChangelogInfo="$Title
$Changelog
"

echo "$fullChangelogInfo" | cat - "$changelog_file" > temp && mv temp "$changelog_file"
