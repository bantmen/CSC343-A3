let $pDoc := fn:doc("posting.xml")
let $rDoc := fn:doc("resume.xml")

let $totalCount := $rDoc/resumes/count(resume)

for $p in $pDoc//posting
where some $skill in $p/reqSkill/@what satisfies $totalCount div 2>count(
	for $r in $rDoc/resumes/resume/skills/skill
	where some $rSkill in $r satisfies $rSkill/@what=$skill
	return $r/../../@rID
	)
return $p/@rID
