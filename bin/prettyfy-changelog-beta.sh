#!/bin/bash
changelog_file="CHANGELOG.md";
new_line="
";
separator="
- ";

function generateTitle {
  if [[ $SEMANTIC_VERSION == "patch" ]];
    then caption="###"
      elif [[ $SEMANTIC_VERSION == "minor" ]];
        then caption="##"
      elif [[ $SEMANTIC_VERSION == "major" ]];
            then caption="#"
  fi

  echo "$caption $VERSION ($(date +%d-%m-%Y))"
}

function generateChangelogInfo {
      local ChangelogInfo="";

      if [[ ${#FEATURES} -gt 0 ]];
      then ChangelogInfo+="$new_line### Features${FEATURES//\//$separator}"
      fi

      if [ ${#BUGFIXES} -gt 0 ];
        then ChangelogInfo+="$new_line### Bug Fixes${BUGFIXES//\//$separator}"
      fi

      if [ ${#BREAKING_CHANGES} -gt 0 ];
        then ChangelogInfo+="$new_line### BREAKING CHANGES${BREAKING_CHANGES//\//$separator}"
      fi

      echo "$ChangelogInfo$new_line"
}

Title=$(generateTitle)
Changelog=$(generateChangelogInfo)

fullChangelogInfo="$Title
$Changelog
"

echo "$fullChangelogInfo" | cat - "$changelog_file" > temp && mv temp "$changelog_file"
