FROM bioboxes/biobox-minimal-base@sha256:908bc44aaa5de9a9b519cc3548b7d1e37c8f4f71a815f43ea71091e2980e9974

ENV PROKKA_VERSION  1caf2394850998f89a3782cc8846dc51978faac2
ENV BARRNAP_VERSION f1289ffceabe40de93ac033cf88851761e55646b

ADD image /usr/local/

RUN install.sh && rm -r /usr/local/bin/install.sh /usr/local/bin/install
