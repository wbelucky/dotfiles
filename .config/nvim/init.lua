require "rc.conf.core"
require "rc.conf.lazy"

local status, private_init = pcall(require, "private.init")
if status then
  private_init.setup()
end
