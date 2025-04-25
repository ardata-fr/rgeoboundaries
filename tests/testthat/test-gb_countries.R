context("gb_countries: test types and errors")
library(sf)


rgeoboundaries_dummy_setup()


test_that("type of object returned is as expected", {
  skip_if_offline()
  p <- gb_adm0(country = "Mali")
  expect_is(p, "sf")
  expect_true(st_geometry_type(p) %in% c("MULTIPOLYGON", "POLYGON"))
})
