-- Sets Pivot of each object selected to the bottom, min Z, of the object.

for i in selection do (i.pivot = ((i.max + i.min)/2))

for i in selection do ((i.pivot.z = i.min.z))

