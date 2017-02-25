#' Connect to Amazon Athena
#'
#' @param user
#' @param password
#' @param s3_staging_dir
#' @param ...
#'
#' @return
#' @export
#'
#' @description
#'
#' Provides a rough layer of compatibility between dplyr and Athena.
#'
#' @examples
#'
#' db <- src_athena(
#'          Sys.getenv("AWS_KEY"),
#'          Sys.getenv("AWS_SECRET"),
#'          "s3://my-custom-bucket"
#'       )
#'
src_athena <- function(user, password, s3_staging_dir, ...) {

  jdbc_driver = system.file("java", "AthenaJDBC41-1.0.0.jar", package = "rAthena")

  driver <- athena_driver(jdbc_driver)

  con <- DBI::dbConnect(
    driver,
    url = "jdbc:awsathena://athena.us-east-1.amazonaws.com:443",
    user = user %||% "",
    password = password %||% "",
    s3_staging_dir = s3_staging_dir %||% "",
    ...
  )

  dplyr::src_sql("athena", con, auto_disconnect = TRUE)
}

athena_driver <- function(driver) {
  RJDBC::JDBC(
    "com.amazonaws.athena.jdbc.AthenaDriver",
    driver,
    identifier.quote = "'"
  )
}

src_desc.src_athena <- function(x) {
  return("Amazon Athena")
}

format.src_athena <- function(x, ...) {
  paste0(
    "src:  ", dplyr::src_desc(x), "\n",
    dplyr:::wrap("dbs: ", paste0(sort(dplyr::src_tbls(x)), collapse = ", "))
  )
}

src_tbls.src_athena <- function(x) {
  con <- x$con

  res = DBI::dbGetQuery(con, "SHOW DATABASES")
  unlist(res, use.names = FALSE)
}
