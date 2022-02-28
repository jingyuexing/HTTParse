
interface HTTPHeader {
    method: string;
    path: string;
    code: number;
    headers: Map<string, string>;
    body: object;
    protocol: string;
    query: object;
    version:number;
}

class Cookies {
    cookies: string;
    query: Map<string, string>
    constructor(cookies: string) {
        this.cookies = cookies;
        this.query = this.parser(this.cookies);
    }
    parser(cookies: string): Map<string, string> {
        let CookiesObject = new Map<string, string>();
        cookies = cookies.replace(/\s/g, '')
        let stringList = cookies.split(';');
        for (let cookie of stringList) {
            let keyAndValue = cookie.split("=");
            CookiesObject.set(keyAndValue[0], keyAndValue[1]);
        }
        return CookiesObject;
    }
    toString(): string {
        let cookies = "";
        this.query.forEach((value, key) => {
            cookies += `${key}=${value};`
        })
        return cookies.slice(0, -1);
    }
    getCookie(key: string): string | undefined {
        return this.query.get(key);
    }
    getCookies(): Map<string, string> {
        return this.query;
    }
    setCookie(key: string, value: string): void {
        this.query.set(key, value);
    }

}

var HTTParser = (function () {
    /**
     * 解析HTTP的响应头
     *
     * @param   {string}  header  响应头的字符串
     *
     * @return  {{"key":string,"value":string}} 解析完成后的对象
     */
    function parserHeaderLines(header: string) {
        header = header.replace(/\s/g, '');
        let head = header.split(":");
        let key = head[0];
        return {
            "key": key,
            "value": head[1]
        }
    }
    /**
     * 解析HTTP的第一行
     *
     * @param   {string}  line  协议行
     *
     * @return  {{method:string,path:string,protocol:string}} 解析后的对象
     */
    function parserProtocol(line: string) {
        let head = line.split(/\s/);
        let list = head[2].split('/')
        return {
            method: head[0],
            path: head[1],
            protocol: list[1],
            version: parseFloat(list[0])
        }
    }
    /**
     * 解析URL的请求参数
     *
     * @param   {string}  pathString  GET方法请求的链接
     *
     * @return  {{path:string,query:Map<string,string>}}    解析完成的对象
     */
    function parserQuery(pathString: string) {
        let querystring = pathString.split("?");
        let querys = querystring[1].split('&');
        let obj = new Map<string, string>();
        for (let query of querys) {
            let queryKV = query.split('=')
            obj.set(queryKV[0], queryKV[1]);
        }
        return {
            path: querystring[0],
            querys: obj
        };
    }
    /**
     * 解析HTTP协议字节流
     * @param {string} stream HTTP请求字符串
     */
    function HTTParser(stream: string) {
        var HTTP: HTTPHeader = {
            method: '',
            protocol: '',
            path: '',
            code: 0,
            query: {},
            version:0,
            headers: new Map<string, string>(),
            body: {}
        };
        let lines = stream.split("\r\n");
        for (let line of lines) {
            if (line.indexOf(':') != -1) {
                let obj = parserHeaderLines(line);
                HTTP.headers.set(obj.key, obj.value);
            } else {
                let obj = parserProtocol(line);
                HTTP.method = obj.method;
                HTTP.path = obj.path;
                HTTP.protocol = obj.protocol;
            }
        }
        let queryObject = parserQuery(HTTP.path);
        HTTP.path = queryObject.path;
        HTTP.query = queryObject.querys;
        return HTTP;
    }
    return HTTParser;
})();
