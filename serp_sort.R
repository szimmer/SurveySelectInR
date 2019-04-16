# very much a work in progress
serp_sort <- function(.data, ...){
  #' Performs a serpentitive sort on a tibble
  #' 
  #' @param .data A tbl 
  #' @param ... Comma separated list of unquoted variable names.
  #' 
  #' @return An object of same class as \code{.data}
  #' 
  
  require(dplyr)
  require(stringr)
  # require(checkmate)
  # coll <- checkmate::makeAssertCollection()
  # 
  # checkmate::assertDataFrame(.data, add=coll)
  # checkmate::assertCharacter(sortvars, add=coll, min.len=1, unique=TRUE)
  # if (checkmate::testDataFrame(.data)) checkmate::assertSubset(sortvars, names(.data), add=coll)
  # 
  # checkmate::reportAssertions(coll)
  
  datsort <- .data %>% arrange(...)
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

jl <- serp_sort(mystorm, year, status, category)
datsort <- jl[[1]]
