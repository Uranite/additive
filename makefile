update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@main
	clear
	@echo "Packwiz has been Updated"
export:
	-mkdir -p .build/fabric/
	cd versions/fabric && pw batch mr export
	-mv versions/fabric/*/*.mrpack .build/fabric
update:
	cd versions/fabric && pw batch update --all
refresh:
	cd versions/fabric && pw batch refresh
update-loader:
	cd versions/fabric && pw batch migrate loader latest
all: update-packwiz refresh update-loader update export
