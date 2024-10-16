#--------------------------------------------------------------------
include	./Makefile.git
#--------------------------------------------------------------------
#nothing to do
clean	:
	   @ rm -fr $(APLR) $(APLR).tar.gz
	
#--------------------------------------------------------------------
dotar	:
	  @ echo "Preparing Tar file"
	  @ rm -fr $(APLR)
	  @ mkdir $(APLR)
	  @ cp -a					\
		arch					\
		basic					\
		basicio					\
		binder					\
		bios.diag				\
		BUILDING				\
		calc					\
		charset					\
		compiler				\
		copydupdir				\
		cross					\
		diagnostic				\
		disassembler				\
		editor					\
		edittort11				\
		etc					\
		execerr					\
		filer					\
		host					\
		libmap					\
		librarian				\
		LICENSE					\
		LICENSE-UCSD				\
		linker					\
		long_integer				\
		man					\
		markdupdir				\
		meson.build				\
		meson_options.txt			\
		pascalio				\
		radix					\
		README					\
		rt11toedit				\
		setup					\
		system					\
		transcendental				\
		turtle_graphics				\
		ucsdpsys_os_license_bsd.1		\
		web					\
		xref					\
		yaloe					\
		$(APLR)
	  @ tar 					\
		zcf $(APLR).tar.gz			\
		$(APLR)
	  @ echo "Tar file is now ready"


#--------------------------------------------------------------------
#to generate a binary from the src.rpm
rpmbin	:  rpm
	   @ echo "Making RPM binary"
	   @ rm -fr $(RPMDIR)/RPMS/x86_64/$(APP)-*.x86_64.rpm
	   @ rpmbuild					\
		-v					\
		--rebuild				\
		$(RPMDIR)/SRPMS/$(APP)*.src.rpm
	   @ echo "RPM binary completed"

#to generate a an src.rpm file
rpm	:  spec
	   @ echo "Making RPM src"
	   @ mkdir -p $(RPMDIR)/SOURCES
	   @ rm -fr 					\
		$(RPMDIR)/SOURCES/$(APP)*.tar.gz	\
		$(RPMDIR)/SRPMS/$(APP)*.src.rpm
	   @ $(MAKE) -s dotar
	   @ mv $(APLR).tar.gz $(RPMDIR)/SOURCES/
	   @ rpmbuild -bs				\
		$(APP).spec
	   @ echo "RPM src completed"

#--------------------------------------------------------------------
spec	:  $(APP).spec.in
	   @ sed 					\
		-e 's/@@DIST@@/safe/g' 			\
		-e 's/@@APPN@@/$(APP)/g' 		\
		-e 's/@@VERSION@@/$(VERSION)/g'		\
		-e 's/@@RELEASE@@/$(RELEASE)/g'		\
                -e 's/@@PACKAGER@@/$(PACKAGER)/g'	\
		< $< > $(APP).spec
		
#--------------------------------------------------------------------
