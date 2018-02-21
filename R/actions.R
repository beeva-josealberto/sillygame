explore <- function(place, object = NULL){
  icat(place$description)
}

exit_game <- function(place, object = NULL){
  icat("Saliendo del juego... ¡Adios!")
  return("end")
}

look_at <- function(place, object = NULL){
  if (!is.null(object))
    icat(object$description)
  else
    icat(place$description)
}

open <- function(place, object){
  if (!is.null(object)){
    if (object$openable)
      return(object$open_action(place))
    else
      icat("Eso no puede abrirse")
  } else {
    icat("No veo eso que dices...")
  }

}

exit <- function(place, object = NULL){
  if (place$exitable){
    return(place$exit_action(place))
  }
}

actions <- list(explorar = explore,
                q = exit_game,
                salir = exit,
                mirar = look_at,
                ver = look_at,
                abrir = open)
