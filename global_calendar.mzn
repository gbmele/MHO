%predicate DOC_TABLE(docs:doc,array[int,int]of shifts:doctable) =
%          forall (w in weeks)(table([roster[doc,day] | day in w],doctable));

%for divmod
int: monday     = 1;    
int: tuesday    = 2;
int: wednesday  = 3;
int: thursday   = 4;
int: friday     = 5; 
int: saturday   = 6;  
int: sunday     = 0;  

set of int: mondays    = {d | d in days where d mod 7 = monday};
set of int: tuesdays   = {d | d in days where d mod 7 = tuesday};
set of int: wednesdays = {d | d in days where d mod 7 = wednesday};
set of int: thursdays  = {d | d in days where d mod 7 = thursday};
set of int: fridays    = {d | d in days where d mod 7 = friday};
set of int: saturdays  = {d | d in days where d mod 7 = saturday};
set of int: sundays    = {d | d in days where d mod 7 = sunday};



int: w1  = 1;
int: w2  = 2;
int: w3  = 3;
int: w4  = 4;
int: w5  = 5;
int: w6  = 6;
int: w7  = 7;
int: w8  = 8;
int: w9  = 9;
int: w10 = 10;

%% so mondays[w2]  is the monday of week2 and thursdays[w9] is the thursday of week9....
array[int] of set of int: weeks;

set of int: week1 = weeks[1];
set of int: week2 = weeks[2];
set of int: week3 = weeks[3];
set of int: week4 = weeks[4];
set of int: week5 = weeks[5];
set of int: week6 = weeks[6];
set of int: week7 = weeks[7];
set of int: week8 = weeks[8];
set of int: week9 = weeks[9];
set of int: week10= weeks[10];

array[int] of set of int: fortnights;

fortnights = [fn1,fn2,fn3,fn4,fn5];



int: week2_prior  = 1;
int: week3_prior  = 2;
int: week4_prior  = 3;
int: week5_prior  = 4;
int: week6_prior  = 5;
int: week7_prior  = 6;
int: week8_prior  = 7;
int: week9_prior  = 8;
int: week10_prior = 9;

weeks= [wk1,wk2,wk3,wk4,wk5,wk6,wk7,wk8,wk9,wk10];

int: wk1_mon  =  1;   int: wk1_tue  =  2;    set of int: wk1  =  1..7;   set of int: wd1  = 1..5;      set of int: fn1 = 1..14;   %middle we 6,7
int: wk2_mon  =  8;   int: wk2_tue  =  9;    set of int: wk2  =  8..14;  set of int: wd2  = 8..12;  
int: wk3_mon  = 15;   int: wk3_tue  =  16;   set of int: wk3  = 15..21;  set of int: wd3  = 15..19;    set of int: fn2 = 15..28;  %middle 20,21
int: wk4_mon  = 22;   int: wk4_tue  =  23;   set of int: wk4  = 22..28;  set of int: wd4  = 22..26;  
int: wk5_mon  = 29;   int: wk5_tue  =  30;   set of int: wk5  = 29..35;  set of int: wd5  = 29..33;    set of int: fn3 = 29..42;  %middle 34,35
int: wk6_mon  = 36;   int: wk6_tue  =  37;   set of int: wk6  = 36..42;  set of int: wd6  = 36..40;  
int: wk7_mon  = 43;   int: wk7_tue  =  44;   set of int: wk7  = 43..49;  set of int: wd7  = 43..47;    set of int: fn4 = 43..56;  %middle 48,49
int: wk8_mon  = 50;   int: wk8_tue  =  51;   set of int: wk8  = 50..56;  set of int: wd8  = 50..54;  
int: wk9_mon  = 57;   int: wk9_tue  =  58;   set of int: wk9  = 57..63;  set of int: wd9  = 57..61;    set of int: fn5 = 57..70;  %middle 62,63
int: wk10_mon = 64;   int: wk10_tue  = 65;   set of int: wk10 = 64..70;  set of int: wd10 = 64..68;  

array[int] of set of int: weekday_weeks;

weekday_weeks=[wd1,wd2,wd3,wd4,wd5,wd6,wd7,wd8,wd9,wd10];


%predicate force_mon(docs:doc, shifts:shift) =
%            forall (day in 8..DAYS where day mod 7 = monday) (if roster[doc,day] != l /\ off_shift(doc,day-1) then roster[doc,day]=shift else true endif);



predicate assign_shifts(docs: doc, int: dayname, shifts: shift, int: num) =
                          count([roster[doc,d] | d in days where d mod 7 = dayname] ,shift,num);     

predicate assign_shifts(docs: doc, int: dayname, shifts: shift, int: low, int: up) =
                          global_cardinality_low_up([roster[doc,d] | d in days where d mod 7 = dayname],[shift],[low],[up]) :: "AS \(doc) \(shift)  ";

predicate on_shift  (docs: doc, int:day)=
          
                    (roster[doc,day] = a \/ roster[doc,day] = p \/ roster[doc,day]=c);        

predicate off_shift  (docs: doc, int:day)=
              
                    (roster[doc,day] = o);        

predicate request_off  (docs: doc, int: day) =
          
                      (roster[doc,day]=o);

predicate not_avail (docs: doc, int: day, shifts: shift) =  %%%this is FUNCTION OVERLOADING
          
                    roster[doc,day] != shift;        

predicate not_avail(docs: doc, int:day) =

                    roster[doc,day]=o;             

predicate request_cs(docs: doc, int: day) =-
          
                     roster[doc,day] = c;

predicate no_consec_friday_pms(docs: doc) = 
          forall(d in 1..DAYS-7   where d in fridays) 
             (roster[doc,d] = p -> roster[doc,d+7] !=p) ;

predicate no_consec_saturdays(docs: doc) =
  forall(d in 1..DAYS-7 where d mod 7 = saturday) 
      (on_shift(doc,d) -> off_shift(doc,d+7));

predicate no_consec_sundays(docs: doc) =
  forall(d in 1..DAYS-7 where d mod 7 = sunday)  
      (on_shift(doc,d) -> off_shift(doc,d+7));
                                     
predicate no_consec_sat_and_or_sun(docs: doc) =
  
     forall(d in 1..DAYS-8 where d mod 7 = saturday)  
        ( (on_shift(doc,d) -> off_shift(doc,d+8)) /\  % no next sunday   after this saturday 
          on_shift(doc,d+1)-> off_shift(doc,d+7));     % no next saturday after this sunday

predicate no_consec_weekends(docs: doc) =
             no_consec_saturdays(doc) /\ no_consec_sundays(doc) /\ no_consec_sat_and_or_sun(doc);

predicate no_third_sunday(docs: doc) = 
      forall(d in 1..DAYS-14 where d mod 7 = sunday)  
        (on_shift(doc,d) -> off_shift(doc,d+14));


predicate no_three_p(docs: doc) =
    forall(d in 1..DAYS-2)(
        if roster[doc,d] = p /\ roster[doc,d+1] = p then
            roster[doc,d+2] != p
        else
            true
        endif
    );



predicate no_third_saturday(docs: doc) = 
  forall(d in 1..DAYS-14 where d mod 7 = saturday) 
      (on_shift(doc,d) -> off_shift(doc,d+14));

predicate no_third_weekend(docs: doc) =
          no_third_saturday(doc) /\ no_third_sunday(doc);             
                       
predicate no_mon_after_sun (docs: doc) =
  forall(d in 1..DAYS-1 where d mod 7 = sunday) 
         (if on_shift(doc,d) then off_shift(doc,d+1) else true endif); 

predicate no_mon_and_no_tue_after_sun (docs: doc) =
  forall(d in 1..DAYS-7 where d mod 7 = sunday) 
         (if on_shift(doc,d) then (off_shift(doc,d+1) /\ off_shift(doc,d+2)) else true endif); 
         
                           
%        (on_shift(doc,d) -> off_shift(doc,d+1));

predicate no_fri_before_sat(docs: doc) =
   forall(d in 1..DAYS where d mod 7 = saturday)
         (if on_shift(doc,d) then off_shift(doc,d-1) else true endif);
predicate no_fri_before_weekend(docs: doc) =
   forall(d in 1..DAYS where d mod 7 = saturday)
         (if on_shift(doc,d) then off_shift(doc,d-1) else true endif);
   

predicate isolate_weekend(docs:doc) = 
      no_mon_after_sun(doc) /\ no_fri_before_sat(doc);

      
predicate no_am_after_pm(docs:doc) =
   forall(day in 1..DAYS-1) (if roster[doc,day]=p then roster[doc,day+1] != a else true endif);


predicate no_fri_pm_before_weekend(docs:doc) = 
   forall (day in fridays) (if roster[doc,day+1]= p then roster[doc,day] != p else true endif);


predicate no_split_weekend  (docs:doc) = 
                             forall (day in saturdays) (roster[doc,day]=roster[doc,day+1]); %% so weekends are o o \/ a a \/ p p

predicate split_weekend(docs:doc) =
          not no_split_weekend(doc);


predicate split_weekends(docs:doc) =
          forall(day in saturdays)
              ( if roster[doc,day]=a then roster[doc,day+1]=o
                elseif roster[doc,day]=p then roster[doc,day+1]=o
                elseif roster[doc,day+1]=a then roster[doc,day]=o
                elseif roster[doc,day+1]=p then roster[doc,day]=o
                else true
                endif);
                
                
predicate weekends2a2p(docs:doc) =
            assign_shifts(doc,saturday,a,1) /\
            assign_shifts(doc,sunday,a,1) /\
            assign_shifts(doc,saturday,p,1) /\
            assign_shifts(doc,sunday,p,1);

predicate weekends3a1p(docs:doc)=
           sum(d in saturdays union sundays)(roster[doc,d]=a)= 3 /\
           sum(d in saturdays union sundays)(roster[doc,d]=p)= 1;

predicate weekends_ap(docs:doc,int:A,int:P)=
           sum(d in saturdays union sundays)(roster[doc,d]=a)= A /\
           sum(d in saturdays union sundays)(roster[doc,d]=p)= P;

predicate weekends_ap(docs:doc,int:satA,int:satP,int:sunA,int:sunP)=
           sum(d in saturdays)(roster[doc,d]=a)= satA /\
           sum(d in saturdays)(roster[doc,d]=p)= satP /\
           sum(d in sundays)  (roster[doc,d]=a)= sunA /\
           sum(d in sundays)  (roster[doc,d]=p)= sunP ;


%%%APC
predicate shifts_apc(docs: doc,array[int]of int: APClo, array[int] of int:APChi,array[int]of int: WENDhi,int:leave_count)=
      forall(wk in weeks)
        (count(day in wk)(roster[doc,day] in leave_shifts) >=leave_count   \/
     
        (global_cardinality_low_up([roster[doc,d] | d in wk where d mod 7 in {1,2,3,4,5}],[a,p,c],APClo,APChi) /\
        global_cardinality_low_up([roster[doc,d] | d in  wk  where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],WENDhi))); %  /\
        %count(day in wk)(roster[doc,day] in {a,p,c}) in {leave_count-1,leave_count,leave_count+1}));



predicate shifts_2a1p1c(docs: doc,int:leave_count)=
      forall(wk in weeks)
        (count(day in wk)(roster[doc,day] in leave_shifts) >=leave_count   \/
     
        (global_cardinality_low_up([roster[doc,d] | d in wk where d mod 7 in {1,2,3,4,5}],[a,p,c],[0,1,1],[2,1,1]) /\
        global_cardinality_low_up([roster[doc,d] | d in  wk  where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0]) /\
        count(day in wk)(roster[doc,day] in {a,p,c}) in {leave_count-1,leave_count,leave_count+1}));


predicate shifts_3a1p(docs: doc,int:leave_count)=
      forall(wk in weeks)
        (count(day in wk)(roster[doc,day] in leave_shifts) >=leave_count   \/
     
        (global_cardinality_low_up([roster[doc,d] | d in wk where d mod 7 in {1,2,3,4,5}],[a,p,c],[1,1,0],[3,1,0]) /\
        global_cardinality_low_up([roster[doc,d] | d in  wk  where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0]) /\
        count(day in wk)(roster[doc,day] in {a,p,c}) in {leave_count-1,leave_count,leave_count+1}));


predicate shifts_1a1p1c(docs: doc,int:leave_count)=
      forall(wk in weeks)
        (count(day in wk)(roster[doc,day] in leave_shifts) >=leave_count   \/
     
        (global_cardinality_low_up([roster[doc,d] | d in wk where d mod 7 in {1,2,3,4,5}],[a,p,c],[1,1,1],[1,1,1]) /\
        global_cardinality_low_up([roster[doc,d] | d in  wk  where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0])));

predicate shifts_2a2p2c(docs: doc,int:leave_count)=
      forall(wk in weeks)
        (count(day in wk)(roster[doc,day] in leave_shifts) >=leave_count   \/
     
        (global_cardinality_low_up([roster[doc,d] | d in wk where d mod 7 in {1,2,3,4,5}],[a,p,c],[0,0,1],[2,2,1]) /\
        global_cardinality_low_up([roster[doc,d] | d in  wk  where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0])));



predicate shifts_1a1p(docs: doc,int:leave_count)=
      forall(wk in weeks)
        (count(day in wk)(roster[doc,day] in leave_shifts) >=leave_count   \/
     
        (global_cardinality_low_up([roster[doc,d] | d in wk where d mod 7 in {1,2,3,4,5}],[a,p,c],[1,1,0],[1,1,0]) /\
        global_cardinality_low_up([roster[doc,d] | d in  wk  where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0])));

predicate shifts_1a1p(docs: doc,array[int] of int: SH,int:leave_count)=
      forall(wk in weeks)
        (count(day in wk)(roster[doc,day] in leave_shifts) >=leave_count   \/
     
        (global_cardinality_low_up([roster[doc,d] | d in wk where d mod 7 in {1,2,3,4,5}],[a,p,c],[1,1,0],[1,1,0]) /\
        global_cardinality_low_up([roster[doc,d] | d in  wk  where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],SH)));



predicate just_single_requests(docs:doc) =
    %% if requesf for a doc on a day is just one shfit, then roster the doc on the dayt with that shift
    %% and the rest of the shifts will be extracted as a,p,o,c but not needed so it will be a day off  ie JUST_REQUESTS_GIVEN
    
    %% in 1..2 measn if card(requests[doc,day]) = 1 or 2 then the roster[doc,day] is in requests[oc,day] or off...    
    forall(day in days)(if card(requests[doc,day]) in 1..2 then roster[doc,day] in requests[doc,day]
                        else roster[doc,day] =o
                        endif);

predicate as_requested(docs:doc) =
    %% if requesf for a doc on a day is just one shfit, then roster the doc on the dayt with that shift
    %% and the rest of the shifts will be extracted as a,p,o,c but not needed so it will be a day off  ie JUST_REQUESTS_GIVEN
    
    %% in 1..2 measn if card(requests[doc,day]) = 1 or 2 then the roster[doc,day] is in requests[oc,day] or off...    
    forall(day in days)(if card(requests[doc,day]) in 1..2 then roster[doc,day] in requests[doc,day]
                        else roster[doc,day] =o
                        endif);



predicate no_shifts(docs:doc)=
    forall(day in days)(roster[doc,day]=o);



predicate sh_per_fn(docs: doc, int: sh_per_week) =
  forall(fn in fortnights) (
    let {
      % Split the fortnight into two weeks (7 days each)
      set of int: wk1 = {d | d in fn where (d - min(fn) + 1) <= 7};
      set of int: wk2 = {d | d in fn where (d - min(fn) + 1) > 7};

      % Count leave per week
      var int: leave_wk1 = count(d in wk1)(roster[doc,d] in leave_shifts);
      var int: leave_wk2 = count(d in wk2)(roster[doc,d] in leave_shifts);

      % Count A/P/C per week
      var int: apc_wk1 = count(d in wk1)(roster[doc,d] in {a,p,c});
      var int: apc_wk2 = count(d in wk2)(roster[doc,d] in {a,p,c});

      % Totals for the fortnight
      var int: leave_total = leave_wk1 + leave_wk2;
      var int: apc_total   = apc_wk1 + apc_wk2;

      % Number of leave weeks
      var int: leave_weeks =
          (leave_wk1 > 0) +
          (leave_wk2 > 0);

      % Expected APC total
      var int: expected_apc =
        if leave_weeks = 0 then 2 * sh_per_week
        elseif leave_weeks = 1 then sh_per_week
        else 0 endif
    } in

      trace(
        "DOC=" ++ show(doc) ++
        " FN=" ++ show(fn) ++
        " wk1(leave=" ++ show(leave_wk1) ++ ", apc=" ++ show(apc_wk1) ++ ")" ++
        " wk2(leave=" ++ show(leave_wk2) ++ ", apc=" ++ show(apc_wk2) ++ ")" ++
        " leave_weeks=" ++ show(leave_weeks) ++
        " apc_total=" ++ show(apc_total) ++
        " expected=" ++ show(expected_apc) ++ "\n\n",
        apc_total = expected_apc
      )
  );


predicate shifts_1a1p1c_trace(docs: doc, int: leave_count) =
  forall(wk in weeks)(
    let {
      % -----------------------------
      % 1. Count leave days in this week
      % -----------------------------
      var int: leave_wk =
        count(d in wk)(roster[doc,d] in leave_shifts);

      % -----------------------------
      % 2. Count weekday APC (Mon–Fri)
      % -----------------------------
      var int: apc_weekday =
        count(d in wk where d mod 7 in {1,2,3,4,5})
             (roster[doc,d] in {a,p,c});

      % -----------------------------
      % 3. Count weekend APC (Sat–Sun)
      % -----------------------------
      var int: apc_weekend =
        count(d in wk where d mod 7 in {saturday,sunday})
             (roster[doc,d] in {a,p,c});

      % -----------------------------
      % 4. Boolean conditions
      % -----------------------------
      var bool: enough_leave = (leave_wk >= leave_count);
      var bool: weekday_ok   = (apc_weekday = 1);
      var bool: weekend_ok   = (apc_weekend <= 2);

      % -----------------------------
      % 5. Final rule
      % -----------------------------
      var bool: rule_ok =
        enough_leave \/ (weekday_ok /\ weekend_ok)
    } in

      % -----------------------------
      % 6. TRACE OUTPUT
      % -----------------------------
      trace(
        "\n=== 1A1P1C DIAGNOSTIC ===\n" ++
        "DOC=" ++ show(doc) ++
        "  WK=" ++ show(wk) ++ "\n" ++

        "  leave_wk      = " ++ show(leave_wk) ++ "\n" ++
        "  apc_weekday   = " ++ show(apc_weekday) ++ "\n" ++
        "  apc_weekend   = " ++ show(apc_weekend) ++ "\n" ++

        "  enough_leave  = " ++ show(enough_leave) ++ "\n" ++
        "  weekday_ok    = " ++ show(weekday_ok) ++ "\n" ++
        "  weekend_ok    = " ++ show(weekend_ok) ++ "\n" ++

        "  FINAL rule_ok = " ++ show(rule_ok) ++ "\n" ++
        "===========================\n",
        rule_ok
      )
  );

%% CONSTANTS FOR FORTNIGHT MOD 
%% CONSTANTS FOR FORTNIGHT MOD 
%% CONSTANTS FOR FORTNIGHT MOD 
%% CONSTANTS FOR FORTNIGHT MOD

int: mon1=1; int: mon2=8;
int: tue1=2; int: tue2=9;
int: wed1=3; int: wed2=10;
int: thu1=4; int: thu2=11;
int: fri1=5; int: fri2=12;
int: sat1=6; int: sat2=13;
int: sun1=7; int: sun2=0;


predicate just_sh_per_fn__(docs: doc,int: cnt ) =
  forall(fn in 1..5)(
       count([roster[doc,d]|d in fortnights[fn]],o,14-cnt*2));


predicate just_sh_per_fn(docs:doc, int:cnt) =
    count([roster[doc,d]|d in fortnights[1]],o, 14-cnt*2) /\
    count([roster[doc,d]|d in fortnights[2]],o, 14-cnt*2) /\
    count([roster[doc,d]|d in fortnights[3]],o, 14-cnt*2) /\
    count([roster[doc,d]|d in fortnights[4]],o, 14-cnt*2) /\
    count([roster[doc,d]|d in fortnights[5]],o, 14-cnt*2);

predicate just_off_per_fn(docs:doc,int: off_count)=
    count([roster[doc,d]|d in fortnights[1]],o, off_count) /\
    count([roster[doc,d]|d in fortnights[2]],o, off_count) /\
    count([roster[doc,d]|d in fortnights[3]],o, off_count) /\
    count([roster[doc,d]|d in fortnights[4]],o, off_count) /\
    count([roster[doc,d]|d in fortnights[5]],o, off_count);

%%if card(requests[doc,day])=1 then roster[doc,day] in requests[doc,day]


predicate one_request(docs:doc,days:day) =
          if card(requests[doc,day])=1 then roster[doc,day] in requests[doc,day] else false endif;



predicate each_week(docs:doc,set of shifts:MM,set of shifts:TT,set of shifts: WW,set of shifts: TH,set of shifts:FR,set of shifts:SAT,set of shifts:SUN)=
    %% each_week(gm,{c,o},{p,o},{o},{c,o},{a,o},{o},{a,o});   :: ends up being a template
    forall(d in days)(
        (roster[doc,d] in leave_shifts) \/ 
          %( if card(requests[doc,d]) in 1..2 then roster[doc,d] in requests[doc,d] else false endif) \/
          (card(requests[doc,d]) in  1..2 /\ roster[doc,d] in requests[doc,d]) \/
          (
          (d mod 7 in mondays    -> roster[doc,d] in MM)  /\
          (d mod 7 in tuesdays   -> roster[doc,d] in TT)  /\
          (d mod 7 in wednesdays -> roster[doc,d] in WW)  /\
          (d mod 7 in thursdays  -> roster[doc,d] in TH)  /\
          (d mod 7 in fridays    -> roster[doc,d] in FR)  /\
          (d mod 7 in saturdays  -> roster[doc,d] in SAT) /\
          (d mod 7 in sundays    -> roster[doc,d] in SUN)

        ));

predicate week_apc(docs:doc,set of shifts:MM,set of shifts:TT,set of shifts: WW,set of shifts: TH,set of shifts:FR,set of shifts:SAT,set of shifts:SUN,int:Alo,int:Ahi,int:Plo,int:Phi,int:Clo,int:Chi)=
 forall(wk in weeks)(
  forall(d in wk)(
    (roster[doc,d] in leave_shifts)
    \/
    (card(requests[doc,d]) in 1..2 /\ roster[doc,d] in requests[doc,d])
    \/
    (roster[doc,d] in [MM,TT,WW,TH,FR,SAT,SUN][(d - 1) mod 7 + 1])
  )
  /\
  ( sum(d in wk)(roster[doc,d] = a) >= Alo /\ sum(d in wk)(roster[doc,d] = a) <=Ahi /\
    sum(d in wk)(roster[doc,d] = p) >= Plo /\ sum(d in wk)(roster[doc,d] = p) <=Phi /\
    sum(d in wk)(roster[doc,d] = c) >= Clo /\ sum(d in wk)(roster[doc,d] = c) <=Chi
  )
);




predicate week_one(docs:doc,set of shifts:MM,set of shifts:TT,set of shifts: WW,set of shifts: TH,set of shifts:FR,set of shifts:SAT,set of shifts:SUN)=
    %%week one of fortnight template mod 14
    forall(d in days)(
        (roster[doc,d] in leave_shifts) \/
        %( if card(requests[doc,d]) in 1..2 then roster[doc,d] in requests[doc,d] else false endif) \/
        (card(requests[doc,d]) in 1..2 /\ roster[doc,d] in requests[doc,d]) \/
        
        (
          (d mod 14 = mon1  -> roster[doc,d] in MM)  /\
          (d mod 14 = tue1  -> roster[doc,d] in TT)  /\
          (d mod 14 = wed1  -> roster[doc,d] in WW)  /\
          (d mod 14 = thu1  -> roster[doc,d] in TH)  /\
          (d mod 14 = fri1  -> roster[doc,d] in FR)  /\
          (d mod 14 = sat1  -> roster[doc,d] in SAT) /\
          (d mod 14 = sun1  -> roster[doc,d] in SUN)

        ));


predicate week_two(docs:doc,set of shifts:MM,set of shifts:TT,set of shifts: WW,set of shifts: TH,set of shifts:FR,set of shifts:SAT,set of shifts:SUN)=
    %% week two of fortnight template mod 14 
    forall(d in days)(
        (roster[doc,d] in leave_shifts) \/
        %( if card(requests[doc,d]) in 1..2 then roster[doc,d] in requests[doc,d] else false endif) \/
        (card(requests[doc,d]) in 1..2 /\ roster[doc,d] in requests[doc,d]) \/
        
        (
          (d mod 14 = mon2  -> roster[doc,d] in MM)  /\
          (d mod 14 = tue2  -> roster[doc,d] in TT)  /\
          (d mod 14 = wed2  -> roster[doc,d] in WW)  /\
          (d mod 14 = thu2  -> roster[doc,d] in TH)  /\
          (d mod 14 = fri2  -> roster[doc,d] in FR)  /\
          (d mod 14 = sat2  -> roster[doc,d] in SAT) /\
          (d mod 14 = sun2  -> roster[doc,d] in SUN)

        ));

%% END FORTNIGHT MOD
        
        
        
%%ASSIGN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  SYMBOLIC ASSIGN RULES — SIMPLE, DIRECT, DECLARATIVE
%  One predicate per symbolic rule: MON_A, MON_P, TUE_A, ...
%  Usage example:
%
%  constraint
%      MON_A(doc1,1,10)
%  /\  MON_P(doc1,2,10)
%  /\  WED_A(doc1,0,0)
%  /\  WED_P(doc1,0,0)
%  /\  THU_P(doc1,2,10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%k

% Monday
predicate MON_A(docs: doc, int: low, int: hi) =
    assign_shifts(doc, monday, a, low, hi);
predicate MON_A(docs:doc)=
   MON_A(doc,0,10) /\TUE_A(doc,0,0) /\WED_A(doc,0,0) /\THU_A(doc,0,0) /\FRI_A(doc,0,0);

predicate MON_P(docs: doc, int: low, int: hi) =
    assign_shifts(doc, monday, p, low, hi);
predicate MON_P(docs:doc)=
   MON_P(doc,0,10) /\TUE_P(doc,0,0) /\WED_P(doc,0,0) /\THU_P(doc,0,0) /\FRI_P(doc,0,0);

% Tuesday
predicate TUE_A(docs: doc, int: low, int: hi) =
    assign_shifts(doc, tuesday, a, low, hi);
predicate TUE_A(docs:doc)=
   MON_A(doc,0,0) /\TUE_A(doc,0,10) /\WED_A(doc,0,0) /\THU_A(doc,0,0) /\FRI_A(doc,0,0);

predicate TUE_P(docs: doc, int: low, int: hi) =
    assign_shifts(doc, tuesday, p, low, hi);
predicate TUE_P(docs:doc)=
   MON_P(doc,0,0) /\TUE_P(doc,0,10) /\WED_P(doc,0,0) /\THU_P(doc,0,0) /\FRI_P(doc,0,0);

% Wednesday
predicate WED_A(docs: doc, int: low, int: hi) =
    assign_shifts(doc, wednesday, a, low, hi);
predicate WED_A(docs:doc)=
   MON_A(doc,0,0) /\TUE_A(doc,0,0) /\WED_A(doc,0,10) /\THU_A(doc,0,0) /\FRI_A(doc,0,0);

predicate WED_P(docs: doc, int: low, int: hi) =
    assign_shifts(doc, wednesday, p, low, hi);
predicate WED_P(docs:doc)=
   MON_P(doc,0,0) /\TUE_P(doc,0,0) /\WED_P(doc,0,10) /\THU_P(doc,0,0) /\FRI_P(doc,0,0);


% Thursday
predicate THU_A(docs: doc, int: low, int: hi) =
    assign_shifts(doc, thursday, a, low, hi);
predicate THU_A(docs:doc)=
   MON_A(doc,0,0) /\TUE_A(doc,0,0) /\WED_A(doc,0,0) /\THU_A(doc,0,10) /\FRI_A(doc,0,0);

predicate THU_P(docs: doc, int: low, int: hi) =
    assign_shifts(doc, thursday, p, low, hi);
predicate THU_P(docs:doc)=
   MON_P(doc,0,0) /\TUE_P(doc,0,0) /\WED_P(doc,0,0) /\THU_P(doc,0,10) /\FRI_P(doc,0,0);

% Friday
predicate FRI_A(docs: doc, int: low, int: hi) =
    assign_shifts(doc, friday, a, low, hi);
predicate FRI_A(docs:doc)=
   MON_A(doc,0,0) /\TUE_A(doc,0,0) /\WED_A(doc,0,0) /\THU_A(doc,0,0) /\FRI_A(doc,0,10);

predicate FRI_P(docs: doc, int: low, int: hi) =
    assign_shifts(doc, friday, p, low, hi);
predicate FRI_P(docs:doc)=
   MON_P(doc,0,0) /\TUE_P(doc,0,0) /\WED_P(doc,0,0) /\THU_P(doc,0,0) /\FRI_P(doc,0,10);

% Saturday
predicate SAT_A(docs: docs, int: low, int: hi) =
    assign_shifts(docs, saturday, a, low, hi);

predicate SAT_P(docs: docs, int: low, int: hi) =
    assign_shifts(docs, saturday, p, low, hi);

% Sunday
predicate SUN_A(docs: docs, int: low, int: hi) =
    assign_shifts(docs, sunday, a, low, hi);

predicate SUN_P(docs: docs, int: low, int: hi) =
    assign_shifts(docs, sunday, p, low, hi);






predicate MON_C(docs:doc,int:low,int:hi) =
    assign_shifts(doc,monday,c,low,hi);
predicate TUE_C(docs:doc,int:low,int:hi) =
    assign_shifts(doc,tuesday,c,low,hi);
predicate WED_C(docs:doc,int:low,int:hi) =
    assign_shifts(doc,wednesday,c,low,hi);
predicate THU_C(docs:doc,int:low,int:hi) =
    assign_shifts(doc,thursday,c,low,hi);
predicate FRI_C(docs:doc,int:low,int:hi) =
    assign_shifts(doc,friday,c,low,hi);

predicate WED_C(docs:doc)=
   MON_C(doc,0,0) /\TUE_C(doc,0,0) /\WED_C(doc,0,10) /\THU_C(doc,0,0) /\FRI_C(doc,0,0);

predicate NO_C(docs:doc)=
   MON_C(doc,0,0) /\TUE_C(doc,0,0) /\WED_C(doc,0,0) /\THU_C(doc,0,0) /\FRI_C(doc,0,0);


%%END ASSIGN RULES















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%%%%   OLD PREDICATES LEARNED A LOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%predicate dont_split_full_weekend(docs:doc) =
%                 forall( d in saturdays) 
%                 ( if on_shift(doc,d) /\ on_shift(doc,d+1) then roster[doc,d]=roster[doc,d+1]
%                   else true
%                   endif);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%predicate shifts_3a1p(docs: doc, set of int: a_week,int:leave_count)=
%      count(d in a_week)(roster[doc,d] in leave_shifts) >=leave_count   \/
%     
%      (global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {1,2,3,4,5}],[a,p],[1,1],[3,1]) /\
%      global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {saturday,sunday}],[a,p],[0,0],[4,2]));
     
 %     count(roster[doc,a_week],o,7-leave_count));
 

%predicate shifts_3a1p_with_middle_weekend(docs: doc, set of int: fortnight,int:leave_count)=
%      count(d in fortnight)(roster[doc,d] in leave_shifts) >=leave_count   \/
%     
%      (global_cardinality_low_up([roster[doc,d] | d in fortnight where d mod 14  in {1,2,3,4,5}],   [a,p],[2,1],[3,1]) /\
%      global_cardinality_low_up([roster[doc,d] | d in fortnight where d mod 14  in {8,9,10,11,12}],[a,p],[2,1],[3,1]) /\
%       global_cardinality_low_up([roster[doc,d] | d in fortnight where d mod 14 in  {6,7}],[a,p],[0,0],[2,2])   /\
%     
%     count(roster[doc,fortnight],o,14-2*leave_count));
 
 


%predicate shifts_3a1p_V2(docs: doc,int:leave_count)=
%      forall(a_week in [1..7,8..14])
%                  (count(d in a_week)(roster[doc,d] in leave_shifts) >=leave_count   \/
%                  (global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {1,2,3,4,5}],[a,p],[1,1],[3,1]) /\
%                   global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {saturday,sunday}],[a,p],[0,0],[4,2])    /\
%                   count(roster[doc,a_week],o,7-leave_count)));




%predicate shifts_2a1c1p(docs: doc, set of int: a_week,int:leave_count)=
%     count(d in a_week)(roster[doc,d] in leave_shifts) >=leave_count   \/
%     
%    (global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {1,2,3,4,5}],[a,p,c],[1,1,1],[2,1,1]) /\
%     global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0])    /\
%     
%     count(roster[doc,a_week],o,7-leave_count)); 
 
%predicate shifts_1a1p1c_including_weekends(
%  docs: doc,
%  set of int: a_week,
%  int: required_leave_count) =
%    count(d in a_week)(roster[doc,d] in leave_shifts) >= required_leave_count    \/
%    
%    (  global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {1,2,3,4,5}],[a, p, c],[0,0,1],[1,1,1]) /\
%       global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0])    /\
%       count(roster[doc,a_week],o,7 - required_leave_count));

%predicate shifts_1a1p1c_plus_weekends(
%  docs: doc,
%  set of int: a_week,
%  int: shifts_per_week) =
%    count(d in a_week)(roster[doc,d] in leave_shifts) >= shifts_per_week    \/
%    
%    (  global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {1,2,3,4,5}],[a, p, c],[1,1,1],[1,1,1]) /\
%       global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0]));

%predicate shifts_1a1p_plus_weekends(
%  docs: doc,
%  set of int: a_week,
%  int: shifts_per_week) =
%    count(d in a_week)(roster[doc,d] in leave_shifts) >= shifts_per_week    \/
%    
%    (  global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {1,2,3,4,5}],[a, p, o],[1,1,0],[1,1,0]) /\
%       global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0]));

%predicate shifts_1a1p_including_weekends(
%  docs: doc,
%  set of int: a_week,
%  int: shifts_per_week) =
%    count(d in a_week)(roster[doc,d] in leave_shifts) >= shifts_per_week    \/
    
%    (  global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {1,2,3,4,5}],[a, p, o],[1,1,0],[1,1,0]) /\
%       global_cardinality_low_up([roster[doc,d] | d in a_week where d mod 7 in {saturday,sunday}],[a,p,c],[0,0,0],[2,2,0]) /\
%       count(roster[doc,a_week],o,7-shifts_per_week));







        
           