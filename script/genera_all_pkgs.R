# Script to generate citations of all pkgs

# Load libraries 
library("here")
library("grateful")

# Get all pkgs
paqui <- scan_packages(all.pkgs = TRUE, include.Rmd = TRUE)

# Get cites of all pkgs 
citas_paqui <- get_citations(paqui)

# Create rmd 
create_rmd(citas_paqui, filename = here("man", "supp_0.rmd"))



