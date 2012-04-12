--@Sets pivot of object selected to
--@point selected by user.
--@Select object, run script and
--@pick a point.  The Objects pivot
--@will be set to that point.

(
if (selection.count ==1) then
   (
   try
      (
      pt = pickpoint prompt:"Click to desired location." snap:#3d
      selection[1].pivot = pt
      )catch()
   )
)
