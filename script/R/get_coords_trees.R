## Coordinates of Trees relative to center of plot 
# arguments: 
# * angle: azimut between focal tree and measured tree (with 'brujula')
# * distance: distance to center of plot (focal tree)
# * x0, y0: coordinates of plot center (focal tree)


get_coords_trees <- function(angle, distance, x0, y0) {
  angle <- ifelse(angle <= 90, 90 - angle, 450 - angle)
  data.frame(x = x0 + distance * cos(angle / 180 * pi),
             y = y0+ distance * sin(angle / 180 * pi))
}