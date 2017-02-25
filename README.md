# rAthena

[Amazon Athena](https://aws.amazon.com/athena/) provides Presto as a managed service. It enables "server-less" SQL commands on arbitrary data, with a fast response time.

The package (`rAthena`) implements a [dplyr]() [backend]() for Amazon Athena.

The initial version of the package only supports simple queries. Future versions should add support for constructing table declarations as well.

# Example

```r
library(dplyr)
library(rAthena)

AWS_ACCESS_KEY = Sys.getenv("AWS_ACCESS_KEY")
AWS_SECRET_ACCESS_KEY = Sys.getenv("AWS_SECRET_ACCESS_KEY")
db <- src_athena(AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY,
                 s3_staging_dir = "s3://my-own-bucket"
      )
      
my_table <- db %>% tbl("default.elb_logs")

my_table %>%
    count(column)
```
