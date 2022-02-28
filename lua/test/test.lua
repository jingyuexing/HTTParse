-- @Author: admin
-- @Date:   2022-02-27 23:43:44
-- @Last Modified by:   admin
-- @Last Modified time: 2022-02-28 10:14:56

local HTTPars = require "src.HTTPars"

local testSample = "GET / HTTP/1.1\r\nHost: bing.com\r\nSec-Ch-Ua: \" Not A;Brand\";v=\"99\", \"Chromium\";v=\"92\"\r\nSec-Ch-Ua-Mobile: ?0\r\nUpgrade-Insecure-Requests: 1\r\nUser-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\r\nSec-Fetch-Site: none\r\nSec-Fetch-Mode: navigate\r\nSec-Fetch-User: ?1\r\nSec-Fetch-Dest: document\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nConnection: close\r\n"
local s = HTTPars.new(HTTPars,testSample);
print(s)
