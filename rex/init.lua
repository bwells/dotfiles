-- Rex key bindings. Rex reads ~/.config/rex/init.lua (bootstrap links it here).
-- Rex doesn't watch this file: reload with `rex config reload` or the in-app
-- Reload Config action. Shortcuts recorded in the app override this file.

rex.bind("ctrl+h", "client.tab.previous")
rex.bind("ctrl+l", "client.tab.next")
