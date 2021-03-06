GeomRect <- proto(Geom, {
  
  default_stat <- function(.) StatIdentity
  default_pos <- function(.) PositionIdentity
  default_aes <- function(.) aes(colour=NA, fill="grey20", size=0.5, linetype=1, alpha = 1)
  
  required_aes <- c("xmin", "xmax", "ymin", "ymax")

  draw <- draw_groups <- function(., data, scales, coordinates, ...) {
    if (coordinates$muncher()) {
      aesthetics <- setdiff(
        names(data), c("x", "y", "xmin","xmax", "ymin", "ymax")
      )
      
      polys <- alply(data, 1, function(row) {
        poly <- with(row, rect_to_poly(xmin, xmax, ymin, ymax))
        aes <- as.data.frame(row[aesthetics], 
          stringsAsFactors = FALSE)[rep(1,5), ]
      
        GeomPolygon$draw(cbind(poly, aes), scales, coordinates)
      })
      
      ggname("bar",do.call("grobTree", polys))
    } else {
      with(coordinates$transform(data, scales), 
        ggname(.$my_name(), rectGrob(
          xmin, ymax, 
          width = xmax - xmin, height = ymax - ymin, 
          default.units = "native", just = c("left", "top"), 
          gp=gpar(
            col=colour, fill=alpha(fill, alpha), 
            lwd=size * .pt, lty=linetype, lineend="butt"
          )
        ))
      )
    }
    
  }
  
  # Documentation -----------------------------------------------
  objname <- "rect"
  desc <- "2d rectangles"
  guide_geom <- function(.) "polygon"
  
  icon <- function(.) {
    rectGrob(c(0.3, 0.7), c(0.4, 0.8), height=c(0.4, 0.8), width=0.3, vjust=1, gp=gpar(fill="grey20", col=NA))
  }
  
  examples <- function(.) {
    df <- data.frame(
      x = sample(10, 20, replace = TRUE),
      y = sample(10, 20, replace = TRUE)
    )
    ggplot(df, aes(xmin = x, xmax = x + 1, ymin = y, ymax = y + 2)) +
    geom_rect()
  }  

})

# Convert rectangle to polygon
# Useful for non-Cartesian coordinate systems where it's easy to work purely in terms of locations, rather than locations and dimensions.
# 
# @keywords internal
rect_to_poly <- function(xmin, xmax, ymin, ymax) {
  data.frame(
    y = c(ymax, ymax, ymin, ymin, ymax),
    x = c(xmin, xmax, xmax, xmin, xmin)
  )
}