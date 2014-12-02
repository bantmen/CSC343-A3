for $r in fn:doc("resume.xml")//resume  
return
if ($r//skills/count(skill)>3) then ($r/@rID, $r/identification/name/forename/text(), $r//skills/count(skill))
else ()
