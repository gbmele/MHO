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

enum docs = {gm, db, mc, cc, sd, hl, dl, rm, pa, tb, lb, lc, dh, sk, ml, jl, gn, rp, ar, ls, av, fh, xh, ck, blee, bm, sr, ltang, aw, mlynch};
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
% gm 
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
, % END gm

% db 
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
, % END db

% mc 
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
, % END mc

% cc 
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
, % END cc

% sd 
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
, % END sd

% hl 
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
, % END hl

% dl 
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
, % END dl

% rm 
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
, % END rm

% pa 
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
, % END pa

% tb 
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
, % END tb

% lb 
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
, % END lb

% lc 
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
, % END lc

% dh 
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
, % END dh

% sk 
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
, % END sk

% ml 
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
, % END ml

% jl 
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
, % END jl

% gn 
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
, % END gn

% rp 
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
, % END rp

% ar 
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
, % END ar

% ls 
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
, % END ls

% av 
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
, % END av

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
, % END xh

% ck 
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
, % END ck

% blee 
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
, % END blee

% bm 
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
, % END bm

% sr 
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
, % END sr

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
{a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, {a, p, o, c}, 
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
 % END mlynch

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
 constraint rule(T, V[1],(forall(d in mondays)   (count([roster[doc,d]|doc in docs],a) in 2..6)));
 constraint rule(T, V[2],(forall(d in mondays)   (count([roster[doc,d]|doc in docs],p) in 2..6)));
 constraint rule(T, V[3],(forall(d in tuesdays)  (count([roster[doc,d]|doc in docs],a) in 2..6)));
 constraint rule(T, V[4],(forall(d in tuesdays)  (count([roster[doc,d]|doc in docs],p) in 2..6)));
 constraint rule(T, V[5],(forall(d in wednesdays)(count([roster[doc,d]|doc in docs],a) in 2..6)));
 constraint rule(T, V[6],(forall(d in wednesdays)(count([roster[doc,d]|doc in docs],p) in 2..6)));
 constraint rule(T, V[7],(forall(d in thursdays) (count([roster[doc,d]|doc in docs],a) in 2..6)));
 constraint rule(T, V[8],(forall(d in thursdays) (count([roster[doc,d]|doc in docs],p) in 2..6)));
 constraint rule(T, V[9],(forall(d in fridays)   (count([roster[doc,d]|doc in docs],a) in 2..6)));
 constraint rule(T, V[10],(forall(d in fridays)   (count([roster[doc,d]|doc in docs],p) in 2..6)));
 constraint rule(T, V[11],(forall(d in saturdays) (count([roster[doc,d]|doc in docs],a) in 2..6)));
 constraint rule(T, V[12],(forall(d in saturdays) (count([roster[doc,d]|doc in docs],p) in 2..6)));
 constraint rule(T, V[13],(forall(d in sundays)   (count([roster[doc,d]|doc in docs],a) in 2..6)));
 constraint rule(T, V[14],(forall(d in sundays)   (count([roster[doc,d]|doc in docs],p) in 2..6)));

/*  gm  */constraint rule(T, V[15],assign_shifts(gm,saturday,a,0) /* does the comment thing work */);
/*  gm  */constraint rule(T, V[16],assign_shifts(gm,saturday,p,0));
/*  gm  */constraint rule(T, V[17],assign_shifts(gm,sunday,a,2,4));
/*  gm  */constraint rule(T, V[18],assign_shifts(gm,sunday,p,0));
/*  gm  */constraint rule(T, V[19],each_week(gm,{c,o},{p,o},{o},{c,o},{a,o},{o},{a,o}));
/*  gm  */constraint rule(T, V[20],sh_per_fn(gm,4));
/*  gm  */constraint rule(T, V[21],shifts_apc(gm,[0,1,2],[1,1,2],[1,0,0],4));

/*  db  */constraint rule(T, V[22],shifts_apc(db,[1,1,0],[3,1,0],[2,2,0],4) /\ sh_per_fn(db,4));
/*  db  */constraint rule(T, V[23],each_week(db,{o,a},{o,a,p},{o},{a,o},{a,o,p},{a,o,p},{a,o,p}));
/*  db  */constraint rule(T, V[24],weekends_ap(db,2,0,2,0));
/*  db  */constraint rule(T, V[25],FRI_P(db,2,2));
/*  db  */constraint rule(T, V[26],no_split_weekend(db));
/*  db  */constraint rule(T, V[27],isolate_weekend(db));
/*  db  */constraint rule(T, V[28],forall(fn in fortnights)(count(roster[db,fn],o,6)));

/*  mc  */constraint rule(T, V[29],shifts_2a1p1c(mc,4));
/*  mc  */constraint rule(T, V[30],sh_per_fn(mc,4));
/*  mc  */constraint rule(T, V[31],each_week(mc,{a,o},{a,o},{a,o,p},{c,o},{a,o,p},{a,o,p},{a,o,p}));
/*  mc  */constraint rule(T, V[32],FRI_P(mc,2,2));
/*  mc  */constraint rule(T, V[33],weekends_ap(mc,1,1,1,1));
/*  mc  */constraint rule(T, V[34],split_weekends(mc));
/*  mc  */constraint rule(T, V[35],no_am_after_pm(mc));

/*  cc  */constraint rule(T, V[36],shifts_apc(cc,[1,1,0],[3,1,0],[2,2,0],4));
/*  cc  */constraint rule(T, V[37],sh_per_fn(cc,4));
/*  cc  */constraint rule(T, V[38],each_week(cc,{o,p,a},{o,a},{a,o},{a,o},{a,o,p},{a,o,p},{a,o,p}));
/*  cc  */constraint rule(T, V[39],weekends_ap(cc,1,1,1,1));
/*  cc  */constraint rule(T, V[40],FRI_P(cc,2,2));
/*  cc  */constraint rule(T, V[41],no_split_weekend(cc));
/*  cc  */constraint rule(T, V[42],isolate_weekend(cc));
/*  cc  */constraint rule(T, V[43],no_am_after_pm(cc));

/*  sd  */constraint rule(T, V[44],shifts_2a1p1c(sd,4));
/*  sd  */constraint rule(T, V[45],sh_per_fn(sd,4));
/*  sd  */constraint rule(T, V[46],weekends_ap(sd,1,1,1,1));
/*  sd  */constraint rule(T, V[47],each_week(sd,{a,c,o},{a,c,o},{a,o},{p,o},{a,o,p},{a,o,p},{a,o,p}));
/*  sd  */constraint rule(T, V[48],no_am_after_pm(sd));
/*  sd  */constraint rule(T, V[49],no_mon_after_sun(sd));
/*  sd  */constraint rule(T, V[50],FRI_P(sd,2,2));
/*  sd  */constraint rule(T, V[51],split_weekend(sd));

/*  hl  */constraint rule(T, V[52],just_single_requests(hl));

/*  dl  */constraint rule(T, V[53],shifts_2a1p1c(dl,4));
/*  dl  */constraint rule(T, V[54],sh_per_fn(dl,4));
/*  dl  */constraint rule(T, V[55],each_week(dl,{a,o},{a,p,o},{c,o},{o},{a,p,o},{a,p,o},{a,p,o}));
/*  dl  */constraint rule(T, V[56],weekends_ap(dl,1,1,1,1) /*1 sat am 1 sat p 1 sun am 1 sun pm*/);
/*  dl  */constraint rule(T, V[57],no_split_weekend(dl));
/*  dl  */constraint rule(T, V[58],no_consec_weekends(dl));
/*  dl  */constraint rule(T, V[59],FRI_P(dl,2,2));
/*  dl  */constraint rule(T, V[60],no_am_after_pm(dl));
/*  dl  */constraint rule(T, V[61],isolate_weekend(dl));

/*  rm  */constraint rule(T, V[62],shifts_2a1p1c(rm,4));
/*  rm  */constraint rule(T, V[63],sh_per_fn(rm,4));
/*  rm  */constraint rule(T, V[64],each_week(rm,{a,o},{a,p,o},{c},{a,o},{a,p,o},{a,p,o},{a,p,o}));
/*  rm  */constraint rule(T, V[65],weekends_ap(rm,2,0,2,0) /*two sat am two sun am*/);
/*  rm  */constraint rule(T, V[66],no_split_weekend(rm));
/*  rm  */constraint rule(T, V[67],no_consec_weekends(rm));
/*  rm  */constraint rule(T, V[68],FRI_P(rm,2,2));
/*  rm  */constraint rule(T, V[69],no_am_after_pm(rm));

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

/*  lb  */constraint rule(T, V[81],each_week(lb,{a,o},{a,o},{a,o},{o},{o},{a,o},{a,o}));
/*  lb  */constraint rule(T, V[82],weekends_ap(lb,3,0));

/*  lc  */constraint rule(T, V[83],each_week(lc,{o},{a,o,p},{o},{a,p,o},{o},{a,p,o},{a,p,o}));
/*  lc  */constraint rule(T, V[84],weekends_ap(lc,2,2));

/*  dh  */constraint rule(T, V[85],shifts_apc(dh,[1,1,0],[1,1,0],[0,3,0],2));
/*  dh  */constraint rule(T, V[86],each_week(dh,{o},{o},{a,o},{o},{o,p},{p,o},{o}));
/*  dh  */constraint rule(T, V[87],weekends_ap(dh,0,3,0,0));

/*  sk  */constraint rule(T, V[88],shifts_apc(sk,[0,1,1],[1,1,1],[2,2,0],3));
/*  sk  */constraint rule(T, V[89],each_week(sk,{a,o},{c,o},{a,o,p},{o},{o},{a,p,o},{a,p,o}));
/*  sk  */constraint rule(T, V[90],weekends_ap(sk,1,1,1,1));
/*  sk  */constraint rule(T, V[91],no_mon_after_sun(sk));
/*  sk  */constraint rule(T, V[92],no_split_weekend(sk));
/*  sk  */constraint rule(T, V[93],forall (day in 8..DAYS where day mod 7 = monday) (if roster[sk,day-1]=o then roster[sk,day]=a endif));

/*  ml  */constraint rule(T, V[94],each_week(ml,{o},{o},{a},{c,a,o},{o},{o},{a,p,o}));
/*  ml  */constraint rule(T, V[95],THU_C(ml,2,2));
/*  ml  */constraint rule(T, V[96],just_sh_per_fn(ml,3));
/*  ml  */constraint rule(T, V[97],assign_shifts(ml,sunday,a,0,6));
/*  ml  */constraint rule(T, V[98],assign_shifts(ml,sunday,p,0,6));

/*  jl  */constraint rule(T, V[99],week_one(jl,{o},{a,o},{c},{a,o},{o},{a,p,o},{a,p,o}));
/*  jl  */constraint rule(T, V[100],week_two(jl,{o},{p,o},{c},{p,o},{o},{a,p,o},{a,p,o}));
/*  jl  */constraint rule(T, V[101],weekends_ap(jl,1,1,1,1));
/*  jl  */constraint rule(T, V[102],no_split_weekend(jl));
/*  jl  */constraint rule(T, V[103],just_sh_per_fn(jl,3));

/*  gn  */constraint rule(T, V[104],each_week(gn,{p},{o},{p},{c},{o},{p},{o}));
/*  gn  */constraint rule(T, V[105],sh_per_fn(gn,4));

/*  rp  */constraint rule(T, V[106],week_one(rp,{o},{a},{a},{c},{o},{o},{p}));
/*  rp  */constraint rule(T, V[107],week_two(rp,{o},{a},{a},{c},{o},{o},{p}));

/*  ar  */constraint rule(T, V[108],just_single_requests(ar));

/*  ls  */constraint rule(T, V[109],just_single_requests(ls));

/*  av  */constraint rule(T, V[110],shifts_apc(av,[0,0,1],[1,1,1],[2,2,0],3));
/*  av  */constraint rule(T, V[111],sh_per_fn(av,3));
/*  av  */constraint rule(T, V[112],weekends_ap(av,1,1,1,1));
/*  av  */constraint rule(T, V[113],FRI_P(av,2,2));
/*  av  */constraint rule(T, V[114],no_split_weekend(av));
/*  av  */constraint rule(T, V[115],isolate_weekend(av));
/*  av  */constraint rule(T, V[116],each_week(av,{a,p,o,c},{a,o,c},{a,p,o,c},{a,p,o,c},{a,p,o,c},{a,p,o},{a,p,o}));


/*  xh  */constraint rule(T, V[117],just_single_requests(xh));

/*  ck  */constraint rule(T, V[118],each_week(ck,{a,p,o},{a,p,o},{a,p,o},{o},{o},{a,p,o},{a,p,o}));
/*  ck  */constraint rule(T, V[119],no_am_after_pm(ck));
/*  ck  */constraint rule(T, V[120],weekends_ap(ck,4,4));
/*  ck  */constraint rule(T, V[121],no_split_weekend(ck));
/*  ck  */constraint rule(T, V[122],just_sh_per_fn(ck,3));

/*  blee  */constraint rule(T, V[123],each_week(blee,{a,p,o},{a,o},{a,p,o},{a,p,o},{a,p,o},{a,p,o},{a,p,o}));
/*  blee  */constraint rule(T, V[124],no_am_after_pm(blee));
/*  blee  */constraint rule(T, V[125],just_sh_per_fn(blee,4));
/*  blee  */constraint rule(T, V[126],weekends_ap(blee,2,2,2,2));
/*  blee  */constraint rule(T, V[127],no_split_weekend(blee));
/*  blee  */constraint rule(T, V[128],isolate_weekend(blee));
/*  blee  */constraint rule(T, V[129],no_three_p(blee));

/*  bm  */constraint rule(T, V[130],each_week(bm,{o},{o},{o},{o,p},{o},{o,p},{o}));
/*  bm  */constraint rule(T, V[131],sh_per_fn(bm,1));
/*  bm  */constraint rule(T, V[132],assign_shifts(bm,saturday,p,2,4));
/*  bm  */constraint rule(T, V[133],THU_P(bm,2,10));
/*  bm  */constraint rule(T, V[134],shifts_apc(bm,[0,0,0],[0,1,0],[0,1,0],1));





/* gm  */constraint rule( T, V[135], CC(gm, 0, 6 ) /\ II(gm, 0 , 6) /\ SS(gm, 0 , 6) );
/* db  */constraint rule( T, V[136], CC(db, 0, 6 ) /\ II(db, 0 , 6) /\ SS(db, 0 , 6) );
/* mc  */constraint rule( T, V[137], CC(mc, 0, 6 ) /\ II(mc, 0 , 6) /\ SS(mc, 0 , 6) );
/* cc  */constraint rule( T, V[138], CC(cc, 0, 6 ) /\ II(cc, 0 , 6) /\ SS(cc, 0 , 6) );
/* sd  */constraint rule( T, V[139], CC(sd, 0, 6 ) /\ II(sd, 0 , 6) /\ SS(sd, 0 , 6) );
/* hl  */constraint rule( T, V[140], CC(hl, 0, 6 ) /\ II(hl, 0 , 6) /\ SS(hl, 0 , 6) );
/* dl  */constraint rule( T, V[141], CC(dl, 0, 6 ) /\ II(dl, 0 , 6) /\ SS(dl, 0 , 6) );
/* rm  */constraint rule( T, V[142], CC(rm, 0, 6 ) /\ II(rm, 0 , 6) /\ SS(rm, 0 , 6) );
/* pa  */constraint rule( T, V[143], CC(pa, 0, 6 ) /\ II(pa, 0 , 6) /\ SS(pa, 0 , 6) );
/* tb  */constraint rule( T, V[144], CC(tb, 0, 6 ) /\ II(tb, 0 , 6) /\ SS(tb, 0 , 6) );
/* lb  */constraint rule( T, V[145], CC(lb, 0, 6 ) /\ II(lb, 0 , 6) /\ SS(lb, 0 , 6) );
/* lc  */constraint rule( T, V[146], CC(lc, 0, 6 ) /\ II(lc, 0 , 6) /\ SS(lc, 0 , 6) );
/* dh  */constraint rule( T, V[147], CC(dh, 0, 6 ) /\ II(dh, 0 , 6) /\ SS(dh, 0 , 6) );
/* sk  */constraint rule( T, V[148], CC(sk, 0, 6 ) /\ II(sk, 0 , 6) /\ SS(sk, 0 , 6) );
/* ml  */constraint rule( T, V[149], CC(ml, 0, 6 ) /\ II(ml, 0 , 6) /\ SS(ml, 0 , 6) );
/* jl  */constraint rule( T, V[150], CC(jl, 0, 6 ) /\ II(jl, 0 , 6) /\ SS(jl, 0 , 6) );
/* gn  */constraint rule( T, V[151], CC(gn, 0, 6 ) /\ II(gn, 0 , 6) /\ SS(gn, 0 , 6) );
/* rp  */constraint rule( T, V[152], CC(rp, 0, 6 ) /\ II(rp, 0 , 6) /\ SS(rp, 0 , 6) );
/* ar  */constraint rule( T, V[153], CC(ar, 0, 6 ) /\ II(ar, 0 , 6) /\ SS(ar, 0 , 6) );
/* ls  */constraint rule( T, V[154], CC(ls, 0, 6 ) /\ II(ls, 0 , 6) /\ SS(ls, 0 , 6) );
/* av  */constraint rule( T, V[155], CC(av, 0, 6 ) /\ II(av, 0 , 6) /\ SS(av, 0 , 6) );
/* fh  */constraint rule( T, V[156], CC(fh, 0, 6 ) /\ II(fh, 0 , 6) /\ SS(fh, 0 , 6) );
/* xh  */constraint rule( T, V[157], CC(xh, 0, 6 ) /\ II(xh, 0 , 6) /\ SS(xh, 0 , 6) );
/* ck  */constraint rule( T, V[158], CC(ck, 0, 6 ) /\ II(ck, 0 , 6) /\ SS(ck, 0 , 6) );
/* blee  */constraint rule( T, V[159], CC(blee, 0, 6 ) /\ II(blee, 0 , 6) /\ SS(blee, 0 , 6) );
/* bm  */constraint rule( T, V[160], CC(bm, 0, 6 ) /\ II(bm, 0 , 6) /\ SS(bm, 0 , 6) );
/* sr  */constraint rule( T, V[161], CC(sr, 0, 6 ) /\ II(sr, 0 , 6) /\ SS(sr, 0 , 6) );
/* ltang  */constraint rule( T, V[162], CC(ltang, 0, 6 ) /\ II(ltang, 0 , 6) /\ SS(ltang, 0 , 6) );
/* aw  */constraint rule( T, V[163], CC(aw, 0, 6 ) /\ II(aw, 0 , 6) /\ SS(aw, 0 , 6) );
/* mlynch  */constraint rule( T, V[164], CC(mlynch, 0, 6 ) /\ II(mlynch, 0 , 6) /\ SS(mlynch, 0 , 6) );
int: RULES = 164; 
  
  
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



