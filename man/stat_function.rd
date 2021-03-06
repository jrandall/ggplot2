\name{stat_function}
\alias{stat_function}
\alias{StatFunction}
\title{stat\_function}
\description{Superimpose a function }
\details{
This page describes stat\_function, see \code{\link{layer}} and \code{\link{qplot}} for how to create a complete plot from individual components.
}
\usage{stat_function(mapping=NULL, data=NULL, geom="path", position="identity", fun, n=101, args=list(), ...)}
\arguments{
 \item{mapping}{mapping between variables and aesthetics generated by aes}
 \item{data}{dataset used in this layer, if not specified uses plot dataset}
 \item{geom}{geometric used by this layer}
 \item{position}{position adjustment used by this layer}
 \item{fun}{function to use}
 \item{n}{number of points to interpolate along}
 \item{args}{list of additional arguments to pass to fun}
 \item{...}{other arguments}
}
\seealso{\itemize{
  \item \url{http://had.co.nz/ggplot2/stat_function.html}
}}
\value{A \code{\link{layer}}}
\examples{\dontrun{
x <- rnorm(100)
qplot(x, geom="density") + stat_function(fun = dnorm, colour="red")
}}
\author{Hadley Wickham, \url{http://had.co.nz/}}
\keyword{hplot}
