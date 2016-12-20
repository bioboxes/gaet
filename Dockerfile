FROM bioboxes/biobox-minimal-base@sha256:908bc44aaa5de9a9b519cc3548b7d1e37c8f4f71a815f43ea71091e2980e9974

ENV PROKKA_VERSION  1caf2394850998f89a3782cc8846dc51978faac2
ENV BARRNAP_VERSION 212005299c872f71669bbad5858ff97845f5f1d9
ENV DPRED_VERSION   0.1.0
ENV MASH_VERSION    1.1.1
ENV GAET_VERSION    0.3.0

ENV DOMAIN_DB /usr/local/domain_db/

ADD image /usr/local/

RUN install.sh && rm -r /usr/local/bin/install.sh /usr/local/bin/install
