Module:    Factorial
Synopsis:  Factorial "application."
Author:    Steve Rowley
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

///
/// The canonical recursive function.
///

define function factorial (n :: <integer>) => (n! :: <integer>)
  case
    n < 0     => error("Can't take factorial of negative integer: %d\n", n);
    n = 0     => 1;
    otherwise => n * factorial(n - 1);
  end
end;

define function factorial-top-level () => ()
  let arguments = application-arguments();
  if (arguments.size == 0)
    format-out("Usage: %s number ...\n", application-name());
  else
    format-out("$maximum-integer = %d\n", $maximum-integer);
    format-out("$minimum-integer = %d\n", $minimum-integer);
    for (i from 0 below size(arguments))
      let arg = arguments[i];
      block (loop-continue)
        let n = block ()
                  string-to-integer(arg);
                exception (<error>)
                  format-out("Skipping invalid argument %=.\n", arg);
                  loop-continue();
                end block;
        let n! = 0;
	profiling (cpu-time-seconds, cpu-time-microseconds)
	  n! := factorial(n)
	results
          format-out("factorial(%d) = %d (in %d.%s seconds)\n", n, n!,
		     cpu-time-seconds, integer-to-string(cpu-time-microseconds, size: 6));
        end profiling;
      exception (e :: <error>)
        format-out("factorial(%s) - Error: %s\n", arg, e);
      end block;
    end for;
  end if;
end function factorial-top-level;

factorial-top-level();

