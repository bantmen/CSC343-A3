let $iDoc := fn:doc("interview.xml")
let $rDoc := fn:doc("resume.xml")
let $pDoc := fn:doc("posting.xml")

let $interviewTag :=

for $interview in $iDoc/interviews/interview
let $resume := $rDoc/resumes/resume[@rID=$interview/@rID]
let $posting := $pDoc/postings/posting[@pID=$interview/@pID]
let $match := sum(
              for $reqSkill in $posting/reqSkill
              return
              if (some $skill in $resume/skills/skill satisfies $skill/@what=$reqSkill/@what and $skill/@level>=$reqSkill/@level) 
              then ($reqSkill/@importance)
              else (-1*$reqSkill/@importance)
              )
let $sum1 := xs:double(sum(
             for $answer in $interview/assessment/answers/answer
             return ($answer) 
             ))
let $count1 :=  for $a in (1)
                return
                if ($interview/assessment/answers)
                then ($interview/assessment/answers/count(answer))
                else (0)
let $sum2 := sum(
             for $rest in $interview/assessment/*
             where $rest/name() != "answers" and $rest/name() != "answer"
             return xs:integer($rest)   
             )
let $count2 := count(
               for $rest in $interview/assessment/*
               where $rest/name() != "answers"
               return 1
               )
let $average := ($sum1+$sum2) div ($count1+$count2)
return 
<interview>
<who rID="{$resume/@rID}" forename="{data($resume//identification/name/forename)}" surname="{data($resume//identification/name/surname)}"/>
<position>{data($posting/position)}</position>
<match>{$match}</match>
<average>{$average}</average>
</interview>

return <report>{$interviewTag}</report>
