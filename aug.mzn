include "globals.mzn";
include "global_calendar.mzn";
include "SIC2.mzn";
include "TEN_WEEK_OUTPUT.mzn";

/* NO NEED 
%%include "staff_sic.mzn";
%%include "CSV_OUTPUT.mzn";
*/

int: DAYS = 70;
set of int: days = 1..DAYS;

enum docs = {ew, gm, db, mc, cc, hl, dl, rm, pa, tb, lb, lc, dh, sk, ml, jl, gn, rp, ar, ls, av, jc, fh, xh, ck, blee, bm, km, ltang, aw, mlynch, yp, lw};
enum shifts = {u, i, x, l, a, o, c, p, s, phnw, perl, mat, lwop, pat, sabb, dfl, lppa, al, cl};
set of shifts: leave_shifts = {phnw, perl, mat, lwop, pat, sabb, dfl, lppa, al, cl};

% ===== DECISION VARIABLES =====
array[docs, 1..DAYS] of var shifts: roster;

% ===== CONSTRAINTS =====
 constraint forall(doc in docs, day in 1..DAYS)
 (if       u in requests[doc,day] then roster[doc,day]=o
  elseif   x in requests[doc,day] then roster[doc,day]=o
  else roster[doc, day] in requests[doc, day]
 endif);


%% REQUESTS ARRAY 
array[docs, 1..DAYS] of set of shifts: requests =
array2d(docs, 1..DAYS, [
% ew 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END ew

% gm 
{c}, {p}, {a, p, o, c}, {c}, {a, p, o, c}, {a}, {a, p, o, c}, 
{c}, {p}, {a, p, o, c}, {c}, {a, p, o, c}, {a, p, o, c}, {a}, 
{c}, {p}, {a, p, o, c}, {c}, {a}, {a, p, o, c}, {a, p, o, c}, 
{c}, {p}, {a, p, o, c}, {c}, {a}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END gm

% db 
{a}, {p}, {o}, {c}, {a}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {p}, {o}, {a, p, o, c}, {a}, {a}, {a}, 
{a, p, o, c}, {a}, {a}, {a}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a}, {p}, {o}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{cl}, {cl}, {cl}, {cl}, {cl}, {cl}, {cl}, 
{cl}, {cl}, {cl}, {cl}, {cl}, {cl}, {cl}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END db

% mc 
{a, p, o, c}, {a}, {p}, {c}, {a}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {p}, {c}, {a}, {p}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END mc

% cc 
{o}, {a}, {a}, {a}, {p}, {a, p, o, c}, {a, p, o, c}, 
{p}, {a, p, o, c}, {a}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, o}, {a, p, o, c}, {a, p, o, c}, 
{cl}, {cl}, {cl}, {cl}, {cl}, {cl}, {cl}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END cc

% hl 
{o}, {c}, {a}, {a}, {p}, {o}, {o}, 
{a}, {a}, {c}, {p}, {o}, {o}, {o}, 
{o}, {a}, {c}, {p}, {o}, {a}, {a}, 
{o}, {a}, {c}, {p}, {o}, {o}, {o}, 
{a}, {a}, {c}, {p}, {o}, {o}, {o}, 
{a}, {a}, {c}, {p}, {o}, {o}, {o}, 
{o}, {a}, {c}, {p}, {o}, {a}, {a}, 
{o}, {a}, {a, p, o, c}, {p}, {o}, {o}, {o}, 
{o}, {a}, {c}, {a}, {p}, {o}, {o}, 
{a}, {a}, {c}, {p}, {o}, {o}, {o}
, % END hl

% dl 
{o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}
, % END dl

% rm 
{a}, {p}, {c}, {a, p, o, c}, {a}, {o}, {o}, 
{a}, {a, p, o, c}, {c}, {a}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {a, p, o, c}, {cl}, {cl}, {cl}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {o}
, % END rm

% pa 
{a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{al}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{cl}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END pa

% tb 
{al}, {al}, {c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a}, {c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END tb

% lb 
{a}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a}, {a}, 
{a, p, o, c}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, {o}, {a, p, o, c}, 
{a}, {a, p, o, c}, {a}, {a, p, o, c}, {o}, {o}, {o}, 
{a}, {a}, {o}, {o}, {o}, {o}, {o}, 
{a}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, 
{cl}, {cl}, {cl}, {cl}, {cl}, {cl}, {cl}, 
{a, p, o, c}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, {a}, {a}, 
{a, p, o, c}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END lb

% lc 
{a, p, o, c}, {p}, {a, p, o, c}, {a}, {a, p, o, c}, {p}, {p}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a}, {a, p, o, c}, {p}, {a, p, o, c}, {o}, {o}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a}, {a, p, o, c}, {o}, {o}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a}, {a, p, o, c}, {o}, {o}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a}, {a, p, o, c}, {o}, {o}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {p}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END lc

% dh 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}, 
{perl}, {perl}, {perl}, {perl}, {perl}, {perl}, {perl}
, % END dh

% sk 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END sk

% ml 
{a, p, o, c}, {a, p, o, c}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, {a}, 
{a, p, o, c}, {a, p, o, c}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a, p, o, c}, {al}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {al}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END ml

% jl 
{a, p, o, c}, {a, p, o, c}, {c}, {a, p, o, c}, {a, p, o, c}, {a}, {a}, 
{a, p, o, c}, {p}, {c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {o}, 
{o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {a, p, o, c}, {a, p, o, c}, 
{o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {a, p, o, c}
, % END jl

% gn 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{p}, {a, p, o, c}, {p}, {c}, {a, p, o, c}, {p}, {a, p, o, c}, 
{p}, {a, p, o, c}, {p}, {c}, {a, p, o, c}, {p}, {a, p, o, c}, 
{p}, {a, p, o, c}, {p}, {c}, {a, p, o, c}, {p}, {a, p, o, c}, 
{p}, {a, p, o, c}, {p}, {c}, {a, p, o, c}, {p}, {a, p, o, c}, 
{p}, {a, p, o, c}, {p}, {c}, {a, p, o, c}, {p}, {a, p, o, c}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{al}, {a, p, o, c}, {p}, {c}, {a, p, o, c}, {p}, {a, p, o, c}
, % END gn

% rp 
{a, p, o, c}, {cl}, {cl}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a}, {a}, {c}, {a, p, o, c}, {a, p, o, c}, {p}
, % END rp

% ar 
{a, p, o, c}, {a, p, o, c}, {perl}, {perl}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END ar

% ls 
{p}, {a, p, o, c}, {c}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, 
{p}, {a, p, o, c}, {c}, {a, p, o, c}, {a, p, o, c}, {a}, {a, p, o, c}, 
{a}, {a, p, o, c}, {c}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, 
{p}, {a, p, o, c}, {c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, 
{p}, {a, p, o, c}, {c}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, 
{p}, {a, p, o, c}, {c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{p}, {a, p, o, c}, {c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{p}, {a, p, o, c}, {c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a}, 
{a}, {a, p, o, c}, {c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}
, % END ls

% av 
{a, p, o, c}, {c}, {p}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, 
{a}, {c}, {p}, {a, p, o, c}, {o}, {a}, {a}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {a, p, o, c}, {a, p, o, c}, 
{a, o}, {o}, {o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END av

% jc 
{p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {phnw}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}
, % END jc

% fh 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END fh

% xh 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, 
{cl}, {cl}, {cl}, {cl}, {cl}, {cl}, {cl}, 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a}, 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a}
, % END xh

% ck 
{p}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{al}, {al}, {al}, {a, p, o, c}, {a, p, o, c}, {p}, {p}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {a, p, o, c}, {a, p, o, c}
, % END ck

% blee 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{a, p, o, c}, {a, p, o, c}, {o}, {a, p, o, c}, {a, p, o, c}, {o}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, 
{o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {o}, {a, p, o, c}, 
{o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {o}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {o}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END blee

% bm 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {p}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {p}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {p}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}
, % END bm

% km 
{p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{al}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, 
{p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END km

% ltang 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END ltang

% aw 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END aw

% mlynch 
{a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a}, {a, p, o, c}, 
{a, p, o, c}, {p}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{lppa}, {lppa}, {lppa}, {lppa}, {lppa}, {lppa}, {lppa}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}, 
{al}, {al}, {al}, {al}, {al}, {al}, {al}
, % END mlynch

% yp 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
, % END yp

% lw 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {p}, {p}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}
 % END lw

]);   %% END REQUEST ARRAY


 % ============================================================
 % HARD/SOFT DISPATCHER 
 % ============================================================
 int: HARD = 100; 
 predicate rule(var bool: is_hard, var int: v, var bool: cond) = 
     v >= (if cond then 0 else if is_hard then HARD else 1 endif endif); 
 
 
 %predicate rule(var bool: is_hard, var int: v, var bool: cond) =  
 %    if is_hard then  
 %        cond /\ (v = 0)  
 %    else  
 %        v >= 1 - bool2int(cond)  
 %   endif; 
  
 array[docs,days] of var int: V_request; 
  
 constraint 
   forall(d in docs, t in days)( 
     rule(false, V_request[d,t], roster[d,t] in requests[d,t])); 
  
 %REQUEST VIOLATIONS 
 output [ 
   if fix(V_request[d,t]) > 0 then 
     "Request violation: doc=" ++ show(d) 
     ++ " day=" ++ show(t) 
     ++ " requested=" ++ show(requests[d,t]) 
     ++ " but rostered=" ++ show(roster[d,t]) ++ "\n" 
   else "" endif 
   | d in docs, t in days 
 ]; 
  
 %REMAINING VIOLATIONS 
 % ============================================================ 
 % SINGLE VIOLATION ARRAY 
 % ============================================================ 
 % you can manually increment RULES each time you create a rule 
 %  
 array[1..RULES] of var int: V; 
  
 % ============================================================ 
 % APPLY RULES 
 % ============================================================ 
 bool: F = false; 
 bool: T = true;  
 %global counts
 constraint rule(T, V[1],(forall(d in mondays)   (count([roster[doc,d]|doc in docs],a) in 3..6)));
 constraint rule(T, V[2],(forall(d in mondays)   (count([roster[doc,d]|doc in docs],p) in 3..6)));
 constraint rule(T, V[3],(forall(d in tuesdays)  (count([roster[doc,d]|doc in docs],a) in 3..6)));
 constraint rule(T, V[4],(forall(d in tuesdays)  (count([roster[doc,d]|doc in docs],p) in 3..6)));
 constraint rule(T, V[5],(forall(d in wednesdays)(count([roster[doc,d]|doc in docs],a) in 3..6)));
 constraint rule(T, V[6],(forall(d in wednesdays)(count([roster[doc,d]|doc in docs],p) in 3..6)));
 constraint rule(T, V[7],(forall(d in thursdays) (count([roster[doc,d]|doc in docs],a) in 3..6)));
 constraint rule(T, V[8],(forall(d in thursdays) (count([roster[doc,d]|doc in docs],p) in 3..6)));
 constraint rule(T, V[9],(forall(d in fridays)   (count([roster[doc,d]|doc in docs],a) in 3..6)));
 constraint rule(T, V[10],(forall(d in fridays)   (count([roster[doc,d]|doc in docs],p) in 3..6)));
 constraint rule(T, V[11],(forall(d in saturdays) (count([roster[doc,d]|doc in docs],a) in 3..6)));
 constraint rule(T, V[12],(forall(d in saturdays) (count([roster[doc,d]|doc in docs],p) in 3..6)));
 constraint rule(T, V[13],(forall(d in sundays)   (count([roster[doc,d]|doc in docs],a) in 3..6)));
 constraint rule(T, V[14],(forall(d in sundays)   (count([roster[doc,d]|doc in docs],p) in 3..6)));

/*  ew  */constraint rule(T, V[15],each_week(ew,{c},{c},{c},{p,o},{o},{o,p},{o}));
/*  ew  */constraint rule(T, V[16],assign_shifts(ew,thursday,p,1,8));
/*  ew  */constraint rule(T, V[17],assign_shifts(ew,saturday,p,1,8));
/*  ew  */constraint rule(T, V[18],sh_per_fn(ew,4));

/*  gm  */constraint rule(T, V[19],assign_shifts(gm,saturday,a,0) /* does the comment thing work */);
/*  gm  */constraint rule(T, V[20],assign_shifts(gm,saturday,p,0));
/*  gm  */constraint rule(T, V[21],assign_shifts(gm,sunday,a,2,4));
/*  gm  */constraint rule(T, V[22],assign_shifts(gm,sunday,p,0));
/*  gm  */constraint rule(T, V[23],each_week(gm,{c,o},{p,o},{o},{c,o},{a,o},{o},{a,o}));
/*  gm  */constraint rule(T, V[24],sh_per_fn(gm,4));
/*  gm  */constraint rule(T, V[25],shifts_apc(gm,[0,1,2],[1,1,2],[1,0,0],4));

/*  db  */constraint rule(T, V[26],shifts_apc(db,[1,1,0],[3,1,1],[4,0,0],4));
/*  db  */constraint rule(T, V[27],assign_shifts(db,friday,p,2,2));
/*  db  */constraint rule(T, V[28],each_week(db,{o,a},{o,a,p},{o},{a,o},{a,o,p},{a,o,p},{a,o,p}));
/*  db  */constraint rule(T, V[29],weekends_ap(db,2,0,2,0));
/*  db  */constraint rule(T, V[30],no_split_weekend(db));
/*  db  */constraint rule(T, V[31],true /*isolate_weekend(db)*/);
/*  db  */constraint rule(T, V[32],no_am_after_pm(db));
/*  db  */constraint rule(T, V[33],free_weekend_before_leave(db));
/*  db  */constraint rule(T, V[34],true /*sh_per_fn(db,4)*/);

/*  mc  */constraint rule(T, V[35],shifts_2a1p1c(mc,4));
/*  mc  */constraint rule(T, V[36],sh_per_fn(mc,4));
/*  mc  */constraint rule(T, V[37],each_week(mc,{a,o},{a,o},{a,o,p},{c,o},{a,o,p},{a,o,p},{a,o,p}));
/*  mc  */constraint rule(T, V[38],FRI_P(mc,2,2));
/*  mc  */constraint rule(T, V[39],weekends_ap(mc,1,1,1,1));
/*  mc  */constraint rule(T, V[40],split_weekends(mc));
/*  mc  */constraint rule(T, V[41],no_am_after_pm(mc));
/*  mc  */constraint rule(T, V[42],roster[mc,48] = o /\ roster[mc,49]=o /*one off for this roster*/);
/*  mc  */constraint rule(T, V[43],free_weekend_before_leave(mc));

/*  cc  */constraint rule(T, V[44],shifts_apc(cc,[1,1,0],[3,1,0],[4,0,0],4));
/*  cc  */constraint rule(T, V[45],sh_per_fn(cc,4));
/*  cc  */constraint rule(T, V[46],each_week(cc,{o,p,a},{o,a},{a,o},{a,o},{a,o,p},{a,o,p},{a,o,p}));
/*  cc  */constraint rule(T, V[47],weekends_ap(cc,2,0,2,0));
/*  cc  */constraint rule(T, V[48],FRI_P(cc,2,2));
/*  cc  */constraint rule(T, V[49],no_split_weekend(cc) /\ free_weekend_before_leave(cc));
/*  cc  */constraint rule(T, V[50],isolate_weekend(cc));
/*  cc  */constraint rule(T, V[51],no_am_after_pm(cc));

/*  hl  */constraint rule(T, V[52],just_single_requests(hl));

/*  dl  */constraint rule(T, V[53],shifts_2a1p1c(dl,4));
/*  dl  */constraint rule(T, V[54],sh_per_fn(dl,4));
/*  dl  */constraint rule(T, V[55],each_week(dl,{a,o},{a,p,o},{c,o},{o},{a,p,o},{a,p,o},{a,p,o}));
/*  dl  */constraint rule(T, V[56],weekends_ap(dl,1,1,1,1) /*1 sat am 1 sat p 1 sun am 1 sun pm*/);
/*  dl  */constraint rule(T, V[57],no_split_weekend(dl));
/*  dl  */constraint rule(T, V[58],no_consec_weekends(dl));
/*  dl  */constraint rule(T, V[59],FRI_P(dl,2,2));
/*  dl  */constraint rule(T, V[60],no_am_after_pm(dl));

/*  rm  */constraint rule(T, V[61],shifts_2a1p1c(rm,4));
/*  rm  */constraint rule(T, V[62],sh_per_fn(rm,4));
/*  rm  */constraint rule(T, V[63],each_week(rm,{a,o},{a,p,o},{c,cl},{a,o,cl},{a,p,o,cl},{a,p,o},{a,p,o}) /* temp cl */);
/*  rm  */constraint rule(T, V[64],weekends_ap(rm,2,0,2,0) /*two sat am two sun am*/);
/*  rm  */constraint rule(T, V[65],no_split_weekend(rm));
/*  rm  */constraint rule(T, V[66],no_consec_weekends(rm));
/*  rm  */constraint rule(T, V[67],FRI_P(rm,2,2));
/*  rm  */constraint rule(T, V[68],no_am_after_pm(rm));
/*  rm  */constraint rule(T, V[69],isolate_weekend(rm));

/*  pa  */constraint rule(T, V[70],just_single_requests(pa));

/*  tb  */constraint rule(T, V[71],shifts_apc(tb,[0,1,1],[1,1,1],[2,2,0],3));
/*  tb  */constraint rule(T, V[72],WED_C(tb));
/*  tb  */constraint rule(T, V[73],TUE_P(tb,0,0));
/*  tb  */constraint rule(T, V[74],weekends_ap(tb,1,1,1,1));
/*  tb  */constraint rule(T, V[75],isolate_weekend(tb));
/*  tb  */constraint rule(T, V[76],no_split_weekend(tb));
/*  tb  */constraint rule(T, V[77],FRI_P(tb,2,3));
/*  tb  */constraint rule(T, V[78],each_week(tb,{a,o,p},{a,o},{c},{a,o,p},{a,o,p},{a,o,p},{a,o,p}));
/*  tb  */constraint rule(T, V[79],sh_per_fn(tb,3));
/*  tb  */constraint rule(T, V[80],no_am_after_pm(tb));

/*  lb  */constraint rule(T, V[81],each_week(lb,{o},{a,o},{a,o},{o},{o},{a,o},{a,o}));
/*  lb  */constraint rule(T, V[82],weekends_ap(lb,2,0,2,0));
/*  lb  */constraint rule(T, V[83],no_split_weekend(lb));
/*  lb  */constraint rule(T, V[84],shifts_apc(lb,[2,0,0],[2,0,0],[4,0,0],3));

/*  lc  */constraint rule(T, V[85],each_week(lc,{o},{a,o,p},{o},{a,p,o},{o},{a,p,o},{a,p,o}));
/*  lc  */constraint rule(T, V[86],weekends_ap(lc,2,2));
/*  lc  */constraint rule(T, V[87],no_split_weekend(lc) /\ no_consec_weekends(lc));
/*  lc  */constraint rule(T, V[88],shifts_apc(lc,[1,1,0],[1,1,0],[2,2,0],3));


/*  sk  */constraint rule(T, V[89],each_week(sk,{a,o},{c,o},{o,p},{o},{o},{a,p,o},{a,p,o}));
/*  sk  */constraint rule(T, V[90],weekends_ap(sk,1,1,1,1));
/*  sk  */constraint rule(T, V[91],no_split_weekend(sk) /\ no_consec_weekends(sk) /\ no_mon_after_sun(sk));

/*  ml  */constraint rule(T, V[92],each_week(ml,{o},{o},{a},{c,a},{o},{o},{a,p}));
/*  ml  */constraint rule(T, V[93],assign_shifts(ml,thursday,c,0,2));
/*  ml  */constraint rule(T, V[94],sh_per_fn(ml,3));
/*  ml  */constraint rule(T, V[95],assign_shifts(ml,sunday,a,3,10));
/*  ml  */constraint rule(T, V[96],assign_shifts(ml,sunday,p,3,10));
/*  ml  */constraint rule(T, V[97],forall(d in mondays union tuesdays union fridays union saturdays)(roster[ml,d]=o) /*explicit days off*/);

/*  jl  */constraint rule(T, V[98],week_one(jl,{o},{a,o},{c},{a,o},{o},{a,p,o},{a,p,o}));
/*  jl  */constraint rule(T, V[99],week_two(jl,{o},{p,o},{c},{p,o},{o},{a,p,o},{a,p,o}));
/*  jl  */constraint rule(T, V[100],weekends_ap(jl,1,1,1,1));
/*  jl  */constraint rule(T, V[101],no_split_weekend(jl));
/*  jl  */constraint rule(T, V[102],just_sh_per_fn(jl,3));

/*  gn  */constraint rule(T, V[103],each_week(gn,{p},{o},{p},{c},{o},{p},{o}));

/*  rp  */constraint rule(T, V[104],each_week(rp,{o},{a},{a},{c},{o},{o},{p}));

/*  ar  */constraint rule(T, V[105],each_week(ar,{o},{o},{a},{a,o},{o},{a},{o}));
/*  ar  */constraint rule(T, V[106],sh_per_fn(ar,2));

/*  ls  */constraint rule(T, V[107],just_single_requests(ls));

/*  av  */constraint rule(T, V[108],shifts_apc(av,[1,1,1],[1,1,1],[2,2,0],3));
/*  av  */constraint rule(T, V[109],weekends_ap(av,1,1,1,1));
/*  av  */constraint rule(T, V[110],FRI_P(av,2,2));
/*  av  */constraint rule(T, V[111],no_split_weekend(av));
/*  av  */constraint rule(T, V[112],isolate_weekend(av));
/*  av  */constraint rule(T, V[113],each_week(av,{a,p,o,c},{a,o,c},{a,p,o,c},{a,p,o,c},{a,p,o,c},{a,p,o},{a,p,o}));


/*  fh  */constraint rule(T, V[114],no_shifts(fh));

/*  xh  */constraint rule(T, V[115],just_single_requests(xh));

/*  ck  */constraint rule(T, V[116],each_week(ck,{a,p,o},{a,p,o},{a,p,o},{a,p,o},{a,p,o},{a,p,o},{a,p,o}));
/*  ck  */constraint rule(T, V[117],no_am_after_pm(ck));
/*  ck  */constraint rule(T, V[118],weekends_ap(ck,5,5));
/*  ck  */constraint rule(T, V[119],no_split_weekend(ck));
/*  ck  */constraint rule(T, V[120],just_sh_per_fn(ck,4));
/*  ck  */constraint rule(T, V[121],no_three_p(ck));

/*  blee  */constraint rule(T, V[122],each_week(blee,{a,p,o},{a,o},{a,p,o},{a,p,o},{a,p,o},{a,p,o},{a,p,o}));
/*  blee  */constraint rule(T, V[123],no_am_after_pm(blee));
/*  blee  */constraint rule(T, V[124],weekends_ap(blee,3,3,3,3));
/*  blee  */constraint rule(T, V[125],no_split_weekend(blee));
/*  blee  */constraint rule(T, V[126],isolate_weekend(blee));
/*  blee  */constraint rule(T, V[127],no_three_p(blee));

/*  bm  */constraint rule(T, V[128],just_single_requests(bm));

/*  km  */constraint rule(T, V[129],just_single_requests(km));

/*  ltang  */constraint rule(T, V[130],no_shifts(ltang));

/*  aw  */constraint rule(T, V[131],just_single_requests(aw));

/*  mlynch  */constraint rule(T, V[132],just_single_requests(mlynch));

/*  yp  */constraint rule(T, V[133],no_shifts(yp));

/*  lw  */constraint rule(T, V[134],just_single_requests(lw));

/* ew  */constraint rule( T, V[135], CC(ew, 0, 10 ) /\ II(ew, 0 , 10) /\ SS(ew, 0 , 10) );
/* gm  */constraint rule( T, V[136], CC(gm, 0, 10 ) /\ II(gm, 0 , 10) /\ SS(gm, 0 , 10) );
/* db  */constraint rule( T, V[137], CC(db, 0, 10 ) /\ II(db, 0 , 10) /\ SS(db, 0 , 10) );
/* mc  */constraint rule( T, V[138], CC(mc, 0, 10 ) /\ II(mc, 0 , 10) /\ SS(mc, 0 , 10) );
/* cc  */constraint rule( T, V[139], CC(cc, 0, 10 ) /\ II(cc, 0 , 10) /\ SS(cc, 0 , 10) );
/* hl  */constraint rule( T, V[140], CC(hl, 0, 10 ) /\ II(hl, 0 , 10) /\ SS(hl, 0 , 10) );
/* dl  */constraint rule( T, V[141], CC(dl, 0, 10 ) /\ II(dl, 0 , 10) /\ SS(dl, 0 , 10) );
/* rm  */constraint rule( T, V[142], CC(rm, 0, 10 ) /\ II(rm, 0 , 10) /\ SS(rm, 0 , 10) );
/* pa  */constraint rule( T, V[143], CC(pa, 0, 10 ) /\ II(pa, 0 , 10) /\ SS(pa, 0 , 10) );
/* tb  */constraint rule( T, V[144], CC(tb, 0, 10 ) /\ II(tb, 0 , 10) /\ SS(tb, 0 , 10) );
/* lb  */constraint rule( T, V[145], CC(lb, 0, 10 ) /\ II(lb, 0 , 10) /\ SS(lb, 0 , 10) );
/* lc  */constraint rule( T, V[146], CC(lc, 0, 10 ) /\ II(lc, 0 , 10) /\ SS(lc, 0 , 10) );
/* dh  */constraint rule( T, V[147], CC(dh, 0, 10 ) /\ II(dh, 0 , 10) /\ SS(dh, 0 , 10) );
/* sk  */constraint rule( T, V[148], CC(sk, 0, 10 ) /\ II(sk, 0 , 10) /\ SS(sk, 0 , 10) );
/* ml  */constraint rule( T, V[149], CC(ml, 0, 10 ) /\ II(ml, 0 , 10) /\ SS(ml, 0 , 10) );
/* jl  */constraint rule( T, V[150], CC(jl, 0, 10 ) /\ II(jl, 0 , 10) /\ SS(jl, 0 , 10) );
/* gn  */constraint rule( T, V[151], CC(gn, 0, 10 ) /\ II(gn, 0 , 10) /\ SS(gn, 0 , 10) );
/* rp  */constraint rule( T, V[152], CC(rp, 0, 10 ) /\ II(rp, 0 , 10) /\ SS(rp, 0 , 10) );
/* ar  */constraint rule( T, V[153], CC(ar, 0, 10 ) /\ II(ar, 0 , 10) /\ SS(ar, 0 , 10) );
/* ls  */constraint rule( T, V[154], CC(ls, 0, 10 ) /\ II(ls, 0 , 10) /\ SS(ls, 0 , 10) );
/* av  */constraint rule( T, V[155], CC(av, 0, 10 ) /\ II(av, 0 , 10) /\ SS(av, 0 , 10) );
/* jc  */constraint rule( T, V[156], CC(jc, 0, 10 ) /\ II(jc, 0 , 10) /\ SS(jc, 0 , 10) );
/* fh  */constraint rule( T, V[157], CC(fh, 0, 10 ) /\ II(fh, 0 , 10) /\ SS(fh, 0 , 10) );
/* xh  */constraint rule( T, V[158], CC(xh, 0, 10 ) /\ II(xh, 0 , 10) /\ SS(xh, 0 , 10) );
/* ck  */constraint rule( T, V[159], CC(ck, 0, 10 ) /\ II(ck, 0 , 10) /\ SS(ck, 0 , 10) );
/* blee  */constraint rule( T, V[160], CC(blee, 0, 10 ) /\ II(blee, 0 , 10) /\ SS(blee, 0 , 10) );
/* bm  */constraint rule( T, V[161], CC(bm, 0, 10 ) /\ II(bm, 0 , 10) /\ SS(bm, 0 , 10) );
/* km  */constraint rule( T, V[162], CC(km, 0, 10 ) /\ II(km, 0 , 10) /\ SS(km, 0 , 10) );
/* ltang  */constraint rule( T, V[163], CC(ltang, 0, 10 ) /\ II(ltang, 0 , 10) /\ SS(ltang, 0 , 10) );
/* aw  */constraint rule( T, V[164], CC(aw, 0, 10 ) /\ II(aw, 0 , 10) /\ SS(aw, 0 , 10) );
/* mlynch  */constraint rule( T, V[165], CC(mlynch, 0, 10 ) /\ II(mlynch, 0 , 10) /\ SS(mlynch, 0 , 10) );
/* yp  */constraint rule( T, V[166], CC(yp, 0, 10 ) /\ II(yp, 0 , 10) /\ SS(yp, 0 , 10) );
/* lw  */constraint rule( T, V[167], CC(lw, 0, 10 ) /\ II(lw, 0 , 10) /\ SS(lw, 0 , 10) );


% JUST CONSTRAINTS

































int: RULES = 167; 
  
  
% ============================================================
% OBJECTIVE
% ============================================================
%solve minimize sum(i in 1..RULES)(V[i]);
solve
  :: seq_search([
        int_search(
            [ roster[doc,day] | doc in docs, day in days ],
            first_fail,
            indomain_min,
            complete
        ),
        int_search(
            [ ssu[doc,day] | doc in docs, day in days ] ++
            [ incharge[doc,day] | doc in docs,day in days ] ++
            [ oncall[doc,day] | doc in docs, day in days ],
            first_fail,
            indomain_min,
            complete
        ),
        int_search(
            [ V[i] | i in 1..RULES ],
            indomain_min,
            indomain_min,
            complete
        )
    ])
  minimize sum(i in 1..RULES)(V[i]);
% 


%this might be quikcer, searchoing rules first and then searching on days then docs
%solve
%  :: seq_search([
%        int_search(
%            [ V[i] | i in 1..RULES ],
%            first_fail,
%            indomain_split,
%            complete
%        ),
%        int_search(
%            [ roster[d,day]   |  day in days, d in docs  ] ++
%            [ ssu[d,day]      |  day in days, d in docs  ] ++
%            [ incharge[d,day] |  day in days, d in docs  ] ++
%            [ oncall[d,day]   |  day in days, d in docs  ],  
%            first_fail,
%            indomain_random,
%            complete
%        )
%    ])
%  minimize sum(i in 1..RULES)(V[i]);


% REST OF VIOLATIONS -- just print out violation number....
output ["\n\nSTAFF ALLOCATION VIOLATIONS: \n\n"] ++
[
  if fix(V[i]) > 0 then " --> V[" ++ show(i) ++ "]\n" else "" endif
  | i in 1..RULES
];



