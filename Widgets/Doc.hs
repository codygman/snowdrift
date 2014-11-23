module Widgets.Doc where

import Import
import Model.Markdown

renderDoc :: Text -> Widget
renderDoc name = do
    page <- handlerToWidget $ runYDB $ get404 . docCurrentVersion . entityVal =<< getBy404 (UniqueDocName name)
    $(widgetFile "doc")
