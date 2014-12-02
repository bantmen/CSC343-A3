let $rDoc := fn:doc("resume.xml")

let $sortedResumes := for $r in $rDoc/resumes/resume
                      order by $r/@rID
                      return $r

for $resume in $sortedResumes, $resume2 in $sortedResumes except $resume
    (: let $intersection := count(
                         for $skill in $resume/skills/skill
                         where some $skill2 in $resume2/skills/skill satisfies
                         $skill/@what=$skill2/@what and $skill/@level=$skill2/@level
                         return 1
                         )
    let $intersection2 := count(
                         for $skill2 in $resume2/skills/skill
                         where some $skill in $resume/skills/skill satisfies
                         $skill/@what=$skill2/@what and $skill/@level=$skill2/@level
                         return 1
                         ) :)
    let $rCount := $resume/skills/count(skill)
    let $rCount2 := $resume2/skills/count(skill) 
    let $intersection := for $skill in $resume/skills/skill
                         where some $skill2 in $resume2/skills/skill satisfies
                         $skill/@what=$skill2/@what
                         return $skill/@what    
    let $iCount := count($intersection)
    let $count := count(
                  for $i in $intersection
                  for $s in $resume/skills/skill
                  where $s/@what=$i and some $skill2 in $resume2/skills/skill satisfies
                  $skill2/@what=$i and $skill2/@level=$s/@level
                  return 1
                  )                  
    where $resume/@rID<$resume2/@rID and $iCount=$count and $rCount>0 and $rCount2>0 and $iCount>0 
  (:  return ($resume/@rID, $resume2/@rID) :)
    return ($resume/@rID, $resume2/@rID)
