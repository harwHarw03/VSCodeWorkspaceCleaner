#!/bin/bash

CONFIG_PATH=~/.config/Code

for i in $CONFIG_PATH/User/workspaceStorage/*; do
	if [ -f $i/workspace.json ]; then
		folder="$(python3 -c "import sys, json; print(json.load(open(sys.argv[1], 'r'))['folder'])" $i/workspace.json 2>/dev/null | sed 's#^file://##;s/+/ /g;s/%\(..\)/\\x\1/g;')"
	
		if [ -n "$folder" ] && [ ! -d "$folder" ]; then
			echo "Removing workspace $(basename $i) for deleted folder $folder of size $(du -sh $i|cut -f1)"
			rm -rfv "$i"
		fi
	fi
done
