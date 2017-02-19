R Package To Get OAuth Token For Hatena
=======================================

Why?
----

You may wonder why I created this while httr has a standard function for OAuth 1.0. But it doesn't work for Hatena. See [my blog post](http://notchained.hatenablog.com/entry/2017/02/18/142035) (Japanese)


Installation
------------

```r
devtools::install_github("yutannihilation/hattnr")
```

Usage
-----

```r
library(httr)

token <- oauth1.0_token_hatena(hatena_endpoint(),
                               hatena_app(key = "key", secret = "secret"),
                               scope = "read_public,write_public")
                               
GET("http://n.hatena.com/applications/my.json", config(token = hatena_token))
```
