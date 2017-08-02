ECHO = echo
MKDIR = mkdir -p
RM = rm
TAR = tar
CD = cd
ZIP = zip
MV = mv

.PHONY: all clean

all : globalzip

clean : globalzip-clean

globalzip : globalzip-clean
        # prepare a temp dir to hold the stuff to be zipped
	$(MKDIR) DVB
        # copy stuff to the temp dir, preserving symlinks
	@$(ECHO) "Building ZIP archive."
	$(TAR) -c metadata | ( $(CD) DVB; $(TAR) -x )
	$(TAR) -c 3rd-party | ( $(CD) DVB; $(TAR) -x )
        # create the zip archive, leaving out admin files
	$(ZIP) -yXq -x \*.DS_Store \*.git\* -r DVB.zip DVB
        # move it into place
	$(MV) DVB.zip metadata
        # clear up
	$(RM) -rf DVB
	@$(ECHO) "Done."

globalzip-clean :
        # clear out old debris
	@$(ECHO) "Clearing out leftovers."
	$(RM) -f metadata/DVB.zip
	$(RM) -rf DVB
