module std.extra.datetime;
public import std.datetime;

public immutable(TimeZone) defaultTimeZone(){
	return TimeZone.getTimeZone("Europe/Berlin");
}
