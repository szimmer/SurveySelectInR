# very much a work in progress
serp_sort <- function(.data, ..., .by_group=FALSE){
  #' Performs a serpentitive sort on a tibble
  #' 
  #' @param .data A tbl 
  #' @param groupvars A character vector of grouping variables. These will not be sorted serpentine but using a traditional sort. sortvars will be sorted serpentine within groupvars. This can be NULL
  #' @param ... Comma separated list of unquoted variable names.
  #' 
  #' @return An object of same class as \code{.data}
  #' 
  
  require(dplyr)
  require(stringr)

  if (is_grouped_df(.data) & .by_group==TRUE){
    datsort <- .data %>% arrange(..., .by_group=TRUE)  
    group_vs <- groups(.data)
  } else{
    datsort <- .data %>% arrange(...)  
    group_vs <- NULL
  }
  
  sort_var <- enquos(...)

  ds <- datsort %>%
    mutate(firstind=FALSE)
  for (i in 1:length(sort_var)){
    fvn <- str_c("firstv", i)
    csn <- str_c("cs", i)
    ds <- ds %>%
      mutate(firstind=(!!sort_var[[i]]!=lag(!!sort_var[[i]]))| row_number()==1| firstind,
             !!fvn:=firstind,
             !!csn:=cumsum(firstind))
  }

  return(list(datsort=ds, sort_var=sort_var))
}

mystorm <- storms %>% sample_n(1000) 
mystormg <- mystorm %>%
  group_by(month)

j1 <- serp_sort(mystorm, year, status, category)
# datsort <- jl[[1]]

j2 <- serp_sort(mystormg, year, status, category, .by_group=TRUE)
j3 <- serp_sort(mystorm, year, status, category, .by_group=FALSE)
j4 <- serp_sort(mystormg, year, status, category, .by_group=FALSE)

ds1 <- j1[[1]]
ds2 <- j2[[1]]
ds3 <- j3[[1]]
ds4 <- j4[[1]]
