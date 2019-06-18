JUPYTEREXEC=jupyter nbconvert --to notebook --execute --inplace
EMACSEXEC=emacs

everything: orgmode tangle all
	@echo "==========================================================================="
	@echo "DONE!"

all:
	$(JUPYTEREXEC) EEG*.ipynb

orgmode:
	./cc-jupyter2org.sh

tangle:
	mkdir -p ../fun
	mkdir -p ../tangled
	$(EMACSEXEC) --batch -l org --eval "(org-babel-tangle-file \"../supFunSim.org\")"

zip:
	zip supFunSim.zip *.m

single_run:
	$(JUPYTEREXEC) EEGStaticMethods.ipynb
	$(JUPYTEREXEC) EEGParameters.ipynb
	$(JUPYTEREXEC) EEGSignalGenerator.ipynb
	$(JUPYTEREXEC) EEGForwardModel.ipynb
	$(JUPYTEREXEC) EEGReconstruction.ipynb

test: single_run
	mkdir -p ../fun
	mkdir -p ../tangled
	$(JUPYTEREXEC) EEGTest.ipynb
	$(EMACSEXEC) --batch -l org --eval "(org-babel-tangle-file \"../supFunSim.org\")"

clean:
	jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace *.ipynb

rm: clean
	@echo "==========================================================================="
	rm -fv ./*.mat
	@echo "==========================================================================="
	rm -fv ./*.m
	@echo "==========================================================================="
	rm -fv ./EEG*.md
	@echo "==========================================================================="
	rm -fv ./RunAll.md
	@echo "==========================================================================="
	rm -fv ./*.org
	@echo "==========================================================================="
	rm -fv ../tangled/*.m
	@echo "==========================================================================="
	rm -fv ../tangled/*.sh
	@echo "==========================================================================="
	rm -fv ../tangled/*.ditaa
	@echo "==========================================================================="
	rm -fv ../fun/*.m
	@echo "==========================================================================="
	rm -fv ../.*~undo-tree~
	@echo "==========================================================================="
	rm -fv ../notebooks/.*~undo-tree~
