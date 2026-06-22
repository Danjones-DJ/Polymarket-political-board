pacman::p_load(googlesheets4, tidyverse, lubridate)

writeLines(
  Sys.getenv("GSHEET_AUTH_JSON"),
  "service-account.json"
)

gs4_auth(path = "service-account.json")

SHEET_ID <- "137LuKcAhWN9dNUUY1-Eh-qSh6SmvKhpNh3gP07Y6Jd4"

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