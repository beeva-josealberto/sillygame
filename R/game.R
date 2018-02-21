#' Arranca el silly game
#'
#' El silly game es una aventura conversacional. Tú eres un ser anónimo cuyo
#' objetivo es escapar de una celda. Tu principal misión es abrir la puerta.
#'
#' Para jugar, debes escribir órdenes para tu personaje. Algunos ejemplos de
#' órdenes son:
#' \preformatted{
#' >> explorar
#' >> mirar puerta
#' >> abrir puerta
#' >> salir
#' }
#'
#' @section Salir:
#' Si quieres salir del juego antes de que este termine, simplemente escribe:
#' \preformatted{
#' >> q
#' }
#'
#' @export
game <- function(){
  place <- cell
  while (place$state != "end"){
    state  <- play_turn(place)
    if (state == "end") break

    new_place <- get_place(state)
    if (place$name == new_place$name)
      place$state <- state
    else
      place <- new_place
  }
}

get_place <- function(state){

  place <- NULL
  for (p in places)
    for (s in p$states)
      if (s == state)
        place <- p

  place
}

play_turn <- function(place){

  # Get input from user
  input <- readline(prompt = ">> ")
  words <- unlist(stringr::str_split(input, " "))

  # Get action
  action <- NULL
  if (length(words) > 0) action <- words[1]

  # Get object
  object_name <- NULL
  object <- NULL
  if (length(words) > 1) object_name <- words[2]
  if (!is.null(object_name)){
    o_names <- names(place$objects)
    for (i in 1:length(place$objects))
      if (object_name == o_names[i])
        object <- place$objects[[i]]
  }

  # Execute action and get next state
  new_state <- execute_action(place, object, action)

  if (is.null(new_state))
    new_state <- place$state

  new_state

}

execute_action <- function(place, object, action){

  if (!(action %in% names(actions))){
    icat("Eso no tiene sentido")
    return(NULL)

  } else {
    return(actions[[action]](place, object))
  }

}
