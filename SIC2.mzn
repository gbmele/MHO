%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLEAN, SOLVER‑AGNOSTIC ROLE SYSTEM
% Using binary matrices: ssu[doc,day], incharge[doc,day], oncall[doc,day]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Decision variables: 1 if doctor holds the role on that day, else 0
array[docs, days] of var 0..1: ssu;
array[docs, days] of var 0..1: incharge;
array[docs, days] of var 0..1: oncall;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXACTLY ONE SSU / INCHARGE / ONCALL PER DAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

constraint forall(d in days)(
    sum(doc in docs)(ssu[doc,d]) = 1
);

constraint forall(d in days)(
    sum(doc in docs)(incharge[doc,d]) = 1
);

constraint forall(d in days)(
    sum(doc in docs)(oncall[doc,d]) = 1);
    
    %sum(doc in docs where roster[doc,d] = p)(oncall[doc,d],1) = 1;
    %count(oncall[..,d],1,1));
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROLES MUST BE DIFFERENT FOR EACH DOCTOR ON EACH DAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

constraint forall(doc in docs, d in days)(
    %each doc can be anything and only one of ssu incharge oncall
    ssu[doc,d] + incharge[doc,d] + oncall[doc,d] <= 1
);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LINK ROLES TO ROSTER SHIFTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SSU and Incharge require shift a
constraint forall(doc in docs, d in days)(
    % can be on ssu if on am
    ssu[doc,d] = 1 -> roster[doc,d] = a
);

  
constraint forall(doc in docs, d in days)(
    %can be incharge if on am
    %% A -> B      A is true then B has to be true
    %%             A if false then doesnt matter what B is... 
    incharge[doc,d] = 1 -> roster[doc,d] = a
);

% Oncall requires shift p
constraint forall(doc in docs, d in days)(
   oncall[doc,d] = 1 -> roster[doc,d] = p
);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PER‑DOCTOR TOTAL LIMITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

constraint forall(doc in docs)(
    sum(d in days)(ssu[doc,d]) <= 20
);

constraint forall(doc in docs)(
    sum(d in days)(incharge[doc,d]) <= 20
);

constraint forall(doc in docs)(
    sum(d in days)(oncall[doc,d]) <= 10
);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PER‑FORTNIGHT LIMITS (EXAMPLE)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%no consec ssu
constraint forall(doc in docs, d in 1..DAYS-1)
      (ssu[doc,d]+ssu[doc,d+1] <= 1);

constraint forall(doc in docs)(
    %%fortnight limit 3
    sum(d in 1..14)(ssu[doc,d])  <= 3 /\
    sum(d in 15..28)(ssu[doc,d]) <= 3 /\
    sum(d in 29..42)(ssu[doc,d]) <= 3 /\
    sum(d in 43..56)(ssu[doc,d]) <= 3 /\
    sum(d in 57..70)(ssu[doc,d]) <= 3
);

constraint forall(doc in docs, d in 1..DAYS-1)
      %%no consec incharge
      (incharge[doc,d]+incharge[doc,d+1] <= 1);

constraint forall(doc in docs)(
    %%fortnight limit 3

    sum(d in 1..14)(incharge[doc,d])  <= 3 /\
    sum(d in 15..28)(incharge[doc,d]) <= 3 /\
    sum(d in 29..42)(incharge[doc,d]) <= 3 /\
    sum(d in 43..56)(incharge[doc,d]) <= 3 /\
    sum(d in 57..70)(incharge[doc,d]) <= 3
);

constraint forall(doc in docs, d in 1..DAYS-6)
      %no consec oncall  and at least 6 days apart
      (oncall[doc,d]+oncall[doc,d+1] +oncall[doc,d+2] +oncall[doc,d+3] + oncall[doc,d+5] + oncall[doc,d+6]   <= 1);

constraint forall(doc in docs)(
    %%fortnight limit 3
    sum(d in 1..14)(oncall[doc,d])  <= 1 /\
    sum(d in 15..28)(oncall[doc,d]) <= 1 /\
    sum(d in 29..42)(oncall[doc,d]) <= 1 /\
    sum(d in 43..56)(oncall[doc,d]) <= 1 /\
    sum(d in 57..70)(oncall[doc,d]) <= 1
);

%constraint forall(doc in docs, d in 1..DAYS-7)(
%    oncall[doc,d] = 1 ->
%        sum(k in d+1..d+7)(oncall[doc,k]) = 0
%);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIC PREDICATE (EACH DOCTOR Sssu I incharge C oncall Low-limit Upper-Limit)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

predicate SIC(docs: doc, int: S, int: S2, int: I, int: I2, int: C, int: C2) =
    %% SIC(gm,0,2,1,2,2,3); gm ssu min 0 max 2, Incharge min 1 to  max 2, oncall min 2 max 3
    sum(d in days)(ssu[doc,d]) in S..S2 /\
    sum(d in days)(incharge[doc,d]) in I..I2 /\
    sum(d in days)(oncall[doc,d]) in C..C2;

predicate SS(docs:doc,int:S1,int:S2) =
   sum(d in days)(ssu[doc,d]) in S1..S2;
    
predicate II(docs:doc,int:I1,int:I2) =
   sum(d in days)(incharge[doc,d]) in I1..I2;

predicate CC(docs:doc,int:C1,int:C2) =
   sum(d in days)(oncall[doc,d]) in C1..C2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT: PER‑DOCTOR SUMMARY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
output [
  show(doc) ++
  " ssu=" ++ show(sum(d in days)(ssu[doc,d])) ++
  " inc=" ++ show(sum(d in days)(incharge[doc,d])) ++
  " onc=" ++ show(sum(d in days)(oncall[doc,d])) ++
  "\n"
  | doc in docs
];
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPTIONAL: PER‑DAY ROLE OWNERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
output [
  "Day " ++ show(d) ++
  " SSU=" ++ show([doc | doc in docs where ssu[doc,d] = 1]) ++
  " INC=" ++ show([doc | doc in docs where incharge[doc,d] = 1]) ++
  " ONC=" ++ show([doc | doc in docs where oncall[doc,d] = 1]) ++
  "\n"
  | d in days
];
*/