let $rDoc := fn:doc("resume.xml")

let $sortedResumes := for $r in $rDoc/resumes/resume
		  order by $r/@rID
 		  return $r

for $resume in $sortedResumes
    let $after := for $r in $sortedResumes
	          where $r/@rID > $resume/@rID
	          return $r
    let $resumeCount := $resume/skills/count(skill)
    
    for $resume2 in $after
        let $resume2Count := $resume2/skills/count(skill)
        let $intersectionCount := count(
                                for $skill2 in $resume2/skills/skill
                                where some $skill in $resume/skills/skill satisfies
                                    $skill/@level=$skill2/@level  
                                return $skill2/@what
                                )
        where $intersectionCount=$resumeCount or $intersectionCount=$resume2Count
        return ($resume/@rID, $resume2/@rID)
