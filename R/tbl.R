tbl.src_athena <- function(src, from, ...) {
  dplyr::tbl_sql("athena", src = src, from = from, ...)
}

# We're overwriting JDBCConnection here, and
# not something Athena-specific
db_query_fields.JDBCConnection <- function(con, sql, ...) {
  fields <- dplyr::build_sql(
    "SELECT * FROM ",
    dplyr::sql_subquery(con, sql),
    " LIMIT 0",
    con = con
  )
  qry <- DBI::dbGetQuery(con, fields)
  names(qry)
}
