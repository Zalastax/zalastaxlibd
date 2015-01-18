module std.extra.http;
import std.extra.zlib;
public import std.net.curl;
public import std.outbuffer;


@property public void postMessage(HTTP http, string message){
    http.contentLength = message.length;
    http.onSend = (void[] data) {
        auto msg = cast(void[])message;
        size_t len = msg.length > data.length ? data.length : msg.length;
        if (len == 0) return len;
        data[0..len] = msg[0..len];
        message = message[len..$];
        return len;
    };
}

public void onReceiveWriteOnlyTo(HTTP http, OutBuffer buffer){
    http.onReceive = (ubyte[] data) {
        buffer.write(data);
        return data.length;
    };
}

/**
* Sets onReceive of http to its own method.
* Calls perform on http.
* Decrypts the received data.
* Sets onReceive of http to a do nothing method.
*/
public string performAndDecryptGzip(HTTP http){
    OutBuffer buffer = new OutBuffer();
    http.onReceiveWriteOnlyTo(buffer);
    http.perform();
    http.onReceive = (ubyte[] data){
        return data.length;
    };
    return fromGzip(buffer);
}