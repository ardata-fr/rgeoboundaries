#' @importFrom tools R_user_dir
#' @export
#' @title Get 'rgeoboundaries' Cache Directory
#' @description
#' Get the path to the 'rgeoboundaries' cache directory.
#' This directory is used to store cached data from the 'rgeoboundaries' package.
#' @details
#' This directory is managed by R function [R_user_dir()] but can also
#' be defined in a non-user location by setting ENV variable `RGEOBOUNDARIES_CACHE_DIR`
#' or by setting R option `RGEOBOUNDARIES_CACHE_DIR`.
#' @examples
#' rgeoboundaries_cache_dir()
#'
#' options(RGEOBOUNDARIES_CACHE_DIR = tempdir())
#' rgeoboundaries_cache_dir()
#' options(RGEOBOUNDARIES_CACHE_DIR = NULL)
#'
#' Sys.setenv(RGEOBOUNDARIES_CACHE_DIR = tempdir())
#' rgeoboundaries_cache_dir()
#' Sys.setenv(RGEOBOUNDARIES_CACHE_DIR = "")
#' @family rgeoboundaries cache management
rgeoboundaries_cache_dir <- function() {
  if (dir.exists(Sys.getenv("RGEOBOUNDARIES_CACHE_DIR"))) {
    dir <- Sys.getenv("RGEOBOUNDARIES_CACHE_DIR")
  } else if (
    !is.null(getOption("RGEOBOUNDARIES_CACHE_DIR")) &&
      dir.exists(getOption("RGEOBOUNDARIES_CACHE_DIR"))
  ) {
    dir <- getOption("RGEOBOUNDARIES_CACHE_DIR")
  } else {
    dir <- R_user_dir(package = "rgeoboundaries", which = "data")
  }

  dir
}

#' @title dummy 'rgeoboundaries' cache
#' @description dummy 'rgeoboundaries' cache
#' used for examples or docker environments.
#' @export
#' @examples
#' rgeoboundaries_dummy_setup()
#' rgeoboundaries_cache_dir()
#' rm_rgeoboundaries_cache()
#' @family rgeoboundaries cache management
rgeoboundaries_dummy_setup <- function() {
  options(
    RGEOBOUNDARIES_CACHE_DIR = file.path(tempdir(), "RGEOBOUNDARIES_CACHE_DIR")
  )
  dir.create(
    getOption("RGEOBOUNDARIES_CACHE_DIR"),
    recursive = TRUE,
    showWarnings = TRUE
  )
  rgeoboundaries_cache_dir()
}


#' @export
#' @title Check if 'rgeoboundaries' Cache Exists
#' @description
#' Check if the 'rgeoboundaries' cache directory exists.
#' @examples
#' rm_rgeoboundaries_cache()
#' rgeoboundaries_cache_exists()
#'
#' rgeoboundaries_dummy_setup()
#' init_rgeoboundaries_cache()
#' rgeoboundaries_cache_exists()
#' @family rgeoboundaries cache management
rgeoboundaries_cache_exists <- function() {
  dir.exists(rgeoboundaries_cache_dir())
}

#' @export
#' @title Remove 'rgeoboundaries' Cache
#' @description
#' Remove the 'rgeoboundaries' cache directory.
#' This function deletes the cache directory and all its contents.
#' @examples
#' rgeoboundaries_dummy_setup()
#' rm_rgeoboundaries_cache()
#' @family rgeoboundaries cache management
rm_rgeoboundaries_cache <- function() {
  dir <- rgeoboundaries_cache_dir()
  unlink(dir, recursive = TRUE, force = TRUE)
}


#' @export
#' @title Initialize 'rgeoboundaries' Cache
#' @description
#' Initialize the 'rgeoboundaries' cache directory.
#' This function creates the cache directory if it does not exist.
#'
#' If the `force` argument is set to `TRUE`, it will remove any existing
#' cache directory before creating a new one.
#' @param force Logical. If `TRUE`, remove existing cache directory.
#' @return The path to the 'rgeoboundaries' cache directory.
#' @examples
#' rgeoboundaries_dummy_setup()
#' init_rgeoboundaries_cache()
#'
#' init_rgeoboundaries_cache(force = TRUE)
#' @family rgeoboundaries cache management
init_rgeoboundaries_cache <- function(force = FALSE) {
  if (force) {
    rm_rgeoboundaries_cache()
  }

  if (!rgeoboundaries_cache_exists()) {
    dir.create(
      rgeoboundaries_cache_dir(),
      showWarnings = FALSE,
      recursive = TRUE
    )
  }

  rgeoboundaries_cache_dir()
}
