-- @Author: admin
-- @Date:   2022-02-27 22:23:37
-- @Last Modified by:   admin
-- @Last Modified time: 2022-02-28 09:39:09

local string = require('string')

---@param str string the string target
---@param sep string the separator
function string.split(str,sep)
    local arry = {}
    if sep == nil then
      sep = '%s'
    end
    for word in string.gmatch(str,"([^"..sep.."]+)") do
        table.insert(arry,word)
    end
    return arry
end

---@param str string the target to split string
---@return table
local function splitAsWhiteSpace( str )
    local wordList = {};
    for _,word in ipairs(string.split(str,"%s")) do
        table.insert(wordList,word)
    end
    return wordList
end


function string.indexOf(str,target)
    local index = string.find(str,target,0)
    return index or -1
end
function string.trim(str)
  return string.gsub(str,"%s","")
end

---@param line string A line of frist
local function parseProtocolLine(line)
    local protocol = {}
    local list = splitAsWhiteSpace(line)
    local versionOrProtocol = string.split(list[3],'/')
    protocol['method'] = list[1]
    protocol['path'] = list[2]
    protocol['protocol'] = versionOrProtocol[1]
    protocol['version'] = versionOrProtocol[2]
    return protocol
end

---@param line string A line of header line
local function parseHeaderLines(line)
    return string.split(line,":")
end

local HTTParse = {
    HTTP = {
        protocol = "",
        version = 0,
        headers = {},
        method = "",
        path = "",
        query = {}
    }
}
function HTTParse:getHeader(key)
    return self.HTTP.headers[key]
end

function HTTParse:setHeader( key,value)
    self.HTTP.headers[key] = value
end

---@param key string the query key
function HTTParse:getQuery(key)
    return self.HTTP.query[key]
end


---@param key string the query key
---@param value string the query value
function HTTParse:setQuery(key,value)
    self.HTTP.query[key] = value
end

function HTTParse:parseQuery()
    local gl = string.split(self.HTTP.path,"?")
    self.HTTP.path = gl[1]
    local querys = string.split(gl[2],'&')
    for index,value in ipairs(querys) do
        local split = string.split(value,"=")
        self.HTTP.query[split[1]] = split[2]
    end
end

---@param stream string The http stream
function HTTParse:new(stream)
    local lines = string.split(stream,"\r\n")
    for index,line in ipairs(lines) do
        if string.indexOf(line,":") ~= -1 then
          local header = parseHeaderLines(line)
          self.HTTP.headers[header[1]] = string.trim(header[2])
        else
            if index == 1 then
                local firstLine = parseProtocolLine(line)
                self.HTTP.method = firstLine.method
                self.HTTP.version = firstLine.version
                self.HTTP.protocol = firstLine.protocol
                self.HTTP.path = firstLine.path
            end
        end
    end
    if string.indexOf(self.HTTP.path,'?') ~= -1 then
        self.parseQuery(self)
    end
    return self
end

return HTTParse;
