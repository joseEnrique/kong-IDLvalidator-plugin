local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.idlvalidator.access"

local IdlValidatorHandler = BasePlugin:extend()

IdlValidatorHandler.PRIORITY = 900

function IdlValidatorHandler:new()
  IdlValidatorHandler.super.new(self, "idlvalidator")
end

function IdlValidatorHandler:access(conf)
  IdlValidatorHandler.super.access(self)
  access.execute(conf)
end

return IdlValidatorHandler