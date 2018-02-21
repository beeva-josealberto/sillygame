# Generic place and object -----------------------------------------------------

place <- list(name = "NULL",
              description = "No ves nada",
              objects = list(),
              states = NULL,
              state = NULL,
              exitable = FALSE,
              exit_action = NULL)

object <- list(name = NULL,
               description = "No tiene nada especial",
               openable = FALSE,
               open_action = NULL)

# Initial cell -----------------------------------------------------------------

cell <- place
cell$name <- "celda"

# Set description
cell$description <- glue::glue("

-----
CELDA
-----

Estás dentro de una celda.
Las paredes son de piedra. El suelo de arena húmeda.
Oyes un goteo incesante.
Una robusta puerta de madera te observa al otro lado de la estancia.

")

# Set possible states
cell$states <- c("cell.init", "cell.open")
cell$state <- "cell.init"

# Set exit action
cell$exitable <- TRUE
cell$exit_action <- function(place){
  if (place$state == "cell.open"){
    icat("Has escapado. ¡Enhorabuena!")
    return("end")
  } else {
    icat("La puerta está cerrada.")
  }
}


## Create door object ----------------------------------------------------------

cell.door <- object
cell.door$name <- "puerta"
cell.door$description <- glue::glue("
Parece hecha de madera de roble.
En la parte inferior hay un ventanuco metálico cerrado.
")
cell.door$openable <- TRUE
cell.door$open_action <- function(place){
  if (place$state == "cell.init"){
    icat("¡Has abierto la puerta! Esperaba algo más complejo...")
    place$state <- "cell.open"
    return("cell.open")
  }
  if (place$state == "cell.open"){
    icat("La puerta ya está abierta")
  }
}


## Create ventanuco ------------------------------------------------------------

cell.ventanuco <- object
cell.ventanuco$name <- "ventanuco"
cell.ventanuco$description <- glue::glue("
Un ventanuco sucio y oxidado. Debe ser el sitio por donde entra la comida.
")
cell.ventanuco$openable <- TRUE
cell.ventanuco$open_action <- function(place){
  icat("No puedo abrirlo. Está cerrado por el otro lado.")
}

## Add objects to cell ---------------------------------------------------------

cell$objects <- list("puerta" = cell.door,
                     "ventanuco" = cell.ventanuco)




# List containing all places ---------------------------------------------------

places <- list(cell)
