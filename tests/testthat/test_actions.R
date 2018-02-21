context("Actions")

# Create a place and an object for the tests -----------------------------------

p <- place
p$name <- "Sitio falso"
p$description <- "Este sitio parece bastante falso."

o <- object
o$name <- "Objeto falso"
o$description <- "Sí, parece falso."

p$objects <- list(o = o)


# Tests ------------------------------------------------------------------------

test_that("look_at shows the description of a place", {
  expect_output(look_at(p), "Este sitio parece bastante falso.")
})

test_that("look_at shows the description of an object", {
  expect_output(look_at(p, o), "Sí, parece falso.")
})

test_that("A non-openable object cannot be opened", {
  expect_output(open(p, o), "Eso no puede abrirse")
})


# Clean ------------------------------------------------------------------------

rm(p, o)
