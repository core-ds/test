#!/bin/bash

# Отправляет запрос о релизе в github release API
function postReleaseMessage {
  echo "$BOT_TOKEN"
  echo "$VERSION"
  echo "$BRANCH"
  echo "$CHANGELOG"
  echo "$REPOSITORY"
  echo "{
             \"tag_name\": \"$VERSION\",
             \"target_commitish\": \"$BRANCH\",
             \"name\": \"$VERSION\",
             \"body\": \"$CHANGELOG\",
             \"draft\": false,
             \"prerelease\": false,
             \"generate_release_notes\": false
           }"

  curl -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $BOT_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -d "{
      \"tag_name\": \"$VERSION\",
      \"target_commitish\": \"$BRANCH\",
      \"name\": \"$VERSION\",
      \"body\": \"$CHANGELOG\",
      \"draft\": false,
      \"prerelease\": false,
      \"generate_release_notes\": false
    }" \
    https://api.github.com/core-ds/test/releases
}


postReleaseMessage
