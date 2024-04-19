{homeDir}: ''

  set -l INBOX '${homeDir}/Library/Mobile Documents/icloud~md~obsidian/Documents/Tvault/200 Literature Notes/'
  set -l DATE (date "+%Y%m%dT%H%m%SZ")
  set -l DATE_2 (date "+%Y-%m-%dT%H:%m:%SZ")

  read -P "Title: " TITLE

  set -l FILENAME "$INBOX$DATE $TITLE.md"
  touch "$FILENAME"

  set -l NEWLINE \n\n"---"
  set -l FRONTMATTER "---"\n"title: $TITLE"\n"created_at: $DATE_2"\n"tags: [#literature-note]"\n"topics: []"\n"authors: []"\n"aliases: [$TITLE]"\n"---"

  for LINE in $FRONTMATTER "# $TITLE" $NEWLINE "# References";
      echo "$LINE" >> "$FILENAME"
  end

  nvim +:8 "$FILENAME"
''
