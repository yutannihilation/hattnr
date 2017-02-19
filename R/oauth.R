#' Get Hatena OAuth Token
#'
#' @name hatena_oauth
#'
#' @export
hatena_app <- function(key, secret) {
  oauth_app("Hatena",
            key = key,
            secret = secret)
}


#' @rdname hatena_oauth
#'
#' @export
hatena_endpoint <- function(){
  oauth_endpoint(request = "https://www.hatena.com/oauth/initiate",
                 authorize = "https://www.hatena.ne.jp/oauth/authorize",
                 access = "https://www.hatena.com/oauth/token")
}


#' @rdname hatena_oauth
#'
#' @export
init_oauth1.0_hatena <- function(endpoint, app, scope = "read_public") {
  # 1. Get an unauthorized request token
  sig_request <- oauth_signature(url = endpoint$request,
                                 method = "POST",
                                 app = app,
                                 other_params = list(oauth_callback = oauth_callback(),
                                                     scope = scope))
  response <- POST(endpoint$request, oauth_header(sig_request),
                   body = sprintf("scope=%s", URLencode(scope)))
  stop_for_status(response)
  params <- content(response)
  token <- params$oauth_token
  token_secret <- params$oauth_token_secret

  # 2. Authorize the token
  authorize_url <- modify_url(endpoint$authorize, query = list(oauth_token = token))
  verifier <- oauth_listener(authorize_url)
  verifier <- verifier$oauth_verifier %||% verifier[[1]]

  # 3. Request access token
  sig_access <- oauth_signature(url = endpoint$access,
                                method = "POST",
                                app = app,
                                token = token,
                                token_secret = token_secret,
                                other_params = list(oauth_verifier = verifier))
  response <- POST(endpoint$access, oauth_header(sig_access))
  stop_for_status(response)
  content(response)
}

#' @rdname hatena_oauth
#'
#' @export
TokenHatena <- R6::R6Class("TokenHatena", inherit = Token1.0, list(
  init_credentials = function(force = FALSE) {
    self$credentials <- init_oauth1.0_hatena(
      self$endpoint,
      self$app,
      scope = self$params$scope
    )
  }
))

#' @rdname hatena_oauth
#'
#' @examples
#' \dontrun{
#' library(httr)
#' token <- oauth1.0_token_hatena(hatena_endpoint(),
#'                                hatena_app(key = "key", secret = "secret"),
#'                                scope = "read_public,write_public")
#' GET("http://n.hatena.com/applications/my.json", config(token = token))
#' }
#'
#' @export
oauth1.0_token_hatena <- function(endpoint,
                                  app,
                                  cache = getOption("httr_oauth_cache"),
                                  scope = "read_public") {
  TokenHatena$new(app = app,
                  endpoint = endpoint,
                  params = list(as_header = TRUE, scope = scope),
                  cache_path = cache)
}
