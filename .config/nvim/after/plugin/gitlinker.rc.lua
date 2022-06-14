local status, gitlinker = pcall(require, "gitlinker")
if (not status) then return end
gitlinker.setup()
