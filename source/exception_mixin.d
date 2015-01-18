module exception_mixin;


template NewExceptionClass(string Name, string SuperClass)
{
    const char[] NewExceptionClass =
        q{class }~Name~" : "~SuperClass~q{
        {
            /++
            Params:
            msg = The message for the exception.
            file = The file where the exception occurred.
            line = The line number where the exception occurred.
            next = The previous exception in the chain of exceptions, if any.
            +/
            @safe pure nothrow
            this(string msg,
            string file = __FILE__,
            size_t line = __LINE__,
            Throwable next = null)
            {
                super(msg, file, line, next);
            }
        }};
}