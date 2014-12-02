distinct-values(
for $p in fn:doc("posting.xml")/postings/posting/reqSkill
let $skill := $p/@what
let $lvl := $p/@level
(: for $r in fn:doc("resume.xml")/resumes/resume/skills/skill :) 
where not(some $r in fn:doc("resume.xml")/resumes/resume/skills/skill satisfies $r/@what=$skill and $r/@level>=$lvl)
(: return ($skill, $lvl) :)
return $p/../@pID
)
