#!/usr/bin/make -f

KMER	 = 21
SIZE	 = 10000
COVERAGE = 2

references = $(shell biobox_args.sh 'select(has("fasta_dir")) | .fasta_dir | .value + "/"' | xargs -I {} find {} -type f)
contigs    = $(shell biobox_args.sh 'select(has("fasta")) | .fasta | map(.value) | join(" ")')


assembly.yml: reference.gff assembly.gff
	gaet --reference $<

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
