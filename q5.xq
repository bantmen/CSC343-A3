let $pDoc := fn:doc("posting.xml")
let $rDoc := fn:doc("resume.xml")

let $totalCount := $rDoc/resumes/count(resume)

for $p in $pDoc/postings/posting
where some $reqSkill in $p/reqSkill satisfies $totalCount div 2>count(
    for $resume in $rDoc/resumes/resume
    where some $skill in $resume/skills/skill satisfies $skill/@what=$reqSkill/@what
    return $resume/@rID
) or
count(
    for $resume in $rDoc/resumes/resume
    where some $skill in $resume/skills/skill satisfies $skill/@what=$reqSkill/@what
    return $resume/@rID
) div 2 >count(
    for $resume in $rDoc/resumes/resume
    where some $skill in $resume/skills/skill satisfies $skill/@what=$reqSkill/@what and $skill/@level>3
    return $resume/@rID
) 
return $p/@pID


