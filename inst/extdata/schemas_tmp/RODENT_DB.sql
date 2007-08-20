--
-- RODENT_DB schema
-- ================
--

-- The "genes" table is the central table.
CREATE TABLE genes (
  id INTEGER PRIMARY KEY,
  gene_id VARCHAR(10) NOT NULL UNIQUE           -- Entrez Gene ID
);

-- Other data tables
CREATE TABLE accessions (
  id INTEGER NOT NULL REFERENCES genes,
  accession VARCHAR(20) NOT NULL                -- GenBank accession number
);
CREATE TABLE alias (
  id INTEGER NOT NULL REFERENCES genes,
  alias_symbol VARCHAR(80) NOT NULL             -- gene symbol or alias
);
CREATE TABLE chromosomes (
  id INTEGER NOT NULL REFERENCES genes,
  chromosome VARCHAR(2) NOT NULL                -- chromosome name
);
CREATE TABLE chromosome_locations (
  id INTEGER NOT NULL REFERENCES genes,
  chromosome VARCHAR(2) NOT NULL,               -- chromosome name
  start_location INTEGER NOT NULL
);
CREATE TABLE cytogenetic_locations (
  id INTEGER NOT NULL REFERENCES genes,
  cytogenetic_location VARCHAR(20) NOT NULL     -- cytoband location
);
CREATE TABLE ec (
  id INTEGER NOT NULL REFERENCES genes,
  ec_number VARCHAR(13) NOT NULL                -- EC number (no "EC:" prefix)
);
CREATE TABLE gene_info (
  id INTEGER NOT NULL UNIQUE REFERENCES genes,
  gene_name VARCHAR(255) NOT NULL,              -- gene name
  symbol VARCHAR(80) NOT NULL                   -- gene symbol
);
CREATE TABLE go_bp (
  id INTEGER NOT NULL REFERENCES genes,
  go_id CHAR(10) NOT NULL,                      -- GO ID
  evidence CHAR(3) NOT NULL                     -- GO evidence code
);
CREATE TABLE go_cc (
  id INTEGER NOT NULL REFERENCES genes,
  go_id CHAR(10) NOT NULL,                      -- GO ID
  evidence CHAR(3) NOT NULL                     -- GO evidence code
);
CREATE TABLE go_mf (
  id INTEGER NOT NULL REFERENCES genes,
  go_id CHAR(10) NOT NULL,                      -- GO ID
  evidence CHAR(3) NOT NULL                     -- GO evidence code
);
CREATE TABLE kegg (
  id INTEGER NOT NULL REFERENCES genes,
  kegg_id CHAR(5) NOT NULL                      -- KEGG pathway short ID
);
CREATE TABLE pfam (
  id INTEGER NOT NULL REFERENCES genes,
  ipi_id CHAR(11) NOT NULL,                     -- IPI accession number
  pfam_id CHAR(7) NULL                          -- Pfam ID
);
CREATE TABLE prosite (
  id INTEGER NOT NULL REFERENCES genes,
  ipi_id CHAR(11) NOT NULL,                     -- IPI accession number
  prosite_id CHAR(7) NULL                       -- PROSITE ID
);
CREATE TABLE pubmed (
  id INTEGER NOT NULL REFERENCES genes,
  pubmed_id VARCHAR(10) NOT NULL                -- PubMed ID
);
CREATE TABLE refseq (
  id INTEGER NOT NULL REFERENCES genes,
  accession VARCHAR(20) NOT NULL                -- RefSeq accession number
);
CREATE TABLE unigene (
  id INTEGER NOT NULL REFERENCES genes,
  unigene_id VARCHAR(10) NOT NULL               -- UniGene ID
);

CREATE TABLE chrlengths (
  chr VARCHAR(2) PRIMARY KEY,                   -- chromosome name
  length INTEGER NOT NULL
);

-- Metadata tables
CREATE TABLE metadata (
  name VARCHAR(80) PRIMARY KEY,
  value VARCHAR(255)
);
CREATE TABLE qcdata (
  map_name VARCHAR(80) PRIMARY KEY,
  count INTEGER NOT NULL
);
CREATE TABLE map_metadata (
  map_name VARCHAR(80) NOT NULL,
  source_name VARCHAR(80) NOT NULL,
  source_url VARCHAR(255) NOT NULL,
  source_date VARCHAR(20) NOT NULL
);

-- Explicit index creation on the referencing column of all the foreign keys.
-- Note that this is only needed for SQLite: PostgreSQL and MySQL create those
-- indexes automatically.
CREATE INDEX Faccessions ON accessions (id);
CREATE INDEX Falias ON alias (id);
CREATE INDEX Fchromosomes ON chromosomes (id);
CREATE INDEX Fchromosome_locations ON chromosome_locations (id);
CREATE INDEX Fcytogenetic_locations ON cytogenetic_locations (id);
CREATE INDEX Fec ON ec (id);
CREATE INDEX Fgene_info ON gene_info (id);
CREATE INDEX Fgo_bp ON go_bp (id);
CREATE INDEX Fgo_cc ON go_cc (id);
CREATE INDEX Fgo_mf ON go_mf (id);
CREATE INDEX Fkegg ON kegg (id);
CREATE INDEX Fpfam ON pfam (id);
CREATE INDEX Fprosite ON prosite (id);
CREATE INDEX Fpubmed ON pubmed (id);
CREATE INDEX Frefseq ON refseq (id);
CREATE INDEX Funigene ON unigene (id);

