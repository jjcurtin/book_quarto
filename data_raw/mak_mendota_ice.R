# Build data/mendota_ice.csv (Lake Mendota ice cover, one row per winter)
# from the raw EDI download in data_raw/.
#
# Source:
#   Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2026. North Temperate
#   Lakes LTER: Ice Duration - Madison Lakes Area 1853 - current ver 40.
#   Environmental Data Initiative.
#   https://doi.org/10.6073/pasta/6a95bee73799927cbafbf87393be7038
#   (Accessed 2026-11-07).
#
# Notes on the raw file (ntl33_v14.csv):
# * The file name is EDI's entity name; "v14" is NOT the package version (ver 40).
# * `year` is the year the winter ENDS (e.g., 1856 = winter 1855-56).
# * `duration` is total days of ice cover; it excludes mid-winter open-water
#   periods, so it can differ from ice_off - ice_on.
#
# Simplifications for teaching:
# * Lake Mendota only (Monona and Wingra dropped).
# * Winters 1855-56 onward: earlier winters are incomplete or missing.
# * Freeze and thaw dates dropped; only total days of ice cover kept.

library(tidyverse)

ice_raw <- read_csv(here::here("data_raw/ntl33_v14.csv"), show_col_types = FALSE)

mendota_ice <- ice_raw |>
  filter(lakeid == "ME", year >= 1856) |>
  transmute(
    winter = str_c(year - 1, "-", str_sub(year, 3, 4)),
    year = as.integer(year),
    ice_days = as.integer(duration)
  ) |>
  arrange(year)

# One row per winter, no gaps, no missing values
stopifnot(
  !anyNA(mendota_ice),
  !anyDuplicated(mendota_ice$year),
  all(diff(mendota_ice$year) == 1)
)

write_csv(mendota_ice, here::here("data/mendota_ice.csv"))
