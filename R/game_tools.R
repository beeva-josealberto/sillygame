icat <- function(message){
  message <- stringi::stri_unescape_unicode(message)
  cat(message, fill = TRUE)
}
