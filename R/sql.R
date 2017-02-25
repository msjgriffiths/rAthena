sql_escape_ident.JDBCConnection <- function(con, x) {
  # No escaping names
  x
}

sql_translate_env.JDBCConnection <- function(con) {
  dplyr:::sql_translate_env.NULL(con)
}
