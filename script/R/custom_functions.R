

# SAVE IMAGE 
# Function to save images as eps, jpg,  svb
saveImage <- function(p, path, fig, dpi, w, h, u, ...){ 
  ggsave(filename = here::here(path, paste0(fig, ".jpg")), 
         dpi = dpi, plot = p, width = w, height = h, units = u)
  ggsave(filename = here::here(path, paste0(fig, ".eps")), 
         dpi = dpi, plot = p, width = w, height = h, units = u)
  ggsave(filename = here::here(path, paste0(fig, ".svg")), 
         dpi = dpi, plot = p, width = w, height = h, units = u)
}


# COLORES 
# azul, verde, rojo 
# CaH, CaL, SJ 
colores_den <- c("#56B4E9","#009E73","#CD5C5C")


