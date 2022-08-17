#####################
### Preliminaries ###
#####################
# Clearing workspace
rm(list = ls())

# Setting working directory 
setwd('~/Dropbox/GBDWHO/DIMAQ2/WHO2021')

# Loading shapefiles
load("Data/Processed/Shapefiles/shapefiles.RData")

# Setting working directory 
setwd('~/Dropbox/Github/matthewllthomas.github.io/travelling/')

# Loading Source code
source('~/Dropbox/Github/WHO2021/0_Source.R')

# List of countries visited
lst <- c('Canada', 'China', 'Costa Rica', 'Croatia', 'Estonia', 'France', 'Germany', 
         'Greece', 'Ireland', 'Italy', 'Latvia', 'Mexico', 'Mongolia', 'Portugal', 
         'Romania', 'Serbia', 'Spain', 'Switzerland',
         'United Kingdom of Great Britain and Northern Ireland',
         'United States of America')

# Adding a flag
WHO_map@data <- WHO_map@data %>%
  mutate(flag = ifelse(CountryName %in% lst, 1, 0))
  
# Removing uncessary entries
WHO_regions <- subset(WHO_regions, !(NAME %in% c('Aksai Chin', 'Jammu and Kashmir', 'Abyei')))

# Converting to an sf object
WHO_map <- st_as_sf(WHO_map)
WHO_regions <- st_as_sf(WHO_regions)

pdf('Map.pdf', width = 13.5, height = 6)
ggplot() + 
  geom_sf(data = WHO_map,
          size = 0.15,
          aes(fill = as.factor(flag))) + 
  geom_sf(data = WHO_regions,
          size = 0.15, 
          fill = 'white') + 
  scale_fill_manual(values = c('lightgrey', 'skyblue')) + 
  theme_minimal() + 
  theme(panel.grid = element_blank(),
        axis.text = element_blank(),
        legend.position = 'none')
dev.off()












