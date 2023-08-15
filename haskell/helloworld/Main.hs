{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty

main = scotty 8000 $ do
  get "/" $ do
    html "Hello World!"