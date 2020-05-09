library(geofaceteAR)
library(tidyverse)
library(hexSticker)

plot <- get_grid("ARGENTINA") %>% 
  mutate(name = str_replace_all(name, " ", "\n")) %>%  
  grid_preview() 





p <- plot + theme_void() +  theme_transparent()


sticker(p, package="geofaceteAR", s_x=.85, s_y=1, s_width=.6, s_height=1.4,
        h_fill="#429659", h_color="black",
        filename="hex/ggplot2.png", p_size=11, p_x = 1.35, p_y = 0.85,
        url = "https://github.com/electorArg", u_size = 4)


