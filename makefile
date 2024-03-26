update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@main
	clear
	@echo "Packwiz has been Updated"
export-fabric:
	-mkdir -p .build/fabric/
	cd versions/fabric && pw batch mr export
	-mv versions/fabric/*/*.mrpack .build/fabric
update-fabric:
	cd versions/fabric && pw batch update --all
refresh-fabric:
	cd versions/fabric && pw batch refresh
update-loader:
	cd versions/fabric && pw batch migrate loader latest
refresh:
	make refresh-fabric
update:
	make update-fabric
export:
	make export-fabric
all: update-packwiz refresh update update-loader export
