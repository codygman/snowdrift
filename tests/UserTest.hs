{-# LANGUAGE OverloadedStrings #-}
module UserTest
    ( userSpecs
    ) where

import TestImport

import Control.Monad

userSpecs :: Spec
userSpecs = do
    let users :: [NamedUser]
        users = [minBound .. maxBound]

    ydescribe "user" $ do
        yit "creates a user" $ [marked|
            forM_ users $ \ user -> do
                get UserCreateR
                statusIs 200

                request $ do
                    setUrl UserCreateR
                    addNonce
                    setMethod "POST"
                    byLabel "Handle (private):" (username user)
                    byLabel "Passphrase:" (password user)
                    byLabel "Repeat passphrase:" (password user)

                statusIsResp 302
        |]

        yit "logs in as a user" $ [marked|
            forM_ users $ \ user -> do
                loginAs user
        |]
