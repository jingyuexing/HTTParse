-- @Author: admin
-- @Date:   2022-02-27 23:43:44
-- @Last Modified by:   admin
-- @Last Modified time: 2022-03-01 16:21:59

local HTTPars = require "src.HTTPars"
local HTTParse = HTTPars.HTTParse
local Cookies = HTTPars.Cookies
local response = "HTTP/1.1 200\r\nServer: cnic\r\nDate: Tue, 01 Mar 2022 05:56:48 GMT\r\nContent-Type: text/html; charset=utf-8\r\nTransfer-Encoding: chunked\r\nConnection: keep-alive\r\nAccess-Control-Allow-Origin: *\r\nAccess-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, HEAD\r\nAccess-Control-Max-Age: 3600\r\nAccess-Control-Allow-Headers: origin, content-type, accept, authorization\r\nAccess-Control-Allow-Credentials: true\r\nLast-Modified: Mon, 21 Dec 2020 06:19:14 GMT\r\nCache-Control: max-age=86400\r\nContent-Encoding: gzip"
local testSample = "GET /?m=12&ck=49 HTTP/1.1\r\nHost: bing.com\r\nSec-Ch-Ua: \" Not A;Brand\";v=\"99\", \"Chromium\";v=\"92\"\r\nSec-Ch-Ua-Mobile: ?0\r\nUpgrade-Insecure-Requests: 1\r\nUser-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\r\nSec-Fetch-Site: none\r\nSec-Fetch-Mode: navigate\r\nSec-Fetch-User: ?1\r\nSec-Fetch-Dest: document\r\nAccept-Encoding: gzip, deflate\r\nAccept-Language: en-US,en;q=0.9\r\nConnection: close\r\n"
local s = HTTParse.new({},testSample);
local res = HTTParse.new({},response);
-- print(s)
local m = ";sssssdef;"
local cookies = "BAIDUID=AC99BB1CC989FB134367A0BAB2A15BDB:FG=1; PSTM=1623512407; BIDUPSID=73CAB809EBE0408ED164D4488E04DE05; Hm_lvt_aec699bb6442ba076c8981c6dc490771=1636361512; COOKIE_SESSION=263_1_6_6_4_10_0_1_6_4_5_3_11893_0_0_0_1636181136_1636169251_1636361509%7C7%230_1_1636169240%7C1; BAIDUID_BFESS=D18B18E8CFCEDDF27B4ACD25C1A201A3:FG=1; BAIDU_WISE_UID=wapp_1636904853151_259; baikeVisitId=1da78159-53a8-4f88-845a-8e39f9d29d17; BD_HOME=1; H_PS_PSSID=35839_34429_35106_31253_35762_35979_35914_34584_35872_35948_35931_35984_26350; BD_UPN=12314753; BA_HECTOR=a521000k2g0084a09t1h1rknr0r"
local newCookies = Cookies.new({},cookies);

print(newCookies.toString(newCookies))
