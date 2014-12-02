distinct-values( 
for $i in fn:doc("interview.xml")/interviews/interview
return
if ($i/assessment/count(collegiality)=0) then ($i/@sID)
else ()
) 
