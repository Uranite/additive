update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@main
	clear
	@echo "Packwiz has been Updated"
export:
	-mkdir -p build/fabric/
	cd versions/fabric/1.21 && pw mr export
	-mv versions/fabric/*/*.mrpack build/fabric
update:
	cd versions/fabric/1.21 && pw update --all
refresh:
	cd versions/fabric/1.21 && pw refresh
