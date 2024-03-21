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
export-quilt:
	-mkdir -p .build/quilt/
	cd versions/quilt && pw batch mr export
	-mv versions/quilt/*/*.mrpack .build/quilt
update-quilt:
	cd versions/quilt && pw batch update --all
refresh-quilt:
	cd versions/quilt && pw batch refresh
update-loader:
	cd versions/fabric && pw batch migrate loader latest
	cd versions/quilt && pw batch migrate loader latest
refresh:
	make refresh-fabric
	make refresh-quilt
update:
	make update-fabric
	make update-quilt
export:
	make export-fabric
	make export-quilt
all: update-packwiz refresh update update-loader export
