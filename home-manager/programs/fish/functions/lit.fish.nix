{homeDir}: ''

  set -l INBOX '${homeDir}/Library/Mobile Documents/icloud~md~obsidian/Documents/Tvault/200 Literature Notes/'
  set -l DATE (date "+%Y-%m-%dT%H%m%S00Z")

  read -P "Title: " TITLE

  set -l FILENAME "$INBOX$DATE $TITLE.md"
  touch "$FILENAME"

  set -l NEWLINE \n\n"---"
  set -l FRONTMATTER "---"\n"title: $TITLE"\n"created_at: $DATE"\n"tags: [#literature-note]"\n"topic:"\n"---"

  for LINE in $FRONTMATTER "# $TITLE" $NEWLINE "# References";
      echo "$LINE" >> "$FILENAME"
  end

  nvim +:7 "$FILENAME"
''
