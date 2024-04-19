{homeDir}: ''
  set -l INBOX '${homeDir}/Library/Mobile Documents/iCloud~md~obsidian/Documents/Tvault/000 Inbox/'
  set -l DATE (date "+%Y-%m-%dT%H%m%SZ")
  set -l DATE_2 (date "+%Y-%m-%dT%H:%m:%SZ")

  read -P "Title: " TITLE

  set -l FILENAME "$INBOX$DATE $TITLE.md"
  touch "$FILENAME"

  set -l NEWLINE \n\n"---"
  set -l FRONTMATTER "---"\n"title: $TITLE"\n"created_at: $DATE_2"\n"tags: [#inbox]"\n"aliases: [$TITLE]"\n"---"

  for LINE in $FRONTMATTER "# $TITLE" $NEWLINE "# References";
      echo "$LINE" >> "$FILENAME"
  end

  nvim +:6 "$FILENAME"
''
