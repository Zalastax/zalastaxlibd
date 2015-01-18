module std.extra.container;
public import std.container;

auto toResizableBinaryHeap(alias less = "a < b", Store)(Store[] arr)
{
    auto wrapped = Array!Store(arr);
    return heapify!less(wrapped);
}