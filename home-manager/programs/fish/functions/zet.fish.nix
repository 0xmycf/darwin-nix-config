{homeDir}: ''
  set -l INBOX '${homeDir}/Library/Mobile Documents/iCloud~md~obsidian/Documents/Tvault/000 Inbox/'
  set -l DATE (date "+%Y-%m-%dT%H:%m:%SZ")


  read -P "Title: " TITLE

  set -l FILENAME "$INBOX$DATE $TITLE.md"
  touch "$FILENAME"

  set -l NEWLINE \n\n"---"
  set -l FRONTMATTER "---"\n"title: $TITLE"\n"created_at: $DATE"\n"tags: #inbox"\n"---"

  for LINE in $FRONTMATTER "# $TITLE" $NEWLINE "# References";
      echo "$LINE" >> "$FILENAME"
  end

  nvim "$FILENAME"
''
