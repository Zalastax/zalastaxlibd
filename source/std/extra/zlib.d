module std.extra.zlib;
public import std.zlib;
public import std.outbuffer;

string fromGzip(OutBuffer buffer){
    UnCompress uncompresser = new UnCompress(HeaderFormat.gzip);
    auto bufferBytes = cast(void[])buffer.toBytes();
    auto firstPart = uncompresser.uncompress(bufferBytes);
    auto rest = uncompresser.flush();
    return cast(string)(firstPart ~ rest);
}