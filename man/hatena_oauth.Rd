% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oauth.R
\docType{data}
\name{hatena_oauth}
\alias{hatena_oauth}
\alias{hatena_app}
\alias{hatena_endpoint}
\alias{init_oauth1.0_hatena}
\alias{TokenHatena}
\alias{oauth1.0_token_hatena}
\title{Get Hatena OAuth Token}
\format{An object of class \code{R6ClassGenerator} of length 24.}
\usage{
hatena_app(key, secret)

hatena_endpoint()

init_oauth1.0_hatena(endpoint, app, scope = "read_public")

TokenHatena

oauth1.0_token_hatena(endpoint, app, cache = getOption("httr_oauth_cache"),
  scope = "read_public")
}
\description{
Get Hatena OAuth Token
}
\examples{
\dontrun{
library(httr)
token <- oauth1.0_token_hatena(hatena_endpoint(),
                               hatena_app(key = "key", secret = "secret"),
                               scope = "read_public,write_public")
GET("http://n.hatena.com/applications/my.json", config(token = token))
}

}
\keyword{datasets}
