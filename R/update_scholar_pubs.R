# R/update_scholar_pubs.R

install.packages("scholar") # run once if needed
library(scholar)
library(dplyr)
library(readr)

scholar_id <- "XUH1C6YAAAAJ"  # <-- PUT YOUR ID HERE

# 1. Pull publications from Google Scholar
pubs <- get_publications(scholar_id)

# Optional: clean / arrange
pubs_clean <- pubs %>%
  mutate(
    title = as.character(title),
    journal = as.character(journal),
    year = as.integer(year)
  ) %>%
  arrange(desc(year), desc(cites))

# 2. Save as RDS (for R) and CSV (for debugging / other uses)
dir.create("data", showWarnings = FALSE)
saveRDS(pubs_clean, file = "data/scholar_pubs.rds")
write_csv(pubs_clean, file = "data/scholar_pubs.csv")
