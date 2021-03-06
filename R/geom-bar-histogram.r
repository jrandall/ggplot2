GeomHistogram <- proto(GeomBar, {
  objname <- "histogram"
  desc <- "Histogram"
  
  details <- "<p>geom_histogram is an alias for geom_bar + stat_bin so you will need to look at the documentation for those objects to get more information about the parameters.</p>"

  advice <- "<p>geom_histogram only allows you to set the width of the bins (with the binwidth parameter), not the number of bins, and it certainly does not suport the use of common heuristics to select the number of bins.  In practice, you will need to use multiple bin widths to discover all the signal in the data, and having bins with meaningful widths (rather than some arbitrary fraction of the range of the data) is more interpretable.</p> "
  
  icon <- function(.) {
    y <- c(0.2, 0.3, 0.5, 0.6,0.2, 0.8, 0.5, 0.3)
    rectGrob(seq(0.1, 0.9, by=0.1), y, height=y, width=0.1, vjust=1, gp=gpar(fill="grey20", col=NA))
  }
  
  examples <- function(.) {
    
    # Simple examles
    qplot(rating, data=movies, geom="histogram")
    qplot(rating, data=movies, weight=votes, geom="histogram")
    qplot(rating, data=movies, weight=votes, geom="histogram", binwidth=1)
    qplot(rating, data=movies, weight=votes, geom="histogram", binwidth=0.1)
    
    # More complex
    m <- ggplot(movies, aes(x=rating))
    m + geom_histogram()
    m + geom_histogram(aes(y = ..density..)) + geom_density()

    m + geom_histogram(binwidth = 1)
    m + geom_histogram(binwidth = 0.5)
    m + geom_histogram(binwidth = 0.1)
    
    # Add aesthetic mappings
    m + geom_histogram(aes(weight = votes))
    m + geom_histogram(aes(y = ..count..))
    m + geom_histogram(aes(fill = ..count..))

    # Change scales
    m + geom_histogram(aes(fill = ..count..)) + 
      scale_fill_gradient("Count", low = "green", high = "red")

    # Often we don't want the height of the bar to represent the
    # count of observations, but the sum of some other variable.
    # For example, the following plot shows the number of movies
    # in each rating.
    qplot(rating, data=movies, geom="bar", binwidth = 0.1)
    # If, however, we want to see the number of votes cast in each
    # category, we need to weight by the votes variable
    qplot(rating, data=movies, geom="bar", binwidth = 0.1,
      weight=votes, ylab = "votes")
    
    m <- ggplot(movies, aes(x = votes))
    # For transformed scales, binwidth applies to the transformed data.
    # The bins have constant width on the transformed scale.
    m + geom_histogram() + scale_x_log10()
    m + geom_histogram(binwidth = 1) + scale_x_log10()
    m + geom_histogram() + scale_x_sqrt()
    m + geom_histogram(binwidth = 10) + scale_x_sqrt()

    # For transformed coordinate systems, the binwidth applies to the 
    # raw data.  The bins have constant width on the original scale.

    # Using log scales does not work here, because the first
    # bar is anchored at zero, and so when transformed becomes negative
    # infinity.  This is not a problem when transforming the scales, because
    # no observations have 0 ratings.
    m + geom_histogram() + coord_trans(x = "log10")
    m + geom_histogram() + coord_trans(x = "sqrt")
    m + geom_histogram(binwidth=1000) + coord_trans(x = "sqrt")
      
    # You can also transform the y axis.  Remember that the base of the bars
    # has value 0, so log transformations are not appropriate 
    m <- ggplot(movies, aes(x = rating))
    m + geom_histogram(binwidth = 0.5) + scale_y_sqrt()
    m + geom_histogram(binwidth = 0.5) + scale_y_reverse()
    
    # Set aesthetics to fixed value
    m + geom_histogram(colour = "darkgreen", fill = "white", binwidth = 0.5)
    
    # Use facets
    m <- m + geom_histogram(binwidth = 0.5)
    m + facet_grid(Action ~ Comedy)
    
    # Often more useful to use density on the y axis when facetting
    m <- m + aes(y = ..density..)
    m + facet_grid(Action ~ Comedy)
    m + facet_wrap(~ mpaa)

    # Multiple histograms on the same graph
    # see ?position, ?position_fill, etc for more details.  
    ggplot(diamonds, aes(x=price)) + geom_bar()
    hist_cut <- ggplot(diamonds, aes(x=price, fill=cut))
    hist_cut + geom_bar() # defaults to stacking
    hist_cut + geom_bar(position="fill")
    hist_cut + geom_bar(position="dodge")
    
    # This is easy in ggplot2, but not visually effective.  It's better
    # to use a frequency polygon or density plot.  Like this:
    ggplot(diamonds, aes(price, ..density.., colour = cut)) +
      geom_freqpoly(binwidth = 1000)
    # Or this:
    ggplot(diamonds, aes(price, colour = cut)) +
      geom_density()
    # Or if you want to be fancy, maybe even this:
    ggplot(diamonds, aes(price, fill = cut)) +
      geom_density(alpha = 0.2)
    # Which looks better when the distributions are more distinct
    ggplot(diamonds, aes(depth, fill = cut)) +
      geom_density(alpha = 0.2) + xlim(55, 70)
    
  }
})
