library(dplyr)
library(tidyr)
library(sf)
library(stringr)

file <- "C:/Users/s2949359/Documents/github/coding-meetup-reproducability/input/kerg2.csv"


# election data -----------------------------------------------------------

# Read data
data <- read.csv(file, 
                  header = TRUE, 
                  sep = ";", 
                  dec = ",", 
                  stringsAsFactors = FALSE,
                  skip = 9)

# voting participation
data2 <- data |>
  rename(
    area_type = Gebietsart,
    area_number = Gebietsnummer,
    area_name = Gebietsname,
    group_name = Gruppenname,
    number = Anzahl,
    percent = Prozent
  ) |>
  select(area_type,
         area_number,
         area_name,
         group_name,
         number,
         percent) |> 
  filter(area_type == "Kreis") |> 
  mutate(area_number = str_pad(area_number, width = 5, side = "left", pad = "0"))

data_regression <- data2 |> 
  filter(group_name %in% c("Wählende", "AfD")) |>
  mutate(group_name = ifelse(group_name == "Wählende", "Voters", group_name)) |>
  pivot_wider(names_from = group_name, values_from = c(percent, number))

data3 <- data2 |> 
  filter(group_name == "Wählende") 

# add geographic data -----------------------------------------------------

# Read data
shp <- "C:/Users/s2949359/Documents/github/coding-meetup-reproducability/input/vg250_01-01.gk3.shape.ebenen/vg250_ebenen_0101/VG250_KRS.shp"

data4 <- st_read(shp)  |> 
  rename(area_number = AGS) |> 
  select(area_number, GEN)

data5 <- data3 |> 
  left_join(data4, by = "area_number") 