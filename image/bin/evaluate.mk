#!/usr/bin/make -f

KMER	 = 21
SIZE	 = 10000
COVERAGE = 1 # Set coverage to be 1-fold because mash seg-faults for small genomes otherwise

references = $(shell biobox_args.sh 'select(has("fasta_dir")) | .fasta_dir | map(.value) | join(" ")' | xargs -I {} find {} -type f)
contigs    = $(shell biobox_args.sh 'select(has("fasta")) | .fasta | map(.value) | join(" ")')

/bbx/output/biobox.yaml: \
	/usr/local/share/biobox.yaml \
	/bbx/output/metrics.tsv \
	/bbx/output/metrics.yaml
	cp $< $@

/bbx/output/metrics.tsv: /bbx/output/metrics.yaml
	yaml2csv \
		--input $< \
		--output $@ \
		--sort \
		--strict-keys \
		--convert-bools \
		--downcase
	sed -i 's/,/	/' $@

/bbx/output/metrics.yaml: assembly.yml
	cp $< $@

assembly.yml: reference.gff assembly.gff
	gaet --reference $^ --output $@
	sed -i 's/null/0/' $@
	sed -i 's/5.8S/5_8S/' $@

%.gff: %.fa domain.txt
	prokka --compliant --cpus $(shell nproc) $< --kingdom=$(shell cat domain.txt)
	mv PROKKA*/*.gff $@
	rm -rf PROKKA*

domain.txt: reference.msh
	d_predict predict \
		--reference-mash=${DOMAIN_DB}/domain_db.msh \
		--query-mash=$< \
		--mapping-file=${DOMAIN_DB}/mapping.csv \
		> $@

%.msh: %.fa
	mash sketch -k $(KMER) -s $(SIZE) -m $(COVERAGE) -o $@ $<

reference.fa: $(references)
	parallel --keep-order normalise_fasta.sh ::: $< > $@

assembly.fa: $(contigs)
	parallel --keep-order normalise_fasta.sh ::: $< > $@

clean:
	rm -f *.fa *.msh *.gff *.yml *.txt
