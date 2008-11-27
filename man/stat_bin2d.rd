\name{stat_bin2d}
\alias{stat_bin2d}
\alias{StatBin2d}
\title{stat\_bin2d}
\description{Bin 2d plane into rectangles}
\details{
This page describes stat\_bin2d, see \code{\link{layer}} and \code{\link{qplot}} for how to create a complete plot from individual components.
}
\section{Aesthetics}{
The following aesthetics can be used with stat\_bin2d.  Aesthetics are mapped to variables in the data with the \code{\link{aes}} function: \code{stat\_bin2d(\code{\link{aes}}(x = var))}
\itemize{
  \item \code{x}: x position (\strong{required}) 
  \item \code{y}: y position (\strong{required}) 
  \item \code{fill}: internal colour 
}
}
\usage{stat_bin2d(mapping=NULL, data=NULL, geom="rect", position="identity", bins=30, drop=TRUE, ...)}
\arguments{
 \item{mapping}{mapping between variables and aesthetics generated by aes}
 \item{data}{dataset used in this layer, if not specified uses plot dataset}
 \item{geom}{geometric used by this layer}
 \item{position}{position adjustment used by this layer}
 \item{bins}{NULL}
 \item{drop}{NULL}
 \item{...}{ignored }
}
\seealso{\itemize{
  \item \code{\link{stat_binhex}}: For hexagonal binning
  \item \url{http://had.co.nz/ggplot2/stat_bin2d.html}
}}
\value{A \code{\link{layer}}}
\examples{\dontrun{
d <- ggplot(diamonds, aes(carat, price))
d + stat_bin2d()
d + geom_bin2d()

# You can control the size of the bins by specifying the number of
# bins in each direction:
d + stat_bin2d(bins = 10)
d + stat_bin2d(bins = 30)

# Or by specifying the width of the bins
d + stat_bin2d(binwidth = c(1, 1000))
d + stat_bin2d(binwidth = c(.1, 500))

# Or with a list of breaks
x <- seq(min(diamonds$carat), max(diamonds$carat), by = 0.1)
y <- seq(min(diamonds$price), max(diamonds$price), length = 50)
d + stat_bin2d(breaks = list(x = x, y = y))

# With qplot
qplot(x, y, data = diamonds, geom="bin2d", 
  xlim = c(4, 10), ylim = c(4, 10))
qplot(x, y, data = diamonds, geom="bin2d", binwidth = c(0.1, 0.1),
  xlim = c(4, 10), ylim = c(4, 10))
}}
\author{Hadley Wickham, \url{http://had.co.nz/}}
\keyword{hplot}