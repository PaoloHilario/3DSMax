macroScript RayFireLauncher
category:"Mir"
tooltip:"Launch RayFire"
buttontext:"Launch RayFire"
Icon:#("rayfire",1)
(
	on execute do
	(
		try(If RayFireMain == undefined do StAuthRf.Launch ()) catch ()
	)
)
