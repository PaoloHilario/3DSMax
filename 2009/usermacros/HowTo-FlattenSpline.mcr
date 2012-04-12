macroScript FlattenSpline category:"HowTo" tooltip:"Flatten Spline"

(

on isEnabled return 

(

 selection.count == 1 and \

 (classof selection[1] == SplineShape or \

 classof selection[1] == Line) \

 and selection[1].modifiers.count == 0

)

on execute do

(

 new_z = $.pos.z

 for s = 1 to (numSplines $) do

 (

  for k = 1 to (numKnots $ s) do

  (

   knt = getKnotPoint $ s k

   in_vec = getInVec $ s k

   out_vec = getOutVec $ s k

   knt.z = in_vec.z = out_vec.z = new_z

   setInVec $ s k in_vec

   setOutVec $ s k out_vec

   setKnotPoint $ s k knt

  )--end k loop

 )--end s loop

updateshape $

)--end execute

)--end script
