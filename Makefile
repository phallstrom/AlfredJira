EXTENSION = Jira.alfredworkflow
BUNDLEID = pjkh.jira
VERSION = 0.0.1
SOURCE_FILES = functions.sh jira.sh icon.png info.plist
PKG_FILES = $(SOURCE_FILES)

WORKFLOW_DIR = $(HOME)/Dropbox/AlfredApp/Alfred.alfredpreferences/workflows
INSTALL_DIR = `grep -l -- ">$(BUNDLEID)<" "$(WORKFLOW_DIR)"/*/info.plist | sed 's/\/info.plist//'`

all: $(EXTENSION)

$(EXTENSION): $(SOURCE_FILES) VERSION
	zip -rT $(EXTENSION) $(PKG_FILES)

VERSION:
	touch info.plist

clean:
	rm -rf $(EXTENSION)

test:
	@roundup tests/test_*

local-install:
	[[ -d "$(INSTALL_DIR)" ]] && cp -r $(PKG_FILES) "$(INSTALL_DIR)/"

update-info-plist:
	[[ -d "$(INSTALL_DIR)" ]] && cp -r "$(INSTALL_DIR)/info.plist" .
