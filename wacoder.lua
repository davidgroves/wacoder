local LibDeflate = require "Libs.LibDeflate"
local LibSerialize = require "Libs.LibSerialize"
local Inspect = require "Libs.Inspect"

local args = {...}

local function decode(filename)
  local file = io.open(filename, "r")
  if not file then
    io.stderr:write("ERROR: Couldn't open file: " .. filename .. "\n")
    os.exit(1)
  end

  local content = file:read "*a"
  local content_stripped = string.sub(content, 7)
  -- print(content_stripped)

  local content_decoded = LibDeflate:DecodeForPrint(content_stripped)
  local content_decompressed = LibDeflate:DecompressDeflate(content_decoded)
  local content_deserialized = LibSerialize:DeserializeValue(content_decompressed)
  local string_repr = Inspect.inspect(content_deserialized)
  return string_repr
end

local function encode(filename)
  local file = io.open(filename, "r")
  if not file then
    io.stderr:write("ERROR: Couldn't open file: " .. filename .. "\n")
    os.exit(1)
  end

  local content = file:read "*a"
  local content_set = "table = " .. content
  loadstring(content_set)()

  local content_serialised = LibSerialize:Serialize(table)
  local content_compressed = LibDeflate:CompressDeflate(content_serialised)
  local content_encoded = LibDeflate:EncodeForPrint(content_compressed)
  local content_with_header = "!WA:2!" .. content_encoded
  return content_with_header
end


for i,_ in ipairs(args) do
  if args[i] == "--help" then
    print("Usage: ./coder.lua --decode | --encode <filename>")
  end
  if args[i] == "--decode" then
    local decoded = decode(args[i+1])
    print(decoded)
  end
  if args[i] == "--encode" then
    local encoded = encode(args[i+1])
    print(encoded)
  end
end
