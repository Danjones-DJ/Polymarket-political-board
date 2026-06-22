# Uncomment and run 1x
pacman::p_load(googlesheets4, googledrive, tidyverse)

# Run this once in R
gs4_auth()
# Follow instructions it outputs

# Then run again from here

# Load data you've scraped
df = read_rds("data/EVENTS.rds")

# Use gs4_create function

ss <- gs4_create(
  "polymarket-scraping",
  sheets = list(data = df)
)

ss
