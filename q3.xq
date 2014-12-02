let $rMax := fn:doc("posting.xml")/postings/posting/max(reqSkill/@importance)
for $i in fn:doc("posting.xml")/postings/posting/reqSkill
where $i/@importance = $rMax
return ($i/@what, $i/@importance)
