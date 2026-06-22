pacman::p_load(googlesheets4, tidyverse, lubridate)

gs4_auth(path = "polymarket-scraping-298dd3f24d2c.json")

SHEET_ID <- "1Irok2DRw32DB1QD-zOO1QHGCw0iWkQGVbRrWiFAedKc"

# new scrape
new_rows <- read_rds("data/EVENTS.rds") %>%
  mutate(scraping_date = today())

# existing sheet
old_rows <- read_sheet(SHEET_ID)

# keep only genuinely new id-date pairs
rows_to_append <- new_rows %>%
  anti_join(
    old_rows %>% select(EVENT_ID, SCRAPING_DATE),
    by = c("EVENT_ID", "SCRAPING_DATE")
  )

# append only if there is something new
if (nrow(rows_to_append) > 0) {
  sheet_append(SHEET_ID, rows_to_append)
}