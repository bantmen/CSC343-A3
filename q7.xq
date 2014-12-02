let $pDoc := fn:doc("posting.xml")
let $rDoc := fn:doc("resume.xml")

let $totalSkills := distinct-values(
                    for $reqSkill in $pDoc//reqSkill
                    return $reqSkill/@what
                    )

let $skillTag :=

for $r in $totalSkills
    let $reqSkill := xs:string($r)
    let $countTag := 
        for $level in (1 to 5)
        let $count := count(
                      for $s in $rDoc/resumes/resume/skills/skill
                      where $s/@what=$reqSkill and $s/@level=$level
                      return $s
                      )
        return <count level="{$level}" n="{$count}"/>  
    return <skill name="{$reqSkill}"> {$countTag} </skill>

return <skills> {$skillTag} </skills>
