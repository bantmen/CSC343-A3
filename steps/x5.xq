let $pDoc := fn:doc("posting.xml")
let $rDoc := fn:doc("resume.xml")

let $totalCount := $rDoc/resumes/count(resume)

for $p in $pDoc/postings/posting
let $currentResumes :=
	distinct-values(
	for $pSkill in $p/reqSkill
		for $resume in $rDoc/resumes/resume
		where some $rSkill in $resume/skills/skill satisfies $rSkill=$pSkill
		return $resume/@rID
	)
return $currentResumes

