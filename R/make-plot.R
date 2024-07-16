library(ggplot2)

data5 |> 
  st_as_sf() |> 
  ggplot() +
  geom_sf(aes(fill = percent)) +
  scale_fill_viridis_c() +
  theme_void() +
  ggspatial::annotation_scale() +
  labs(fill = "Voting \nparticipation (%)",
       title = "Voting participation in the 2024 EU parliament elections",
       caption = "Source: Bundeswahlleiterin, BKG") +
  theme(legend.position = "bottom")
